#!/usr/bin/env bash

set -euo pipefail
export LC_ALL=C

usage() {
    cat >&2 <<'EOF'
Usage:
  validate-threat-model.sh [--draft] [--baseline <prior-package>] <package>
EOF
}

die() {
    printf 'validate-threat-model: ERROR: %s\n' "$*" >&2
    exit 1
}

repository_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd -P) ||
    die "cannot resolve repository root"
cd -- "$repository_root"

draft=false
baseline=
while (($# > 0)); do
    case $1 in
    --draft)
        draft=true
        shift
        ;;
    --baseline)
        (($# >= 2)) || {
            usage
            exit 2
        }
        baseline=$2
        shift 2
        ;;
    --*)
        usage
        exit 2
        ;;
    *)
        break
        ;;
    esac
done
(($# == 1)) || {
    usage
    exit 2
}

package=$1
[[ $package =~ ^models/(TM-[0-9]{8}-[0-9]{3})-[a-z0-9]+(-[a-z0-9]+)*$ ]] ||
    die "package path must match models/TM-YYYYMMDD-NNN-short-name"
package_id=${BASH_REMATCH[1]}
[[ -d $package ]] || die "package directory is missing: $package"

resolved=$(CDPATH= cd -- "$package" && pwd -P) ||
    die "cannot resolve package directory"
case $resolved in
"$repository_root"/models/*) ;;
*) die "package escapes the repository" ;;
esac

required_artifacts=(
    scope.md
    discovery.md
    threat-model.md
    review.md
    evidence-ledger.md
    search-log.md
    open-questions.md
    inaccessible-resources.md
    source-discoveries.md
    publication-checklist.md
    HANDOFF.md
    iterations/MODEL-ITERATION-001.md
    iterations/REVIEW-ITERATION-001.md
    diagrams/system-context.dot
    diagrams/trust-boundaries.dot
    diagrams/data-flows.dot
    diagrams/attack-tree-001.dot
)
for artifact in "${required_artifacts[@]}"; do
    [[ -f $package/$artifact ]] ||
        die "required package artifact is missing: $artifact"
done

metadata() {
    local label=$1 file=$2
    sed -n 's/^'"$label"': `\([^`]*\)`$/\1/p' "$file" | head -n 1
}

plain_metadata() {
    local label=$1 file=$2
    sed -n "s/^$label: //p" "$file" | head -n 1
}

scope=$package/scope.md
scope_id=$(metadata 'Package ID' "$scope")
[[ $scope_id == "$package_id" ]] ||
    die "scope Package ID must match the directory identifier"
title=$(plain_metadata 'Title' "$scope")
created=$(plain_metadata 'Created' "$scope")
mode=$(metadata 'Mode' "$scope")
status=$(metadata 'Status' "$scope")
distribution=$(metadata 'Distribution' "$scope")
latest_model=$(metadata 'Latest model iteration' "$scope")
latest_review=$(metadata 'Latest review iteration' "$scope")

[[ -n $title && -n $created ]] || die "scope title or creation date is missing"
[[ $created =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]] ||
    die "Created must be an ISO date"
case $mode in
review-existing | review-and-successor | create-from-evidence) ;;
*) die "invalid package mode: $mode" ;;
esac
case $distribution in
private | internal | public-candidate) ;;
*) die "invalid package distribution: $distribution" ;;
esac
[[ $latest_model =~ ^MODEL-ITERATION-[0-9]{3}$ ]] ||
    die "invalid latest model iteration"
[[ $latest_review =~ ^REVIEW-ITERATION-[0-9]{3}$ ]] ||
    die "invalid latest review iteration"
[[ -f $package/iterations/$latest_model.md ]] ||
    die "latest model iteration file is missing"
[[ -f $package/iterations/$latest_review.md ]] ||
    die "latest review iteration file is missing"

while IFS= read -r file; do
    if grep -Eq '(^|[^A-Za-z0-9_])(/home/|/Users/|/root/)' "$file"; then
        die "absolute workstation path is forbidden: ${file#"$package/"}"
    fi
    if grep -Fq '@@' "$file"; then
        die "unsubstituted template token found: ${file#"$package/"}"
    fi
done < <(find "$package" -type f \( -name '*.md' -o -name '*.dot' \) | sort)

while IFS= read -r file; do
    file_id=$(metadata 'Package ID' "$file")
    [[ $file_id == "$package_id" ]] ||
        die "Package ID mismatch in ${file#"$package/"}"
    file_title=$(plain_metadata 'Title' "$file")
    [[ $file_title == "$title" ]] ||
        die "Title mismatch in ${file#"$package/"}"
    file_created=$(plain_metadata 'Created' "$file")
    [[ $file_created == "$created" ]] ||
        die "Created date mismatch in ${file#"$package/"}"
    file_distribution=$(metadata 'Distribution' "$file")
    [[ $file_distribution == "$distribution" ]] ||
        die "Distribution mismatch in ${file#"$package/"}"
done < <(find "$package" -type f -name '*.md' | sort)

[[ $(metadata 'Latest model iteration' "$package/threat-model.md") == "$latest_model" ]] ||
    die "threat-model.md latest iteration does not match scope.md"
[[ $(metadata 'Latest review iteration' "$package/review.md") == "$latest_review" ]] ||
    die "review.md latest iteration does not match scope.md"
grep -Fqx "# $latest_model" "$package/iterations/$latest_model.md" ||
    die "latest model iteration heading does not match its filename"
grep -Fqx "# $latest_review" "$package/iterations/$latest_review.md" ||
    die "latest review iteration heading does not match its filename"
while IFS= read -r iteration; do
    name=${iteration##*/}
    name=${name%.md}
    [[ $name =~ ^(MODEL|REVIEW)-ITERATION-[0-9]{3}$ ]] ||
        die "malformed iteration filename: ${iteration#"$package/"}"
    grep -Fqx "# $name" "$iteration" ||
        die "iteration heading does not match filename: ${iteration#"$package/"}"
