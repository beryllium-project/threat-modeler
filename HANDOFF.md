# Threat-modeler handoff

**Last updated:** 2026-08-29

## Overall position

The first complete component implementation is ready for its initial commit.
The repository is an independent Git worktree. It has no remote and nothing
has been pushed or published. Target and sibling components were inspected
read-only and were not modified.

The implementation includes:

- one user-facing `threat-modeler` orchestrator and three write-disabled
  specialists;
- registered-target and exact-snapshot rules;
- deterministic discovery and explicit mode confirmation;
- a private-first `TM-YYYYMMDD-NNN` package workflow;
- the hybrid STRIDE, attack-tree, risk, evidence, and coverage method;
- append-only model/review iterations and superseding evidence history;
- strict execution, public-query, assurance, and human-decision boundaries;
- collision-safe scaffolding, sanitized Git inspection, threat-material
  discovery, Graphviz rendering, generated indexing, semantic validation, and
  synthetic fixtures.

No real threat-model package has been created. `THREAT-MODELS.md` correctly
records an empty package set.

## Validation status

The complete maintained contract suite passed on 2026-08-29:

```sh
bash ./tests/validate-agent.sh
bash ./scripts/update-index.sh --check
git diff --check
```

`tests/validate-agent.sh` reported 138 passing tests and no failures after the
evidence, risk-rationale, review, identifier, diagram, discovery, and
append-only contracts were reconciled.

A separate read-only acceptance probe against the canonical Beryllium
implementation at
`65f6d895a2007e8e093582cc48726375fd23b563` found the embedded
`planning/implementation-plan.md` threat model,
`planning/pathfinder-evidence.md` threat-model delta, and
`pathfinder/docs/security-and-limits.md`. Project-wide discovery also found
maintained security and review material in registered research and review
components while excluding
`component://osr-claude/sources/restricted-microsoft/`.

The custom agent may run the maintained component checks in its allowlist.
`git diff --check` remains an outer maintainer check.

## Known limitations

- Project-wide discovery operates over registered committed snapshots. Any
  approved dirty state must remain a separately named and hashed overlay.
- A first real engagement has not been run; the implementation is validated
  with synthetic packages and read-only discovery probes.
- Discovery intentionally excludes source archives, generated HTML,
  dependency trees, build output, and test fixtures from the candidate
  inventory. Those sources remain available in later evidence tiers when
  explicitly relevant.
- The maintained scripts require Bash 4 or later, GNU userland, Git, and
  Graphviz `dot`.
- Promotion, risk acceptance, model approval, and assurance claims remain
  responsible-human gates even if structural validation succeeds.

## Restartable next action

From the `threat-modeler/` repository, start a fresh Copilot CLI session, run
`/agent threat-modeler`, select one registered target or the project-wide
snapshot, and verify that the agent presents discovery candidates before it
offers the review/create mode gate. Do not begin a substantive model package
unless that engagement is intended.
