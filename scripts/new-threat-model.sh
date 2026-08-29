#!/usr/bin/env bash

set -euo pipefail
export LC_ALL=C

usage() {
    cat >&2 <<'EOF'
Usage:
  new-threat-model.sh <short-name> <title> <mode>

Modes:
  review-existing
  review-and-successor
  create-from-evidence
EOF
}

die() {
    printf 'new-threat-model: ERROR: %s\n' "$*" >&2
    exit 1
}

repository_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd -P) ||
    die "cannot resolve repository root"
cd -- "$repository_root"

(($# == 3)) || {
    usage
    exit 2
}

slug=$1
title=$2
mode=$3

[[ $slug =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] ||
    die "short name must use lowercase letters, digits, and single hyphens"
[[ -n $title && $title =~ ^[[:print:]]+$ && $title != *'@@'* &&
    $title != *'|'* ]] ||
    die "title must be printable text without template tokens or table delimiters"
case $mode in
review-existing | review-and-successor | create-from-evidence) ;;
*) die "unsupported mode: $mode" ;;
esac

date_tag=$(date -u +%Y%m%d)
created=$(date -u +%Y-%m-%d)
mkdir -p -- models

sequence=1
while ((sequence <= 999)); do
    printf -v sequence_text '%03d' "$sequence"
    package_id=TM-$date_tag-$sequence_text
    package_dir=models/$package_id-$slug
    shopt -s nullglob
    existing_packages=(models/"$package_id"-*)
    shopt -u nullglob
    ((${#existing_packages[@]} == 0)) && break
    sequence=$((sequence + 1))
done
((sequence <= 999)) || die "no package identifier remains for UTC date $date_tag"

mkdir -p -- "$package_dir/iterations" "$package_dir/diagrams/svg"

escape_replacement() {
    printf '%s' "$1" | sed 's/[\/&\\]/\\&/g'
}

escaped_id=$(escape_replacement "$package_id")
escaped_title=$(escape_replacement "$title")
escaped_created=$(escape_replacement "$created")
escaped_mode=$(escape_replacement "$mode")

instantiate() {
    local source=$1 destination=$2
    [[ -f $source ]] || die "missing template: $source"
    sed \
        -e "s/@@PACKAGE_ID@@/$escaped_id/g" \
        -e "s/@@TITLE@@/$escaped_title/g" \
        -e "s/@@CREATED@@/$escaped_created/g" \
        -e "s/@@MODE@@/$escaped_mode/g" \
        "$source" >"$destination"
}

for artifact in scope discovery threat-model review evidence-ledger search-log \
    open-questions inaccessible-resources source-discoveries \
    publication-checklist HANDOFF; do
    instantiate "templates/$artifact.md" "$package_dir/$artifact.md"
done

instantiate templates/model-iteration.md \
    "$package_dir/iterations/MODEL-ITERATION-001.md"
instantiate templates/review-iteration.md \
    "$package_dir/iterations/REVIEW-ITERATION-001.md"
instantiate templates/system-context.dot \
    "$package_dir/diagrams/system-context.dot"
instantiate templates/trust-boundaries.dot \
    "$package_dir/diagrams/trust-boundaries.dot"
instantiate templates/data-flows.dot \
    "$package_dir/diagrams/data-flows.dot"
instantiate templates/attack-tree.dot \
    "$package_dir/diagrams/attack-tree-001.dot"

printf '%s\n' "$package_dir"
