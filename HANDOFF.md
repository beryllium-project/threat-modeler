# Threat-modeler handoff

**Last updated:** 2026-09-15

## Current TM run: paused

Established: the user requested an operational pause of `TM-20260911-001`
at 2026-09-11T23:52:08.181Z (16:52:08.181-07:00).
The package is `models/TM-20260911-001-helium-te-poc-astra/`.
Its completed private `MODEL-ITERATION-002`, `REVIEW-ITERATION-002`,
post-freeze comparison and hash-bound blind baseline are preserved.

Next action: await explicit user direction to resume. Do not automatically
start research, verification planning, an owner handoff, target-side work or
publication for this run. Its package `HANDOFF.md`, `scope.md` and
`RUN-MANIFEST.md` record the pause separately from analytical completion.

An explicitly requested format-only follow-up added seven PNG derivatives
alongside unchanged SVGs in that package. The TM run remains paused.

Repository delivery is complete under `PMR-028`. The owner package commit
`5bf6a4b` and Project Manager coordination carry `f4eb272` were reviewed,
maintained validation passed, and current `main` was backed up to its private
`origin/main`. This is private backup, not publication, package promotion,
model approval, risk acceptance or resumption of the paused run.

## Project Manager tasking return

- `PMR-028`: complete as described above.
- `PMR-004`: adopted. `project-manager` is a registered exact-snapshot target
  while retaining its separate Tier 1 coordination role.
- `PMR-022`: adopted. `security-reviewer` is a registered exact-snapshot
  target.

Both registrations are enforced by `scripts/readonly-inspect.sh` and its
maintained contract tests. This owner maintenance changes no target or sibling
repository and grants no approval, acceptance, publication or release gate.

## Historical implementation handoff (2026-08-29)

The remaining sections preserve the earlier implementation handoff, including
its then-current empty-package and validation statements. They are historical,
not the current TM run state or permission to resume the paused run.

### Overall position

The first complete component implementation is committed and privately backed
up. The repository is an independent Git worktree. Private `origin` is
`https://github.com/beryllium-project/threat-modeler.git`, and `main` has been
pushed through the authenticated `xjamesmorris` account. Nothing has been
published publicly. Target and sibling components were inspected read-only and
were not modified.

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

The implementation commit is `87ca820`. The current branch adds only this
private-remote handoff update over that validated implementation.

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