done < <(find "$package/iterations" -type f -name '*.md' | sort)

for source in "$package"/diagrams/*.dot; do
    command -v dot >/dev/null 2>&1 || die "Graphviz dot is unavailable"
    dot -Tsvg "$source" >/dev/null ||
        die "invalid Graphviz source: ${source#"$package/"}"
done

if [[ -n $baseline ]]; then
    [[ -d $baseline ]] || die "baseline package is missing: $baseline"
    [[ ${baseline##*/} == "${package##*/}" ]] ||
        die "baseline must be a prior copy of the same package"
    while IFS= read -r prior_iteration; do
        relative=${prior_iteration#"$baseline/"}
        [[ -f $package/$relative ]] ||
            die "append-only iteration was removed: $relative"
        cmp -s -- "$prior_iteration" "$package/$relative" ||
            die "append-only iteration changed: $relative"
    done < <(find "$baseline/iterations" -type f -name '*.md' | sort)

    for relative in evidence-ledger.md search-log.md source-discoveries.md \
        inaccessible-resources.md scope.md HANDOFF.md; do
        [[ -f $baseline/$relative ]] || continue
        while IFS= read -r record; do
            [[ -n $record ]] || continue
            grep -Fqx -- "$record" "$package/$relative" ||
                die "append-only record changed or was removed from $relative: $record"
        done < <(grep -E \
            '(TM-[0-9]{8}-[0-9]{3}-E[0-9]{4}|SEARCH-[0-9]{3}|DISC-[0-9]{3}|BLOCKED-[0-9]{3}|ACTIVITY-[0-9]{3})' \
            "$baseline/$relative" || true)
    done
fi

if $draft; then
    case $status in Draft | Complete) ;; *)
        die "draft validation requires package Status Draft or Complete"
    esac
    printf 'validate-threat-model: OK: %s (draft)\n' "$package"
    exit 0
fi

[[ $status == Complete ]] || die "completion validation requires Status Complete"
for artifact in scope discovery threat-model review evidence-ledger search-log \
    open-questions inaccessible-resources source-discoveries \
    publication-checklist HANDOFF; do
    artifact_status=$(metadata 'Status' "$package/$artifact.md")
    [[ $artifact_status == Complete ]] ||
        die "$artifact.md must have Status Complete"
