# Threat-model package handoff

Package ID: `TM-20260904-001`
Title: Helium TE PoC Independent Threat Model (Fable 5.1 replay)
Created: 2026-09-04
Status: `Complete`
Distribution: `private`

## Overall position

`create-from-evidence` threat model of `component://helium-te-poc` at exact
clean commit `1ab289c066b69acdd8b55c9f77055b0145be1316` (`for-review`), with
`component://beryllium-repo` at `65f6d895a2007e8e093582cc48726375fd23b563` as
planning context. Produced independently of `TM-20260901-001` (excluded from
evidence by user instruction) for cross-model comparison.

Latest iterations: `MODEL-ITERATION-002`, `REVIEW-ITERATION-001`.

Position (`Inferred`): within the fixed single-hart QEMU profile, all
guest-boundary threats (THREAT-001 to THREAT-006, THREAT-009) reduce to `Low`
residual under evidence-supported controls, conditioned on QEMU 10.2.2
behaviour and unverified HS-mode C. Highest residual risks:

- THREAT-013 fabricated self-consistent evidence bundle — `High` (3x4);
- THREAT-008 HS-mode C defect corrupting policy/control state — `High` (2x5);
- THREAT-014 supply-chain compromise of build/platform inputs — `High` (2x5);
- THREAT-016 assurance-claim inflation / lineage misattribution — `Moderate`
  (3x3, upper bound; live hazard observed, E0004);
- THREAT-010 policy/PTE divergence undetected by same-domain readback —
  `Moderate` (2x4);
- THREAT-015 publication approval without the responsible human — `Moderate`
  (2x3).

Residual risk is not accepted risk. Helium is a review-and-test proof of
concept, not formally verified, not hardware validated; K3 hardware `NOT RUN`;
no CBMC harness exists at this commit. Beryllium is accepted through R7;
R8-H0 is a committed candidate and is not accepted.

## Blockers

- None for package completion.
- For confidence upgrades: primary RISC-V Privileged specification text
  (BLOCKED-001, BLOCKED-002); hardware run (MITIGATION-003); H6 human review of
  the exact commit is incomplete (E0052).
- For promotion beyond `private`: transcript-derived and target evidence carry
  `internal`/`unknown` redistribution (E0061); a responsible-human
  `HUMAN-PROMOTION-NNN` record is required and absent.

## Validation state

`render-diagrams.sh`, `validate-threat-model.sh` (completion mode),
`update-index.sh` and `tests/validate-agent.sh` were run on 2026-09-04; see
ACTIVITY-008 and the chat record. If any later run fails, the package must be
treated as incomplete.

## Next action

Responsible human: compare this package with `TM-20260901-001` (different
model, same intake) and decide whether either informs H6 review of
`helium-te-poc` @ `1ab289c`. Restartable agent action: re-attempt SEARCH-002/003
when public network access is available, append E0068+ with primary-text
confirmation, and record `MODEL-ITERATION-003` only if a rating changes.

## Exact artifact paths

- Scope and activity: `scope.md`
- Discovery inventory: `discovery.md`
- Current model projection: `threat-model.md`
- Current review projection: `review.md`
- Evidence ledger: `evidence-ledger.md` (E0001–E0067)
- Search record: `search-log.md`
- Open questions: `open-questions.md`
- Inaccessible resources: `inaccessible-resources.md`
- Source discoveries: `source-discoveries.md`
- Distribution checklist: `publication-checklist.md`
- Iterations: `iterations/MODEL-ITERATION-001.md`,
  `iterations/MODEL-ITERATION-002.md`, `iterations/REVIEW-ITERATION-001.md`
- Diagrams: `diagrams/system-context.dot`, `diagrams/trust-boundaries.dot`,
  `diagrams/data-flows.dot`, `diagrams/attack-tree-001.dot`,
  `diagrams/attack-tree-002.dot`; generated `diagrams/svg/*.svg`

## Activity

| Activity ID | Date | Actor | Action | Evidence IDs | Notes |
| --- | --- | --- | --- | --- | --- |
| ACTIVITY-001 | 2026-09-04 | Threat-modeler | Created the package handoff. | None | Append later activity; do not rewrite history. |
| ACTIVITY-002 | 2026-09-04 | Threat-modeler | Recorded frozen scope, discovery, evidence admission and first projection (see `scope.md` ACTIVITY-002–005). | TM-20260904-001-E0001–E0061 | Worktree-switch hazard during evidence pass recorded as `scope.md` ACTIVITY-004. |
| ACTIVITY-003 | 2026-09-04 | Threat-modeler | Recorded review, bounded public research, boundary deviations and corrections (see `scope.md` ACTIVITY-006–008). | TM-20260904-001-E0062–E0067 | Package complete and `private`; no promotion. |
