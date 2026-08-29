# Beryllium threat modeler

This independent component creates and reviews evidence-bound threat models for
registered Beryllium component snapshots. Invoke the user-facing agent with:

```text
/agent threat-modeler
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

The agent writes only in this repository. It never executes, builds, tests,
imports, or installs target content. It uses only the maintained local helper
allowlist defined in `.github/copilot-instructions.md`. Public research is
performed through the web tool using generic public-safe terms.

Never access or copy
`component://osr-claude/sources/restricted-microsoft/`.

## Local requirements

The maintained helpers target the Beryllium Linux workstation environment and
require:

- Bash 4 or later;
- Git and GNU userland tools including `sed`, `awk`, `find`, `sort`, `cmp`,
  and `sha256sum`;
- Graphviz `dot` for SVG rendering.

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
```

Markdown is normative overall. Graphviz DOT is the normative diagram source;
SVG is generated. Current projections identify the latest append-only model
and review iterations. Evidence and activity corrections append superseding
records rather than rewriting history.

Every package starts `private`. Broader distribution requires a complete
responsible-human `HUMAN-PROMOTION-NNN` record. The agent never grants risk
acceptance, exception approval, review approval, acceptance, sign-off,
licensing, publication, release, formal verification, or hardware validation.

## Maintained commands

Repository checks:

```sh
bash ./tests/validate-agent.sh
bash ./scripts/update-index.sh --check
git diff --check
```

Package operations are documented in
`.github/skills/beryllium-threat-modeling/SKILL.md`. The custom agent may use
only the maintained scripts listed in its execution allowlist; `git diff
--check` is an outer maintainer check, not an agent command.

## Current assurance wording

Beryllium is accepted through R7. R8-H0 is a committed candidate and is not
accepted. K3 hardware is `NOT RUN`. Helium is a review-and-test proof of
concept, not a formally verified system and not hardware validated. Selected
Helium C properties are machine-checked by CBMC only within their stated
source, property, and tool boundary.
