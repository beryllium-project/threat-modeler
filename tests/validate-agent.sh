#!/usr/bin/env bash

set -u
export LC_ALL=C

repository_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd -P) || {
    printf 'validate-agent: ERROR: cannot resolve repository root\n' >&2
    exit 2
}
cd -- "$repository_root" || exit 2

agents_only=false
case "$#" in
0) ;;
1)
    if [[ $1 != --agents-only ]]; then
        printf 'Usage: tests/validate-agent.sh [--agents-only]\n' >&2
        exit 2
    fi
    agents_only=true
    ;;
*)
    printf 'Usage: tests/validate-agent.sh [--agents-only]\n' >&2
    exit 2
    ;;
esac

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

finish() {
    printf '\n%d passed, %d failed\n' "$pass_count" "$fail_count"
    ((fail_count == 0)) || exit 1
    exit 0
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

flatten_text() {
    tr -s '[:space:]' ' ' <"$1"
}

require_flat_text() {
    if flatten_text "$1" | grep -Fq -- "$2"; then
        pass "${1#"$repository_root/"} states across line wraps: $2"
    else
        fail "${1#"$repository_root/"} does not state across line wraps: $2"
    fi
}

refute_flat_text() {
    if flatten_text "$1" | grep -Fq -- "$2"; then
        fail "${1#"$repository_root/"} must not state across line wraps: $2"
    else
        pass "${1#"$repository_root/"} does not state across line wraps: $2"
    fi
}

frontmatter_tools_equal() {
    awk -v expected="$2" '
        NR == 1 {
            if ($0 != "---") exit 1
            next
        }
        $0 == "---" { closed = 1; exit }
        /^tools:/ {
            count++
            if ($0 == expected) allowed = 1
        }
        END { exit !(closed && count == 1 && allowed) }
    ' "$1"
}

extract_fenced_block_after() {
    local file=$1 heading=$2
    awk -v heading="$heading" '
        $0 == heading {
            found = 1
            next
        }
        found && !opened && $0 == "```yaml" {
            opened = 1
            next
        }
        opened && $0 == "```" {
            closed = 1
            exit
        }
        opened { print }
        END { exit !(found && opened && closed) }
    ' "$file"
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
    .github/agents/threat-model-maintainer.agent.md \
    .github/agents/threat-modeler-owner.agent.md \
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

maintainer=$repository_root/.github/agents/threat-model-maintainer.agent.md
maintainer_tools='tools: ["read", "search", "execute", "edit", "ask_user"]'
require_pattern "$maintainer" '^name: threat-model-maintainer$'
require_pattern "$maintainer" '^user-invocable: true$'
require_pattern "$maintainer" '^disable-model-invocation: true$'
expect_pass "threat-model-maintainer has its explicit maintenance tool allowlist" \
    frontmatter_tools_equal "$maintainer" "$maintainer_tools"
require_text "$maintainer" 'explicit user authorization'
require_text "$maintainer" 'git diff --check'
require_text "$maintainer" 'Co-authored-by: Copilot'
require_text "$maintainer" 'push that branch'
require_text "$maintainer" '/agent threat-modeler'

owner=$repository_root/.github/agents/threat-modeler-owner.agent.md
owner_tools='tools: ["read", "search", "execute", "edit"]'
require_pattern "$owner" '^name: threat-modeler-owner$'
require_pattern "$owner" '^model: claude-opus-5\.5$'
require_pattern "$owner" '^user-invocable: false$'
require_pattern "$owner" '^disable-model-invocation: false$'
expect_pass "threat-modeler-owner has its exact maintenance tool allowlist" \
    frontmatter_tools_equal "$owner" "$owner_tools"
for phrase in \
    'exactly one open request ID directly assigned to `threat-modeler`' \
    'source Project Manager commit and request blob' \
    'bound tasking SOT SHA-256' \
    'expected branch and pre-edit HEAD' \
    'sole-writer' \
    'tests/validate-agent.sh' \
    'exact-path staging' \
    'local work commit' \
    'local return commit' \
    'OWNER_AGENT_RESPONSE_V1' \
    'HANDOFF.md' \
    'reasoning effort `max`' \
    'context `long_context`'; do
    require_text "$owner" "$phrase"
done
refute_pattern "$owner" 'beryllium-threat-modeling'
refute_pattern "$owner" 'scripts/'

owner_response_expected=$sandbox/owner-response-expected.yml
cat >"$owner_response_expected" <<'EOF'
protocol: OWNER_AGENT_RESPONSE_V1
component: <component>
owner_profile: <component>-owner
request_id: PMR-NNN

source:
  pm_commit: <commit>
  request_blob: <blob>
  expected_component_head: <commit>

state: progress | needs_human | completed | partial | blocked | refused
summary: <concise result or current position>

work:
  commits: []
  paths: []

handoff:
  path: <component-relative handoff path>
  checkpoint_commit: <commit-or-null>

validation:
  - command: <exact command or check>
    result: passed | failed | not_run
    note: <known failure or boundary>

repository:
  branch: <branch>
  head: <commit>
  clean: true | false
  upstream: <value-or-unknown>
  ahead: <integer-or-unknown>
  behind: <integer-or-unknown>
  active_session: self | none | other | unknown

requested_pm_action: continue | ask_human | verify_return | open_followup | record_blocker | none
question: null
push: null
EOF
owner_response_actual=$sandbox/owner-response-actual.yml
if extract_fenced_block_after "$owner" '### Base response schema' \
    >"$owner_response_actual"; then
    pass "extracts the owner live-response schema"
else
    fail "cannot extract the owner live-response schema"
fi
expect_pass \
    "owner live-response schema has every exact required field and no aliases" \
    cmp -s "$owner_response_expected" "$owner_response_actual"
expect_pass "owner live-response schema defines all six exact live states" \
    grep -Fxq \
    'state: progress | needs_human | completed | partial | blocked | refused' \
    "$owner_response_actual"
expect_pass "owner live-response schema fixes push to null" \
    grep -Fxq 'push: null' "$owner_response_actual"

owner_question_expected=$sandbox/owner-question-expected.yml
cat >"$owner_question_expected" <<'EOF'
question:
  id: PMR-NNN-QNN
  kind: authorization | gate | priority | choice | missing_fact
  prompt: <one short human-facing question>
  blocking_reason: <why progress requires the answer>
  choices:
    - value: <stable value>
      label: <plain-language choice>
  recommended: <choice-value>
  exact_scope:
    operation: <operation-or-null>
    repository: <repository-or-null>
    target: <command-artifact-or-ref-tuple-or-null>
  authorizes: <exact effect of an affirmative answer>
  does_not_authorize: <explicit preserved boundaries>
EOF
owner_question_actual=$sandbox/owner-question-actual.yml
if extract_fenced_block_after "$owner" '### needs_human question schema' \
    >"$owner_question_actual"; then
    pass "extracts the owner needs-human question schema"
else
    fail "cannot extract the owner needs-human question schema"
fi
expect_pass "owner needs-human question has the exact structured fields" \
    cmp -s "$owner_question_expected" "$owner_question_actual"

owner_invariants_expected=$sandbox/owner-invariants-expected.yml
cat >"$owner_invariants_expected" <<'EOF'
progress:
  writes_repository: false
  work:
    commits: []
    paths: []
  handoff:
    checkpoint_commit: null
  question: null
  push: null
completed:
  work:
    commits:
      - <work-commit>
      - <return-commit>
    paths:
      - <exact-changed-path>
  validation:
    - <exact-validation-result>
  handoff:
    checkpoint_commit: <return-commit>
  repository:
    clean: true
  requested_pm_action: verify_return
  question: null
  push: null
durable_results:
  - completed
  - partial
  - blocked
  - needs_human
  - refused
  - information
EOF
owner_invariants_actual=$sandbox/owner-invariants-actual.yml
if extract_fenced_block_after "$owner" '### State invariants' \
    >"$owner_invariants_actual"; then
    pass "extracts the owner state-invariant schema"
else
    fail "cannot extract the owner state-invariant schema"
fi
expect_pass \
    "owner invariants enforce progress, completed, and durable-result contracts" \
    cmp -s "$owner_invariants_expected" "$owner_invariants_actual"

for document in \
    "$repository_root/.github/copilot-instructions.md" \
    "$repository_root/README.md" \
    "$repository_root/AGENT-INTERFACE.md"; do
    require_text "$document" 'threat-modeler-owner'
    require_text "$document" 'OWNER_AGENT_RESPONSE_V1'
done

local_tools='tools: ["view", "glob", "grep", "rg"]'
research_tools='tools: ["view", "glob", "grep", "rg", "web_fetch", "web_search"]'
for specialist in threat-evidence threat-research threat-model-review; do
    agent=$repository_root/.github/agents/$specialist.agent.md
    require_pattern "$agent" "^name: $specialist\$"
    require_pattern "$agent" '^user-invocable: false$'
    expected_tools=$local_tools
    if [[ $specialist == threat-research ]]; then
        expected_tools=$research_tools
    fi
    expect_pass "$specialist has only its explicit read-only tool allowlist" \
        frontmatter_tools_equal "$agent" "$expected_tools"
    require_text "$agent" 'actually callable'
done
require_text "$repository_root/.github/agents/threat-research.agent.md" \
    'general web search and direct URL retrieval'

tool_fixture=$sandbox/tool-profile.agent.md
for expected_tools in "$local_tools" "$research_tools"; do
    printf '%s\n' '---' 'name: fixture' "$expected_tools" '---' \
        >"$tool_fixture"
    expect_pass "accepts explicit specialist tools: $expected_tools" \
        frontmatter_tools_equal "$tool_fixture" "$expected_tools"

    for forbidden_tools in \
        'tools: ["read", "search"]' \
        'tools: ["read", "search", "web"]' \
        'tools: ["*"]' \
        'tools: []' \
        'tools: ["view", "glob", "grep", "rg", "bash"]' \
        'tools: ["view", "glob", "grep", "rg", "apply_patch"]' \
        'tools: ["view", "glob", "grep", "rg", "task"]' \
        'tools: ["view", "glob", "grep", "rg", "github/*"]'; do
        printf '%s\n' '---' 'name: fixture' "$forbidden_tools" '---' \
            >"$tool_fixture"
        expect_fail "rejects noncanonical specialist tools: $forbidden_tools" \
            frontmatter_tools_equal "$tool_fixture" "$expected_tools"
    done

    printf '%s\n' '---' 'name: fixture' '---' "$expected_tools" \
        >"$tool_fixture"
    expect_fail "rejects missing tools despite a matching body line" \
        frontmatter_tools_equal "$tool_fixture" "$expected_tools"
    printf '%s\n' '---' 'name: fixture' "$expected_tools" \
        'tools: ["*"]' '---' >"$tool_fixture"
    expect_fail "rejects duplicate tools declarations" \
        frontmatter_tools_equal "$tool_fixture" "$expected_tools"
    printf '%s\n' '---' 'name: fixture' "$expected_tools" \
        >"$tool_fixture"
    expect_fail "rejects unterminated agent frontmatter" \
        frontmatter_tools_equal "$tool_fixture" "$expected_tools"
done

expect_fail "local specialists cannot acquire the research web tools" \
    frontmatter_tools_equal \
    "$repository_root/.github/agents/threat-research.agent.md" "$local_tools"
expect_fail "research cannot silently lose its web tools" \
    frontmatter_tools_equal \
    "$repository_root/.github/agents/threat-evidence.agent.md" "$research_tools"

# PMR-142 (PMD-20261108-001): the shared publication gate is mapped to its
# trigger phrase, only the maintainer runs it, and hooks are never bypassed.
publication_gate_check='python3 -I -B ~/.config/beryllium/publication-gate/bin/publication-gate check --repo . --remote <remote>'
publication_gate_audit='python3 -I -B ~/.config/beryllium/publication-gate/bin/publication-gate audit --repo . --all-refs'
for document in \
    "$repository_root/.github/copilot-instructions.md" \
    "$repository_root/AGENT-INTERFACE.md" \
    "$maintainer"; do
    require_pattern "$document" '^## Publication gate$'
    require_text "$document" "$publication_gate_check"
    require_text "$document" "$publication_gate_audit"
    for phrase in \
        '`origin`, `beryllium-project/threat-modeler`, is a public repository' \
        'Before any push to a public remote, public repository creation, visibility change, or public release, pull-request, issue, or wiki text' \
        'whenever the user says `check publication gate` or an obvious variant, the agent loads the user-level `beryllium-publication-gate` skill' \
        'Before public repository creation or a visibility change, after fetching every ref including tags' \
        'continues only on exit 0 and stops on exit 1 (a finding) or 2' \
        'Hooks are never bypassed' \
        'A non-public model is called `unlisted`, with nothing else said about it.' \
        'Passing the gate is not publication approval'; do
        require_flat_text "$document" "$phrase"
    done
done
for document in \
    "$repository_root/.github/copilot-instructions.md" \
    "$repository_root/AGENT-INTERFACE.md"; do
    for phrase in \
        'The publication-gate commands in `## Publication gate` are outside this' \
        'may also run the two publication-gate commands in `## Publication gate`' \
        '`threat-model-maintainer` runs both commands itself; they are admitted among its allowed commands.' \
        'the commands are outside their execute allowlists' \
        'the orchestrator gives the human the exact command or directs the request to `/agent threat-model-maintainer`'; do
        require_flat_text "$document" "$phrase"
    done
done
for phrase in \
    'they are admitted among your allowed commands' \
    'Run the publication-gate `check` command for that upstream remote' \
    'stop unless it exits 0' \
    'Never bypass hooks.'; do
    require_flat_text "$maintainer" "$phrase"
done
refute_flat_text "$maintainer" 'bypass hooks, or force-push'
require_pattern "$orchestrator" '^## Publication gate$'
for phrase in \
    '`check publication gate` or an obvious variant, load the user-level `beryllium-publication-gate` skill' \
    'or direct the request to `/agent threat-model-maintainer`' \
    'Never run the gate yourself' \
    'A non-public model is called `unlisted`, with nothing else said about it.'; do
    require_flat_text "$orchestrator" "$phrase"
done
for document in "$orchestrator" \
    "$repository_root/.github/copilot-instructions.md" \
    "$repository_root/AGENT-INTERFACE.md" \
    "$repository_root/.github/skills/beryllium-threat-modeling/SKILL.md"; do
    refute_pattern "$document" '^ *- `?(python3|~/\.config/beryllium/publication-gate)'
done
refute_pattern "$owner" 'publication-gate'
require_flat_text "$repository_root/README.md" \
    '`check publication gate` loads the user-level `beryllium-publication-gate` skill'

if $agents_only; then
    finish
fi

instructions=$repository_root/.github/copilot-instructions.md
skill=$repository_root/.github/skills/beryllium-threat-modeling/SKILL.md
for document in "$instructions" "$skill" "$orchestrator" \
    "$maintainer" \
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

printf '\n== optional PNG diagram derivatives ==\n'

root=$(copy_validation_root)
png_package=models/TM-20000101-001-fixture-model
png_diagrams=$root/$png_package/diagrams
svg_before=$(sha256sum "$png_diagrams"/svg/*.svg)
expect_pass "SVG-only packages remain valid without a PNG directory" \
    bash -c "cd '$root' && scripts/render-diagrams.sh --check '$png_package'"
if [[ ! -e $png_diagrams/png ]]; then
    pass "default SVG checking does not enable PNG"
else
    fail "default SVG checking unexpectedly enabled PNG"
fi
expect_fail "PNG check rejects missing derivatives" \
    bash -c "cd '$root' && scripts/render-diagrams.sh --check --png '$png_package'"
if [[ ! -e $png_diagrams/png ]]; then
    pass "PNG checking does not create an output directory"
else
    fail "PNG checking created an output directory"
fi
expect_pass "PNG opt-in renders both formats" \
    bash -c "cd '$root' && scripts/render-diagrams.sh --png '$png_package'"
svg_after=$(sha256sum "$png_diagrams"/svg/*.svg)
if [[ $svg_before == "$svg_after" ]]; then
    pass "PNG opt-in preserves existing SVG bytes"
else
    fail "PNG opt-in changed existing SVG bytes"
fi
for name in system-context trust-boundaries data-flows attack-tree-001; do
    image=$png_diagrams/png/$name.png
    require_file "$image"
    if [[ -s $image ]] &&
        [[ $(od -An -tx1 -N8 "$image" | tr -d '[:space:]') == 89504e470d0a1a0a ]]; then
        pass "$name has a nonempty PNG signature"
    else
        fail "$name is not a nonempty PNG"
    fi
done
expect_pass "PNG checking accepts either flag order" \
    bash -c "cd '$root' && scripts/render-diagrams.sh --png --check '$png_package'"
expect_pass "completion validation includes enabled PNG derivatives" \
    bash -c "cd '$root' && scripts/validate-threat-model.sh '$png_package'"
rm -f -- "$png_diagrams/png/system-context.png"
expect_message "default checking detects a missing enabled PNG" \
    'png/system-context.png' \
    bash -c "cd '$root' && scripts/render-diagrams.sh --check '$png_package'"
expect_fail "completion validation rejects a missing enabled PNG" \
    bash -c "cd '$root' && scripts/validate-threat-model.sh '$png_package'"
expect_pass "default rendering repairs enabled PNG derivatives" \
    bash -c "cd '$root' && scripts/render-diagrams.sh '$png_package'"
cp -- "$png_diagrams/png/system-context.png" "$root/old-context.png"
sed -i 's/TM-20000101-001 system context/TM-20000101-001 changed context/' \
    "$png_diagrams/system-context.dot"
expect_pass "default rendering refreshes both formats after a DOT change" \
    bash -c "cd '$root' && scripts/render-diagrams.sh '$png_package'"
cp -- "$root/old-context.png" "$png_diagrams/png/system-context.png"
expect_message "current SVG does not hide a stale PNG" \
    'png/system-context.png' \
    bash -c "cd '$root' && scripts/render-diagrams.sh --check '$png_package'"
expect_fail "completion validation rejects a stale PNG beside current SVG" \
    bash -c "cd '$root' && scripts/validate-threat-model.sh '$png_package'"
expect_pass "default rendering and checking repair stale PNG" \
    bash -c "cd '$root' && scripts/render-diagrams.sh '$png_package' && scripts/render-diagrams.sh --check '$png_package'"
expect_fail "renderer rejects an unsupported format flag" \
    bash -c "cd '$root' && scripts/render-diagrams.sh --pdf '$png_package'"
expect_fail "renderer rejects a duplicated PNG flag" \
    bash -c "cd '$root' && scripts/render-diagrams.sh --png --png '$png_package'"

root=$(copy_validation_root)
mkdir -- "$root/external-png"
ln -s "$root/external-png" "$root/$png_package/diagrams/png"
expect_message "renderer rejects a symlink PNG directory" \
    'PNG output directory must be an ordinary directory' \
    bash -c "cd '$root' && scripts/render-diagrams.sh --png '$png_package'"
if [[ -z $(find "$root/external-png" -mindepth 1 -print -quit) ]]; then
    pass "rejected PNG directory receives no output"
else
    fail "renderer wrote through a rejected PNG directory"
fi

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

components_output=$("$toolroot/scripts/readonly-inspect.sh" components)
for registered in project-manager security-reviewer; do
    if printf '%s\n' "$components_output" |
        grep -Fq "$registered"$'\tabsent\t-\t-'; then
        pass "readonly-inspect registers $registered"
    else
        fail "readonly-inspect does not register $registered"
    fi
done

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

finish
