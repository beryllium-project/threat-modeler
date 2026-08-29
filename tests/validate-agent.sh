#!/usr/bin/env bash

set -u
export LC_ALL=C

repository_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd -P) || {
    printf 'validate-agent: ERROR: cannot resolve repository root\n' >&2
    exit 2
}
cd -- "$repository_root" || exit 2

fixture=$repository_root/tests/fixtures/valid-model/TM-20000101-001-fixture-model
discovery_fixture=$repository_root/tests/fixtures/discovery-target

pass_count=0
fail_count=0

pass() {
    pass_count=$((pass_count + 1))
    printf 'ok   %s\n' "$*"
}

fail() {
    fail_count=$((fail_count + 1))
    printf 'FAIL %s\n' "$*"
}

sandbox=$(mktemp -d "${TMPDIR:-/tmp}/threat-modeler-tests.XXXXXX") || exit 2
cleanup() {
    rm -rf -- "$sandbox"
}
trap cleanup EXIT
trap 'exit 1' HUP INT TERM

require_file() {
    if [[ -f $1 ]]; then
        pass "file exists: ${1#"$repository_root/"}"
    else
        fail "file is missing: ${1#"$repository_root/"}"
    fi
}

require_executable() {
    if [[ -x $1 ]]; then
        pass "file is executable: ${1#"$repository_root/"}"
    else
        fail "file is not executable: ${1#"$repository_root/"}"
    fi
}

require_text() {
    if grep -Fq -- "$2" "$1"; then
        pass "${1#"$repository_root/"} states: $2"
    else
        fail "${1#"$repository_root/"} does not state: $2"
    fi
}

require_pattern() {
    if grep -Eq -- "$2" "$1"; then
        pass "${1#"$repository_root/"} matches: $2"
    else
        fail "${1#"$repository_root/"} does not match: $2"
    fi
}

refute_pattern() {
    if grep -Eq -- "$2" "$1"; then
        fail "${1#"$repository_root/"} must not match: $2"
    else
        pass "${1#"$repository_root/"} does not match: $2"
    fi
}

expect_pass() {
    local description=$1
    shift
    if "$@" >/dev/null 2>&1; then
        pass "$description"
    else
        fail "$description (expected success, command failed)"
    fi
}

expect_fail() {
    local description=$1
    shift
    if "$@" >/dev/null 2>&1; then
        fail "$description (expected failure, command succeeded)"
    else
        pass "$description"
    fi
}

expect_message() {
    local description=$1 needle=$2
    shift 2
    local output
    output=$("$@" 2>&1)
    if (($? == 0)); then
        fail "$description (expected failure, command succeeded)"
        return
    fi
    if printf '%s' "$output" | grep -Fq -- "$needle"; then
        pass "$description"
    else
        fail "$description (missing expected message: $needle)"
    fi
}

