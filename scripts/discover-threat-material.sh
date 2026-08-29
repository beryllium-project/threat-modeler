#!/usr/bin/env bash

set -euo pipefail
export LC_ALL=C

usage() {
    cat >&2 <<'EOF'
Usage:
  discover-threat-material.sh component <component> <revision>
  discover-threat-material.sh project

Output is a deterministic, read-only candidate inventory. It is evidence for
human confirmation, not an authoritative model selection.
EOF
}

die() {
    printf 'discover-threat-material: ERROR: %s\n' "$*" >&2
    exit 1
}

repository_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd -P) ||
    die "cannot resolve repository root"
inspect=$repository_root/scripts/readonly-inspect.sh
[[ -x $inspect ]] || die "readonly inspection helper is unavailable"

tmpdir=$(mktemp -d "${TMPDIR:-/tmp}/threat-material.XXXXXX") ||
    die "cannot create temporary directory"
cleanup() {
    rm -rf -- "$tmpdir"
}
trap cleanup EXIT
trap 'exit 1' HUP INT TERM

raw=$tmpdir/raw.tsv
: >"$raw"

classify_path() {
    local path=${1,,}
    case $path in
    *threat*model*) printf 'formal or partial threat model' ;;
    *agent-review* | *security-review* | *review*) printf 'security or assurance review' ;;
    *security-and-limits* | *assumption* | *non-goal* | *limits*) printf 'assumptions, limits, or non-goals input' ;;
    *architecture* | *design* | planning/* | *roadmap*) printf 'architecture or design input' ;;
    *test* | *evidence* | *assurance*) printf 'implementation or test evidence' ;;
    *security* | *attack* | *risk*) printf 'security-analysis input' ;;
    *) printf 'security-analysis input' ;;
    esac
}

classify_match() {
    local path=${1,,} text=${2,,}
    if [[ $text =~ threat[-\ ]model[[:space:]]+delta ]]; then
        printf 'model delta'
    elif [[ $text =~ ^[[:space:]]*#+[[:space:]]+threat[-\ ]model ]] ||
        [[ $text =~ threat[[:space:]]model[[:space:]]v[0-9] ]]; then
        if [[ $path == *threat*model* ]]; then
            printf 'formal threat model'
        else
            printf 'partial or embedded threat model'
        fi
    elif [[ $path == *agent-review* || $path == *security-review* ||
        $path == *review* ]]; then
        printf 'security or assurance review'
    elif [[ $text =~ protected[[:space:]]assets?|trusted[[:space:]]computing[[:space:]]base|security[[:space:]]assumptions?|non-goals?|side[[:space:]]channels? ]]; then
        printf 'assumptions, limits, or non-goals input'
    elif [[ $text =~ trust[[:space:]]boundar|attack[[:space:]]surface|security[[:space:]]objectives?|adversar|potential[[:space:]]attackers? ]]; then
        printf 'architecture or design input'
    else
        classify_path "$path"
    fi
}

logical_locator() {
    local component=$1 path=$2
    if [[ $component == workspace ]]; then
        printf 'workspace://%s' "$path"
    else
        printf 'component://%s/%s' "$component" "$path"
    fi
}

emit_component() {
    local component=$1 revision=$2 commit files matches path class line rest
    local text line_number
    commit=$("$inspect" resolve "$component" "$revision" |
        awk -F '\t' '$1 == "commit" { print $2 }')
    [[ $commit =~ ^[0-9a-fA-F]{40,64}$ ]] ||
        die "cannot resolve $component revision $revision"

    files=$tmpdir/$component.files
    matches=$tmpdir/$component.matches
    "$inspect" ls-tree "$component" "$commit" >"$files"
    "$inspect" search "$component" "$commit" >"$matches"

    while IFS= read -r path; do
        [[ -n $path ]] || continue
        case $path in
        sources/* | */sources/* | docs/html/* | */docs/html/* | \
        reviews/*/html/* | */reviews/*/html/* | node_modules/* | \
        */node_modules/* | build/* | */build/* | tests/fixtures/* | \
        */tests/fixtures/*)
            continue
            ;;
        esac
        if [[ ${path,,} =~ (threat|security|architecture|design|risk|assumption|attack|review|assurance|non-goal|limits) ]]; then
            class=$(classify_path "$path")
            printf '%s\t%s\t%s\t%s\tfilename\n' \
                "$component" "$commit" "$class" \
                "$(logical_locator "$component" "$path")" >>"$raw"
        fi
    done <"$files"

    while IFS= read -r line; do
        [[ -n $line ]] || continue
        line=${line#"$commit:"}
        path=${line%%:*}
        rest=${line#*:}
        [[ $rest != "$line" ]] || continue
        line_number=${rest%%:*}
        text=${rest#*:}
        [[ $path != sources/restricted-microsoft &&
            $path != sources/restricted-microsoft/* &&
            $path != */sources/restricted-microsoft/* ]] || continue
        class=$(classify_match "$path" "$text")
        printf '%s\t%s\t%s\t%s\tcontent-line-%s\n' \
            "$component" "$commit" "$class" \
            "$(logical_locator "$component" "$path")" "$line_number" >>"$raw"
    done <"$matches"
}

(($# >= 1)) || {
    usage
    exit 2
}

case $1 in
component)
    (($# == 3)) || {
        usage
        exit 2
    }
    emit_component "$2" "$3"
    ;;
project)
    (($# == 1)) || {
        usage
        exit 2
    }
    while IFS=$'\t' read -r component state _branch _head; do
        [[ -n $component && $component != \#* ]] || continue
        [[ $state != absent && $state != unresolvable ]] || continue
        emit_component "$component" HEAD
    done < <("$inspect" components)
    ;;
*)
    usage
    exit 2
    ;;
esac

printf '# threat material candidates\n'
printf 'Candidate\tComponent\tRevision\tClass\tLogical locator\tBasis\n'
sort -u -t $'\t' -k1,1 -k2,2 -k3,3 -k4,4 -k5,5V "$raw" |
    awk -F '\t' '
        function emit() {
            if (key == "") return
            count++
            printf "CANDIDATE-%03d\t%s\t%s\t%s\t%s\t%s\n",
                count, component, revision, class, locator, basis
        }
        {
            candidate_key=$1 "\t" $2 "\t" $3 "\t" $4
            if (candidate_key != key) {
                emit()
                key=candidate_key
                component=$1
                revision=$2
                class=$3
                locator=$4
                basis=$5
            }
        }
        END { emit() }
    '