done
for iteration in "$package"/iterations/*.md; do
    iteration_status=$(metadata 'Status' "$iteration")
    [[ $iteration_status == Complete ]] ||
        die "${iteration#"$package/"} must have Status Complete"
done

case $mode in
review-existing | review-and-successor)
    if grep -Fq -- '- Source model: Not recorded.' "$package/review.md"; then
        die "review mode requires a recorded source model"
    fi
    ;;
create-from-evidence) ;;
esac

evidence_file=$package/evidence-ledger.md
mapfile -t evidence_definitions < <(
    grep -E "^## $package_id-E[0-9]{4}$" "$evidence_file" |
        sed 's/^## //' | sort
)
((${#evidence_definitions[@]} > 0)) ||
    die "completion requires at least one evidence record"
duplicate_evidence=$(printf '%s\n' "${evidence_definitions[@]}" |
    uniq -d | head -n 1)
[[ -z $duplicate_evidence ]] ||
    die "duplicate evidence definition: $duplicate_evidence"

awk -v package_id="$package_id" '
function require_field(value, label) {
    if (value == "") {
        printf "evidence %s is missing %s\n", id, label > "/dev/stderr"
        failed = 1
    }
}
function finish() {
    if (id == "") return
    require_field(status, "Status")
    require_field(fact_label, "Fact label")
    require_field(class, "Class")
    require_field(role, "Role")
    require_field(affected, "Affected IDs")
    require_field(title, "Title or description")
    require_field(locator, "Logical locator")
    require_field(revision, "Revision or checked date")
    require_field(observation, "Observation")
    require_field(relationship, "Relationship")
    require_field(confidence, "Confidence")
    require_field(confidence_basis, "Confidence basis")
    require_field(alternatives, "Alternatives and counter-evidence")
    require_field(sensitivity, "Sensitivity")
    require_field(redistribution, "Redistribution")
    require_field(hash, "Hash")
    require_field(limitations, "Limitations")
    require_field(supersedes, "Supersedes")
    require_field(superseded_by, "Superseded by")
    if (status !~ /^(active|superseded|withdrawn)$/) {
        printf "evidence %s has invalid Status\n", id > "/dev/stderr"; failed = 1
    }
    if (fact_label !~ /^(Established|Inferred|Unknown)$/) {
        printf "evidence %s has invalid Fact label\n", id > "/dev/stderr"; failed = 1
    }
    if (role !~ /^(Direct|Corroborating|Contextual|Counter|Negative)$/) {
        printf "evidence %s has invalid Role\n", id > "/dev/stderr"; failed = 1
    }
    if (locator !~ /(workspace:\/\/|component:\/\/|source:\/\/|inbox:\/\/|https?:\/\/|doi:)/) {
        printf "evidence %s has invalid Logical locator\n", id > "/dev/stderr"; failed = 1
    }
    if (confidence !~ /^(High|Medium|Low)$/) {
        printf "evidence %s has invalid Confidence\n", id > "/dev/stderr"; failed = 1
    }
    if (sensitivity !~ /^(public|internal|private|restricted)$/) {
        printf "evidence %s has invalid Sensitivity\n", id > "/dev/stderr"; failed = 1
    }
    if (redistribution !~ /^(approved|not-approved|unknown|not-applicable)$/) {
        printf "evidence %s has invalid Redistribution\n", id > "/dev/stderr"; failed = 1
    }
    count++
    id=status=fact_label=class=role=affected=title=locator=revision=observation=""
    relationship=confidence=confidence_basis=alternatives=sensitivity=""
    redistribution=hash=limitations=supersedes=superseded_by=""
}
$0 ~ ("^## " package_id "-E[0-9][0-9][0-9][0-9]$") {
    finish()
    id=$2
    next
}
id != "" && /^- Status: / { sub(/^- Status: /, ""); status=$0; next }
id != "" && /^- Fact label: / { sub(/^- Fact label: /, ""); fact_label=$0; next }
id != "" && /^- Class: / { sub(/^- Class: /, ""); class=$0; next }
id != "" && /^- Role: / { sub(/^- Role: /, ""); role=$0; next }
id != "" && /^- Affected IDs: / { sub(/^- Affected IDs: /, ""); affected=$0; next }
id != "" && /^- Title or description: / {
    sub(/^- Title or description: /, ""); title=$0; next
}
id != "" && /^- Logical locator: / { sub(/^- Logical locator: /, ""); locator=$0; next }
id != "" && /^- Revision or checked date: / {
    sub(/^- Revision or checked date: /, ""); revision=$0; next
}
id != "" && /^- Observation: / { sub(/^- Observation: /, ""); observation=$0; next }
id != "" && /^- Relationship: / { sub(/^- Relationship: /, ""); relationship=$0; next }
id != "" && /^- Confidence: / { sub(/^- Confidence: /, ""); confidence=$0; next }
id != "" && /^- Confidence basis: / {
    sub(/^- Confidence basis: /, ""); confidence_basis=$0; next
}
id != "" && /^- Alternatives and counter-evidence: / {
    sub(/^- Alternatives and counter-evidence: /, ""); alternatives=$0; next
}
id != "" && /^- Sensitivity: / { sub(/^- Sensitivity: /, ""); sensitivity=$0; next }
id != "" && /^- Redistribution: / {
    sub(/^- Redistribution: /, ""); redistribution=$0; next
}
id != "" && /^- Hash: / { sub(/^- Hash: /, ""); hash=$0; next }
id != "" && /^- Limitations: / { sub(/^- Limitations: /, ""); limitations=$0; next }
id != "" && /^- Supersedes: / { sub(/^- Supersedes: /, ""); supersedes=$0; next }
id != "" && /^- Superseded by: / {
    sub(/^- Superseded by: /, ""); superseded_by=$0; next
}
END {
    finish()
    if (count == 0) {
        print "no evidence records found" > "/dev/stderr"
        failed = 1
    }
    exit failed
}
' "$evidence_file" || die "evidence ledger validation failed"

while IFS= read -r referenced; do
    printf '%s\n' "${evidence_definitions[@]}" | grep -Fqx -- "$referenced" ||
        die "evidence reference is not defined in the ledger: $referenced"
done < <(
    grep -rhoE --include='*.md' "$package_id-E[0-9]{4}" "$package" |
        sort -u
)

definition_file=$package/threat-model.md

extract_table_ids() {
    local prefix=$1
    local heading
    case $prefix in
    OBJECTIVE) heading='## Security objectives' ;;
    ASSET) heading='## Protected assets' ;;
    ACTOR) heading='## Actors and capabilities' ;;
    BOUNDARY) heading='## Trust boundaries' ;;
    FLOW) heading='## Data and control flows' ;;
    ENTRY) heading='## Entry points and attack surface' ;;
    CONTROL) heading='## Existing controls' ;;
    MITIGATION) heading='## Mitigation and verification plan' ;;
    *) die "unsupported table identifier prefix: $prefix" ;;
    esac
    awk -F '|' -v heading="$heading" -v prefix="$prefix" '
        $0 == heading { active=1; next }
        active && /^## / { exit }
        active {
            value=$2
            gsub(/^[ \t]+|[ \t]+$/, "", value)
            if (value ~ ("^" prefix "-[0-9][0-9][0-9]$")) print value
        }
    ' "$definition_file" | sort
}

require_definitions() {
    local prefix=$1
    mapfile -t definitions < <(extract_table_ids "$prefix")
    ((${#definitions[@]} > 0)) ||
        die "completion requires at least one $prefix definition"
    duplicate=$(printf '%s\n' "${definitions[@]}" | uniq -d | head -n 1)
    [[ -z $duplicate ]] || die "duplicate $prefix definition: $duplicate"
}

for prefix in OBJECTIVE ASSET ACTOR BOUNDARY FLOW ENTRY CONTROL MITIGATION; do
    require_definitions "$prefix"
done

validate_entity_references() {
    local prefix=$1 referenced
    local -a definitions
    mapfile -t definitions < <(extract_table_ids "$prefix")
    while IFS= read -r referenced; do
        printf '%s\n' "${definitions[@]}" | grep -Fqx -- "$referenced" ||
            die "$prefix reference is not defined: $referenced"
    done < <(grep -oE "$prefix-[0-9]{3}" "$definition_file" | sort -u)
}

for prefix in OBJECTIVE ASSET ACTOR BOUNDARY FLOW ENTRY CONTROL MITIGATION; do
    validate_entity_references "$prefix"
done

mapfile -t threat_definitions < <(
    grep -E '^### THREAT-[0-9]{3}:' "$definition_file" |
        sed -E 's/^### (THREAT-[0-9]{3}):.*/\1/' | sort
)
((${#threat_definitions[@]} > 0)) ||
    die "completion requires at least one threat"
duplicate=$(printf '%s\n' "${threat_definitions[@]}" | uniq -d | head -n 1)
[[ -z $duplicate ]] || die "duplicate threat definition: $duplicate"
while IFS= read -r referenced; do
    printf '%s\n' "${threat_definitions[@]}" | grep -Fqx -- "$referenced" ||
        die "THREAT reference is not defined: $referenced"
done < <(grep -oE 'THREAT-[0-9]{3}' "$definition_file" | sort -u)

mapfile -t attack_definitions < <(
    grep -E '^### ATTACK-[0-9]{3}:' "$definition_file" |
        sed -E 's/^### (ATTACK-[0-9]{3}):.*/\1/' | sort
)
((${#attack_definitions[@]} > 0)) ||
    die "completion requires at least one attack tree or abuse case"
duplicate=$(printf '%s\n' "${attack_definitions[@]}" | uniq -d | head -n 1)
[[ -z $duplicate ]] || die "duplicate attack definition: $duplicate"

mapfile -t assumption_definitions < <(
    grep -E '^### ASSUMPTION-[0-9]{3}:' "$definition_file" |
        sed -E 's/^### (ASSUMPTION-[0-9]{3}):.*/\1/' | sort
)
((${#assumption_definitions[@]} > 0)) ||
    die "completion requires at least one explicit assumption or non-goal"
duplicate=$(printf '%s\n' "${assumption_definitions[@]}" | uniq -d | head -n 1)
[[ -z $duplicate ]] || die "duplicate assumption definition: $duplicate"

awk -v package_id="$package_id" '
function band(likelihood, impact, product) {
    product = likelihood * impact
    if (product <= 4) return "Low"
    if (product <= 9) return "Moderate"
    if (product <= 16) return "High"
    return "Critical"
}
function require_field(value, label) {
    if (value == "") {
        printf "threat %s is missing %s\n", id, label > "/dev/stderr"
        failed = 1
    }
}
function finish() {
    if (id == "") return
    require_field(fact_label, "Fact label")
    require_field(stride, "STRIDE")
    require_field(scenario, "Scenario")
    require_field(preconditions, "Preconditions")
    require_field(assets, "Asset IDs")
    require_field(objectives, "Objective IDs")
    require_field(actors, "Actor IDs")
    require_field(surfaces, "Surface IDs")
    require_field(controls, "Existing control IDs")
    require_field(mitigations, "Mitigation IDs")
    require_field(inherent_likelihood, "Inherent likelihood")
    require_field(inherent_impact, "Inherent impact")
    require_field(inherent_risk, "Inherent risk")
    require_field(inherent_rationale, "Inherent rationale")
    require_field(residual_likelihood, "Residual likelihood")
    require_field(residual_impact, "Residual impact")
    require_field(residual_risk, "Residual risk")
    require_field(residual_rationale, "Residual rationale")
    require_field(risk_uncertainty, "Risk uncertainty")
    require_field(confidence, "Confidence")
    require_field(evidence, "Evidence IDs")
    require_field(status, "Status")
    require_field(alternatives, "Alternatives and counter-evidence")
    require_field(limitations, "Limitations")
    if (fact_label !~ /^(Established|Inferred|Proposed|Unknown)$/) {
        printf "threat %s has invalid Fact label\n", id > "/dev/stderr"; failed = 1
    }
    if (stride !~ /(Spoofing|Tampering|Repudiation|Information disclosure|Denial of service|Elevation of privilege)/) {
        printf "threat %s has invalid STRIDE category\n", id > "/dev/stderr"; failed = 1
    }
    if (inherent_likelihood !~ /^[1-5]$/ || inherent_impact !~ /^[1-5]$/ ||
        residual_likelihood !~ /^[1-5]$/ || residual_impact !~ /^[1-5]$/) {
        printf "threat %s has invalid likelihood or impact\n", id > "/dev/stderr"; failed = 1
    } else {
        if (inherent_risk != band(inherent_likelihood, inherent_impact)) {
            printf "threat %s has inconsistent inherent risk\n", id > "/dev/stderr"; failed = 1
        }
        if (residual_risk != band(residual_likelihood, residual_impact)) {
            printf "threat %s has inconsistent residual risk\n", id > "/dev/stderr"; failed = 1
        }
    }
    if (confidence !~ /^(High|Medium|Low)$/) {
        printf "threat %s has invalid Confidence\n", id > "/dev/stderr"; failed = 1
    }
    if (status !~ /^(Open|Partially mitigated|Mitigated|Unresolved|Out of scope)$/) {
        printf "threat %s has invalid Status\n", id > "/dev/stderr"; failed = 1
    }
    if (evidence !~ package_id "-E[0-9]{4}") {
        printf "threat %s has no stable evidence ID\n", id > "/dev/stderr"; failed = 1
    }
    count++
    id=fact_label=stride=scenario=preconditions=assets=objectives=actors=surfaces=""
    controls=mitigations=inherent_likelihood=inherent_impact=inherent_risk=""
    inherent_rationale=residual_likelihood=residual_impact=residual_risk=""
    residual_rationale=risk_uncertainty=confidence=evidence=status=""
    alternatives=limitations=""
}
/^### THREAT-[0-9][0-9][0-9]:/ {
    finish()
    id=$2
    sub(/:$/, "", id)
    next
}
id != "" && /^- Fact label: / { sub(/^- Fact label: /, ""); fact_label=$0; next }
id != "" && /^- STRIDE: / { sub(/^- STRIDE: /, ""); stride=$0; next }
id != "" && /^- Scenario: / { sub(/^- Scenario: /, ""); scenario=$0; next }
id != "" && /^- Preconditions: / { sub(/^- Preconditions: /, ""); preconditions=$0; next }
id != "" && /^- Asset IDs: / { sub(/^- Asset IDs: /, ""); assets=$0; next }
id != "" && /^- Objective IDs: / { sub(/^- Objective IDs: /, ""); objectives=$0; next }
id != "" && /^- Actor IDs: / { sub(/^- Actor IDs: /, ""); actors=$0; next }
id != "" && /^- Surface IDs: / { sub(/^- Surface IDs: /, ""); surfaces=$0; next }
id != "" && /^- Existing control IDs: / { sub(/^- Existing control IDs: /, ""); controls=$0; next }
id != "" && /^- Mitigation IDs: / { sub(/^- Mitigation IDs: /, ""); mitigations=$0; next }
id != "" && /^- Inherent likelihood: / { sub(/^- Inherent likelihood: /, ""); inherent_likelihood=$0; next }
id != "" && /^- Inherent impact: / { sub(/^- Inherent impact: /, ""); inherent_impact=$0; next }
id != "" && /^- Inherent risk: / { sub(/^- Inherent risk: /, ""); inherent_risk=$0; next }
id != "" && /^- Inherent rationale: / {
    sub(/^- Inherent rationale: /, ""); inherent_rationale=$0; next
}
id != "" && /^- Residual likelihood: / { sub(/^- Residual likelihood: /, ""); residual_likelihood=$0; next }
id != "" && /^- Residual impact: / { sub(/^- Residual impact: /, ""); residual_impact=$0; next }
id != "" && /^- Residual risk: / { sub(/^- Residual risk: /, ""); residual_risk=$0; next }
id != "" && /^- Residual rationale: / {
    sub(/^- Residual rationale: /, ""); residual_rationale=$0; next
}
id != "" && /^- Risk uncertainty: / {
    sub(/^- Risk uncertainty: /, ""); risk_uncertainty=$0; next
}
id != "" && /^- Confidence: / { sub(/^- Confidence: /, ""); confidence=$0; next }
id != "" && /^- Evidence IDs: / { sub(/^- Evidence IDs: /, ""); evidence=$0; next }
id != "" && /^- Status: / { sub(/^- Status: /, ""); status=$0; next }
id != "" && /^- Alternatives and counter-evidence: / {
    sub(/^- Alternatives and counter-evidence: /, ""); alternatives=$0; next
}
id != "" && /^- Limitations: / { sub(/^- Limitations: /, ""); limitations=$0; next }
END {
    finish()
    if (count == 0) {
        print "no threat records found" > "/dev/stderr"
        failed = 1
    }
    exit failed
}
' "$definition_file" || die "threat catalogue validation failed"

review_file=$package/review.md
mapfile -t finding_definitions < <(
    grep -E '^### FINDING-[0-9]{3}:' "$review_file" |
        sed -E 's/^### (FINDING-[0-9]{3}):.*/\1/' | sort
)
((${#finding_definitions[@]} > 0)) ||
    die "completion requires at least one review finding"
duplicate=$(printf '%s\n' "${finding_definitions[@]}" | uniq -d | head -n 1)
[[ -z $duplicate ]] || die "duplicate review finding definition: $duplicate"

awk -v package_id="$package_id" '
function require_field(value, label) {
    if (value == "") {
        printf "finding %s is missing %s\n", id, label > "/dev/stderr"
        failed = 1
    }
}
function finish() {
    if (id == "") return
    require_field(severity, "Severity")
    require_field(confidence, "Confidence")
    require_field(fact_label, "Fact label")
    require_field(affected, "Affected IDs")
    require_field(evidence, "Evidence IDs")
    require_field(impact, "Impact")
    require_field(recommendation, "Recommendation")
    require_field(alternatives, "Alternatives and counter-evidence")
    require_field(limitations, "Limitations")
    if (severity !~ /^(Critical|High|Medium|Low|Informational)$/) {
        printf "finding %s has invalid Severity\n", id > "/dev/stderr"; failed = 1
    }
    if (confidence !~ /^(High|Medium|Low)$/) {
        printf "finding %s has invalid Confidence\n", id > "/dev/stderr"; failed = 1
    }
    if (fact_label !~ /^(Established|Inferred|Proposed|Unknown)$/) {
        printf "finding %s has invalid Fact label\n", id > "/dev/stderr"; failed = 1
    }
    if (evidence !~ package_id "-E[0-9]{4}") {
        printf "finding %s has no stable evidence ID\n", id > "/dev/stderr"; failed = 1
    }
    count++
    id=severity=confidence=fact_label=affected=evidence=impact=recommendation=""
    alternatives=limitations=""
}
/^### FINDING-[0-9][0-9][0-9]:/ {
    finish()
    id=$2
    sub(/:$/, "", id)
    next
}
id != "" && /^- Severity: / { sub(/^- Severity: /, ""); severity=$0; next }
id != "" && /^- Confidence: / { sub(/^- Confidence: /, ""); confidence=$0; next }
id != "" && /^- Fact label: / { sub(/^- Fact label: /, ""); fact_label=$0; next }
id != "" && /^- Affected IDs: / { sub(/^- Affected IDs: /, ""); affected=$0; next }
id != "" && /^- Evidence IDs: / { sub(/^- Evidence IDs: /, ""); evidence=$0; next }
id != "" && /^- Impact: / { sub(/^- Impact: /, ""); impact=$0; next }
id != "" && /^- Recommendation: / { sub(/^- Recommendation: /, ""); recommendation=$0; next }
id != "" && /^- Alternatives and counter-evidence: / {
    sub(/^- Alternatives and counter-evidence: /, ""); alternatives=$0; next
}
id != "" && /^- Limitations: / { sub(/^- Limitations: /, ""); limitations=$0; next }
END {
    finish()
    if (count == 0) {
        print "no review findings found" > "/dev/stderr"
        failed = 1
    }
    exit failed
}
' "$review_file" || die "review finding validation failed"

if grep -Eq '^\| [^|]+ \| Incomplete \|' "$review_file"; then
    die "review completeness table contains an Incomplete dimension"
fi

for prefix in OBJECTIVE ASSET ACTOR BOUNDARY FLOW ENTRY; do
    while IFS= read -r identifier; do
        occurrences=$(grep -o -- "$identifier" "$definition_file" | wc -l)
        ((occurrences >= 2)) ||
            die "$identifier is not traced into a threat or coverage record"
    done < <(extract_table_ids "$prefix")
done

grep -Eq '^### ATTACK-[0-9]{3}:' "$definition_file" ||
    die "attack-tree narrative is missing"
grep -Fq '## Coverage matrix' "$definition_file" ||
    die "coverage matrix is missing"

validate_table_ids() {
    local file=$1 prefix=$2 require_one=$3
    local -a identifiers
    mapfile -t identifiers < <(
        grep -E "^\| $prefix-[0-9]{3} \|" "$file" |
            awk -F '|' '{ gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2 }' |
            sort
    )
    if [[ $require_one == yes ]] && ((${#identifiers[@]} == 0)); then
        die "$file requires at least one $prefix record"
    fi
    if ((${#identifiers[@]} > 0)); then
        duplicate=$(printf '%s\n' "${identifiers[@]}" | uniq -d | head -n 1)
        [[ -z $duplicate ]] ||
            die "duplicate $prefix record in ${file#"$package/"}: $duplicate"
    fi
}

validate_table_ids "$package/search-log.md" SEARCH yes
validate_table_ids "$package/open-questions.md" OPEN no
validate_table_ids "$package/inaccessible-resources.md" BLOCKED no
validate_table_ids "$package/source-discoveries.md" DISC no
validate_table_ids "$package/scope.md" ACTIVITY yes
validate_table_ids "$package/HANDOFF.md" ACTIVITY yes

"$repository_root/scripts/render-diagrams.sh" --check "$package" ||
    die "generated diagrams are missing or stale"

if [[ $distribution != private ]]; then
    checklist=$package/publication-checklist.md
    if grep -Fq -- '- [ ]' "$checklist"; then
        die "promoted distribution requires every checklist item to be checked"
    fi
    record_id=$(sed -n 's/^| Record ID | \(HUMAN-PROMOTION-[0-9][0-9][0-9]\) |$/\1/p' "$checklist")
    [[ -n $record_id ]] ||
        die "promoted distribution requires a HUMAN-PROMOTION-NNN record"
    actor=$(sed -n 's/^| Responsible human actor | \(.*\) |$/\1/p' "$checklist")
    role=$(sed -n 's/^| Responsible human role | \(.*\) |$/\1/p' "$checklist")
    to_distribution=$(sed -n 's/^| To distribution | \(.*\) |$/\1/p' "$checklist")
    decision=$(sed -n 's/^| Decision | \(.*\) |$/\1/p' "$checklist")
    [[ -n $actor && $actor != 'Not recorded' &&
        -n $role && $role != 'Not recorded' ]] ||
        die "promotion record requires a responsible human actor and role"
    [[ $to_distribution == "$distribution" && $decision == promote ]] ||
        die "promotion record does not authorize the current distribution"

    if [[ $distribution == public-candidate ]] &&
        grep -Eq '^- Sensitivity: (internal|private|restricted)$|^- Redistribution: (not-approved|unknown)$' \
            "$evidence_file"; then
        die "public-candidate is blocked by non-public or uncleared evidence"
    fi
fi

printf 'validate-threat-model: OK: %s (complete)\n' "$package"