copy_validation_root() {
    local root
    root=$(mktemp -d "$sandbox/validation.XXXXXX") || exit 2
    mkdir -p -- "$root/scripts" "$root/models"
    cp -- "$repository_root"/scripts/*.sh "$root/scripts/"
    chmod +x "$root"/scripts/*.sh
    cp -R -- "$fixture" "$root/models/"
    printf '%s' "$root"
}

validate_case() {
    local root=$1
    shift
    "$root/scripts/validate-threat-model.sh" "$@" \
        models/TM-20000101-001-fixture-model
}

printf '\n== repository contract ==\n'

for required in \
    .github/copilot-instructions.md \
    .github/agents/threat-modeler.agent.md \
    .github/agents/threat-evidence.agent.md \
    .github/agents/threat-research.agent.md \
    .github/agents/threat-model-review.agent.md \
    .github/skills/beryllium-threat-modeling/SKILL.md \
    README.md \
    AGENT-INTERFACE.md \
    RESEARCH-SOURCES.md \
    HANDOFF.md \
    THREAT-MODELS.md \
    SOURCE-DISCOVERY-LOG.md \
    outbox/pm-queue.md \
    .gitignore; do
    require_file "$repository_root/$required"
done

for template in scope discovery threat-model review evidence-ledger search-log \
    open-questions inaccessible-resources source-discoveries \
    publication-checklist HANDOFF model-iteration review-iteration; do
    require_file "$repository_root/templates/$template.md"
done

for template in system-context trust-boundaries data-flows attack-tree; do
    require_file "$repository_root/templates/$template.dot"
done

for script in new-threat-model readonly-inspect discover-threat-material \
    render-diagrams update-index validate-threat-model; do
    require_file "$repository_root/scripts/$script.sh"
    require_executable "$repository_root/scripts/$script.sh"
    expect_pass "scripts/$script.sh parses" bash -n \
        "$repository_root/scripts/$script.sh"
done
expect_pass "tests/validate-agent.sh parses" bash -n \
    "$repository_root/tests/validate-agent.sh"

printf '\n== agent declarations and boundaries ==\n'

orchestrator=$repository_root/.github/agents/threat-modeler.agent.md
require_pattern "$orchestrator" '^name: threat-modeler$'
require_pattern "$orchestrator" '^user-invocable: true$'
require_pattern "$orchestrator" '^disable-model-invocation: true$'
for tool in read search execute edit agent web ask_user; do
    require_pattern "$orchestrator" "\"$tool\""
done
require_text "$orchestrator" '/beryllium-threat-modeling'
require_text "$orchestrator" 'discover-threat-material.sh'
require_text "$orchestrator" 'Review and draft successor'
require_text "$orchestrator" 'target execution'

for specialist in threat-evidence threat-research threat-model-review; do
    agent=$repository_root/.github/agents/$specialist.agent.md
    require_pattern "$agent" "^name: $specialist\$"
    require_pattern "$agent" '^user-invocable: false$'
    refute_pattern "$agent" '"edit"'
    refute_pattern "$agent" '"execute"'
    refute_pattern "$agent" '"agent"'
done
require_pattern "$repository_root/.github/agents/threat-research.agent.md" '"web"'
refute_pattern "$repository_root/.github/agents/threat-evidence.agent.md" '"web"'
refute_pattern "$repository_root/.github/agents/threat-model-review.agent.md" '"web"'

instructions=$repository_root/.github/copilot-instructions.md
skill=$repository_root/.github/skills/beryllium-threat-modeling/SKILL.md
for document in "$instructions" "$skill" "$orchestrator" \
    "$repository_root/README.md" "$repository_root/AGENT-INTERFACE.md" \
    "$repository_root/RESEARCH-SOURCES.md" "$repository_root/HANDOFF.md"; do
    refute_pattern "$document" '(^|[^A-Za-z0-9_])(/home/|/Users/|/root/)'
done
for phrase in 'read-only' 'untrusted evidence' 'TM-YYYYMMDD-NNN' \
    'private' 'NOT RUN' 'not formally verified' 'risk acceptance'; do
    require_text "$instructions" "$phrase"
done
require_text "$skill" 'STRIDE'
require_text "$skill" 'MODEL-ITERATION-NNN'
require_text "$skill" 'SEARCH-NNN'
require_text "$skill" 'EFFECTIVE THREAT-MODEL SCOPE'
require_text "$skill" 'Review existing model'

printf '\n== package scaffolding ==\n'

scaffold=$sandbox/scaffold
mkdir -p -- "$scaffold/scripts" "$scaffold/templates" "$scaffold/models"
cp -- "$repository_root"/scripts/*.sh "$scaffold/scripts/"
cp -- "$repository_root"/templates/* "$scaffold/templates/"
chmod +x "$scaffold"/scripts/*.sh

expect_fail "new-threat-model rejects a missing argument" \
    "$scaffold/scripts/new-threat-model.sh"
expect_fail "new-threat-model rejects an uppercase slug" \
    "$scaffold/scripts/new-threat-model.sh" Bad-Slug "Bad slug" \
    create-from-evidence
expect_fail "new-threat-model rejects an unknown mode" \
    "$scaffold/scripts/new-threat-model.sh" good-slug "Good title" unknown

first=$(cd "$scaffold" &&
    scripts/new-threat-model.sh first-model "First model" create-from-evidence)
second=$(cd "$scaffold" &&
    scripts/new-threat-model.sh second-model "Second model" review-existing)
if [[ $first == models/TM-*-001-first-model &&
    $second == models/TM-*-002-second-model ]]; then
    pass "new-threat-model allocates collision-safe daily package IDs"
else
    fail "new-threat-model returned unexpected paths: $first $second"
fi

expect_pass "scaffolded package passes draft validation" \
    bash -c "cd '$scaffold' && scripts/validate-threat-model.sh --draft '$first'"
expect_fail "scaffolded package fails completion validation" \
    bash -c "cd '$scaffold' && scripts/validate-threat-model.sh '$first'"
expect_pass "scaffolded diagrams render" \
    bash -c "cd '$scaffold' && scripts/render-diagrams.sh '$first'"
expect_pass "render --check accepts current scaffold diagrams" \
    bash -c "cd '$scaffold' && scripts/render-diagrams.sh --check '$first'"
expect_pass "update-index regenerates a package index" \
    bash -c "cd '$scaffold' && scripts/update-index.sh"
expect_pass "update-index --check accepts a current index" \
    bash -c "cd '$scaffold' && scripts/update-index.sh --check"
printf 'stale\n' >>"$scaffold/THREAT-MODELS.md"
expect_fail "update-index --check rejects a stale index" \
    bash -c "cd '$scaffold' && scripts/update-index.sh --check"

printf '\n== completed package validation ==\n'

root=$(copy_validation_root)
expect_pass "complete fixture passes completion validation" \
    bash -c "cd '$root' && scripts/validate-threat-model.sh models/TM-20000101-001-fixture-model"
expect_pass "complete fixture passes draft validation" \
    bash -c "cd '$root' && scripts/validate-threat-model.sh --draft models/TM-20000101-001-fixture-model"
expect_pass "complete fixture passes baseline validation against itself" \
    bash -c "cd '$root' && scripts/validate-threat-model.sh --baseline models/TM-20000101-001-fixture-model models/TM-20000101-001-fixture-model"

root=$(copy_validation_root)
sed -i 's/^- Inherent risk: Critical$/- Inherent risk: Low/' \
    "$root/models/TM-20000101-001-fixture-model/threat-model.md"
expect_message "rejects an inconsistent risk band" \
    'inconsistent inherent risk' \
    bash -c "cd '$root' && scripts/validate-threat-model.sh models/TM-20000101-001-fixture-model"

root=$(copy_validation_root)
sed -i '0,/TM-20000101-001-E0002/s//TM-20000101-001-E0099/' \
    "$root/models/TM-20000101-001-fixture-model/review.md"
expect_message "rejects a dangling evidence reference" \
    'evidence reference is not defined' \
    bash -c "cd '$root' && scripts/validate-threat-model.sh models/TM-20000101-001-fixture-model"

root=$(copy_validation_root)
sed -i '/^- Confidence basis: Direct synthetic design statement\.$/d' \
    "$root/models/TM-20000101-001-fixture-model/evidence-ledger.md"
expect_message "rejects an incomplete evidence record" \
    'missing Confidence basis' \
    bash -c "cd '$root' && scripts/validate-threat-model.sh models/TM-20000101-001-fixture-model"

root=$(copy_validation_root)
sed -i '/^- Residual rationale: /d' \
    "$root/models/TM-20000101-001-fixture-model/threat-model.md"
expect_message "rejects a threat without residual-risk rationale" \
    'missing Residual rationale' \
    bash -c "cd '$root' && scripts/validate-threat-model.sh models/TM-20000101-001-fixture-model"

root=$(copy_validation_root)
sed -i '/^- Fact label: Established$/d' \
    "$root/models/TM-20000101-001-fixture-model/review.md"
expect_message "rejects a review finding without a fact label" \
    'missing Fact label' \
    bash -c "cd '$root' && scripts/validate-threat-model.sh models/TM-20000101-001-fixture-model"

root=$(copy_validation_root)
rm -- "$root/models/TM-20000101-001-fixture-model/discovery.md"
expect_message "rejects a missing required artifact" \
    'required package artifact is missing' \
    bash -c "cd '$root' && scripts/validate-threat-model.sh models/TM-20000101-001-fixture-model"

root=$(copy_validation_root)
printf '\nEvidence copy: /home/example/private.txt\n' \
    >>"$root/models/TM-20000101-001-fixture-model/review.md"
expect_message "rejects an absolute workstation path" \
    'absolute workstation path' \
    bash -c "cd '$root' && scripts/validate-threat-model.sh models/TM-20000101-001-fixture-model"

root=$(copy_validation_root)
find "$root/models/TM-20000101-001-fixture-model" -type f -name '*.md' \
    -exec sed -i 's/Distribution: `private`/Distribution: `internal`/' {} +
expect_message "rejects promotion without a human record" \
    'checklist item' \
    bash -c "cd '$root' && scripts/validate-threat-model.sh models/TM-20000101-001-fixture-model"

root=$(copy_validation_root)
printf '\nchanged\n' \
    >>"$root/models/TM-20000101-001-fixture-model/iterations/MODEL-ITERATION-001.md"
expect_message "rejects an edited append-only iteration" \
    'append-only iteration changed' \
    bash -c "cd '$root' && scripts/validate-threat-model.sh --baseline '$fixture' models/TM-20000101-001-fixture-model"

root=$(copy_validation_root)
sed -i 's/TM-20000101-001 system context/TM-20000101-001 changed context/' \
    "$root/models/TM-20000101-001-fixture-model/diagrams/system-context.dot"
expect_message "rejects a stale generated diagram" \
    'generated diagrams are missing or stale' \
    bash -c "cd '$root' && scripts/validate-threat-model.sh models/TM-20000101-001-fixture-model"

printf '\n== deterministic discovery and read-only inspection ==\n'

workspace=$sandbox/workspace
component=$workspace/beryllium-repo
toolroot=$workspace/threat-modeler
mkdir -p -- "$workspace" "$component" "$toolroot/scripts"
cp -- "$repository_root/scripts/readonly-inspect.sh" \
    "$repository_root/scripts/discover-threat-material.sh" "$toolroot/scripts/"
chmod +x "$toolroot"/scripts/*.sh
cp -R -- "$discovery_fixture"/. "$component/"

git -C "$workspace" init -q -b main
git -C "$workspace" config user.name Fixture
git -C "$workspace" config user.email fixture@example.invalid
printf 'fixture workspace\n' >"$workspace/README.md"
git -C "$workspace" add README.md
git -C "$workspace" commit -q -m 'fixture workspace'

git -C "$component" init -q -b main
git -C "$component" config user.name Fixture
git -C "$component" config user.email fixture@example.invalid
git -C "$component" add .
git -C "$component" commit -q -m 'fixture target'

head_before=$(git -C "$component" rev-parse HEAD)
status_before=$(git -C "$component" status --porcelain)
index_before=$(sha256sum "$component/.git/index")
output=$(
    cd "$toolroot" &&
        scripts/discover-threat-material.sh component beryllium-repo HEAD
)
head_after=$(git -C "$component" rev-parse HEAD)
status_after=$(git -C "$component" status --porcelain)
index_after=$(sha256sum "$component/.git/index")

if [[ $head_before == "$head_after" && $status_before == "$status_after" &&
    $index_before == "$index_after" ]]; then
    pass "discovery leaves target HEAD, worktree, and index unchanged"
else
    fail "discovery changed target state"
fi

for needle in \
    'partial or embedded threat model' \
    'model delta' \
    'security or assurance review' \
    'component://beryllium-repo/implementation-plan.md' \
    'component://beryllium-repo/pathfinder-evidence.md'; do
    if printf '%s\n' "$output" | grep -Fq -- "$needle"; then
        pass "discovery reports: $needle"
    else
        fail "discovery output is missing: $needle"
    fi
done
if printf '%s\n' "$output" | grep -Fq 'restricted-microsoft'; then
    fail "discovery must exclude restricted-microsoft"
else
    pass "discovery excludes restricted-microsoft"
fi

expect_fail "readonly-inspect rejects an unregistered component" \
    "$toolroot/scripts/readonly-inspect.sh" state not-registered
expect_fail "readonly-inspect rejects a malformed revision" \
    "$toolroot/scripts/readonly-inspect.sh" resolve beryllium-repo \
    --upload-pack=bad
expect_fail "readonly-inspect rejects path traversal" \
    "$toolroot/scripts/readonly-inspect.sh" show beryllium-repo HEAD ../escape
expect_fail "readonly-inspect rejects restricted source paths" \
    "$toolroot/scripts/readonly-inspect.sh" show beryllium-repo HEAD \
    sources/restricted-microsoft/secret.md
expect_fail "readonly-inspect rejects nested restricted source paths" \
    "$toolroot/scripts/readonly-inspect.sh" show beryllium-repo HEAD \
    nested/sources/restricted-microsoft/secret.md

printf '\n== generated repository state ==\n'

expect_pass "committed THREAT-MODELS.md is current" \
    "$repository_root/scripts/update-index.sh" --check

printf '\n%d passed, %d failed\n' "$pass_count" "$fail_count"
((fail_count == 0)) || exit 1
