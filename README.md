# Beryllium threat modeler

This independent component creates and reviews evidence-bound threat models for
registered Beryllium component snapshots. Invoke the user-facing agent with:

```text
/agent threat-modeler
```

For repository maintenance, validation, and explicitly authorized commit and
push operations, use:

```text
/agent threat-model-maintainer
```

The agent discovers existing threat and security material before asking the
user to choose one of three modes:

- review an existing model;
- review an existing model and draft a successor;
- create a model from design and assurance evidence.

It then freezes an exact clean revision or explicitly approved named dirty
state, allocates a private `TM-YYYYMMDD-NNN` package using UTC, applies the
Beryllium hybrid threat-modeling method, obtains an independent write-disabled
model review, renders diagrams, and records a restartable handoff.

## Safety boundary

Targets are limited to registered Beryllium components or a project-wide
snapshot composed only of registered components. Targets, sibling
repositories, parent coordination artifacts, user-supplied files, and web
content are read-only, untrusted evidence.

The threat-modeling agent writes only in this repository. It never executes,
builds, tests, imports, or installs target content. It uses only the maintained
local helper allowlist defined in `.github/copilot-instructions.md`. Public
research is performed through the web tool using generic public-safe terms.

The separate maintainer profile can edit and validate this repository and,
when explicitly authorized, stage, commit, and push its changes. It cannot
modify or execute registered targets, sibling repositories, or the parent
workspace.

Never access or copy
`component://osr-claude/sources/restricted-microsoft/`.

## Local requirements

The maintained helpers target the Beryllium Linux workstation environment and
require:

- Bash 4 or later;
- Git and GNU userland tools including `sed`, `awk`, `find`, `sort`, `cmp`,
  and `sha256sum`;
- Graphviz `dot` for SVG rendering and, when requested, PNG rendering.

The renderer strips Graphviz's version-only generator comment before writing
SVG, while retaining byte comparison for material layout changes. Missing
tools are reported as hard validation limitations; the agent never installs
them implicitly.

## Model method

Each complete model covers:

- system boundary and lifecycle;
- security objectives and protected assets;
- actors and capabilities;
- trusted computing base and dependencies;
- components, interfaces, entry points, data and control flows, and trust
  boundaries;
- STRIDE threats mapped to concrete surfaces;
- abuse cases and attack trees;
- assumptions, non-goals, controls, mitigations, and verification;
- inherent and residual 5x5 likelihood-impact risk with rationale and
  confidence;
- a coverage matrix.

Material statements are labeled `Established`, `Inferred`, `Proposed`, or
`Unknown`. Missing design facts remain unknown; blocking gaps return to the
user.

## Durable packages

```text
models/TM-YYYYMMDD-NNN-short-name/
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
  iterations/
    MODEL-ITERATION-NNN.md
    REVIEW-ITERATION-NNN.md
  diagrams/
    *.dot
    svg/*.svg
    png/*.png  # optional generated derivatives
```

Markdown is normative overall. Graphviz DOT is the normative diagram source;
SVG and optional PNG are generated. Current projections identify the latest
append-only model and review iterations. Evidence and activity corrections
append superseding records rather than rewriting history.

Every package starts `private`. Broader distribution requires a complete
responsible-human `HUMAN-PROMOTION-NNN` record. The agent never grants risk
acceptance, exception approval, review approval, acceptance, sign-off,
licensing, publication, release, formal verification, or hardware validation.

### PNG diagram derivatives

Enable PNG alongside SVG for one package through the maintained renderer:

```sh
bash ./scripts/render-diagrams.sh --png models/TM-YYYYMMDD-NNN-short-name
bash ./scripts/render-diagrams.sh --check models/TM-YYYYMMDD-NNN-short-name
```

SVG-only packages retain the default behavior. Once `diagrams/png/` exists,
normal rendering and checking maintain both formats, including through package
completion validation. Missing or stale enabled PNGs fail checking. Check mode
does not create the output directory or enable PNG implicitly.

PNG is an optional presentation derivative, not new model evidence or a change
to normative DOT. Do not hand-edit either generated format. Adding derivatives
to a paused run does not resume substantive analysis or permit modifying its
frozen baseline.

## Maintained commands

Repository checks:

```sh
bash ./tests/validate-agent.sh --agents-only
bash ./tests/validate-agent.sh
bash ./scripts/update-index.sh --check
git diff --check
```

Use `--agents-only` for the agent-profile and specialist tool/boundary contract
without reading model packages or checking their index, including during a
blind engagement. Specialists use explicit read/search tool names; only
`threat-research` also requests general web search and URL retrieval. A fresh
runtime probe must confirm those capabilities and the absence of
write/execute/delegation tools; the static contract check does not prove
runtime tool exposure. See `AGENT-INTERFACE.md`.

If fresh specialists still receive the old tool set after a profile edit,
reload the CLI with `/restart` and repeat the capability probe. Until the
required tools are actually exposed, the affected phase remains blocked; do
not substitute wildcard permissions or a full-tool agent.

Package operations are documented in
`.github/skills/beryllium-threat-modeling/SKILL.md`. The threat-modeler profile
may use only the maintained scripts listed in its execution allowlist. The
threat-model-maintainer profile may run repository checks such as `git diff
--check` and perform explicitly authorized Git delivery.

## Current assurance wording

Beryllium is accepted through R7. R8-H0 is a committed candidate and is not
accepted. K3 hardware is `NOT RUN`. Helium is a review-and-test proof of
concept, not a formally verified system and not hardware validated. Selected
Helium C properties are machine-checked by CBMC only within their stated
source, property, and tool boundary.
