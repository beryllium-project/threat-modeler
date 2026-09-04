# MODEL-ITERATION-002

Package ID: `TM-20260904-001`
Title: Helium TE PoC Independent Threat Model (Fable 5.1 replay)
Created: 2026-09-04
Status: `Complete`
Distribution: `private`
Supersedes: MODEL-ITERATION-001

## Scope of this iteration

Post-review correction of the first projection. Target snapshot unchanged:
`component://helium-te-poc` @ `1ab289c066b69acdd8b55c9f77055b0145be1316`
(`for-review`, clean); `component://beryllium-repo` @
`65f6d895a2007e8e093582cc48726375fd23b563` (clean). Incorporates
REVIEW-ITERATION-001 (FINDING-001 to FINDING-013) and the bounded public gap
research (SEARCH-001 to SEARCH-005).

## Material changes

- Execution-evidence discipline (FINDING-001): residual rationales for
  THREAT-001, THREAT-003, THREAT-004, THREAT-006 now state what maintained
  tests and negative images are designed to check; Confidence lowered to
  `Medium`; executive summary and residual section carry an explicit
  no-execution statement.
- Risk arithmetic (FINDING-002, FINDING-007): THREAT-016 residual 3x3 corrected
  to `Moderate`; THREAT-014 residual impact restored to 5 (2x5 `High`) with
  rationale. Highest-risk ordering is now THREAT-013, THREAT-008, THREAT-014
  (`High`), then THREAT-016, THREAT-010, THREAT-015 (`Moderate`).
- Actors and abuse cases (FINDING-004, FINDING-005): ACTOR-010 (remote network
  peer) added; THREAT-018 re-scoped; ATTACK-002 gains branch 6 (publication-gate
  bypass) and `diagrams/attack-tree-002.dot`.
- Coverage (FINDING-004): per-surface STRIDE disposition table added under the
  coverage matrix.
- Diagrams (FINDING-006): `data-flows.dot` now shows FLOW-009 (source → image →
  boot) and FLOW-007/008 through OpenSBI to the validator.
- Wording (FINDING-008, FINDING-010): executive summary restates the accepted
  trap surface as three causes and seven PC/phase-bound events; hardware
  `NOT RUN` named in emulator-dependent uncertainties.
- Assumptions (FINDING-009): ASSUMPTION-002/003 distinguish the assumption
  being made (`Established`) from its truth (`Unknown`); ASSUMPTION-004 cites
  E0064.
- Evidence (FINDING-003, FINDING-011): citations repointed from E0015, E0022,
  E0032 to superseding E0062, E0063, E0066; public secondary-source records
  E0064 (`HFENCE.GVMA x0,x0` scope) and E0065 (`htval` may be zero) cited by
  THREAT-005, THREAT-017, ASSUMPTION-004; OPEN-001 partially and OPEN-006
  answered at specification level.

No objective, asset, boundary, flow, entry point, control or mitigation was
removed. No threat was added or removed.

## Evidence basis

TM-20260904-001-E0001 through E0067 (E0015, E0022, E0032 superseded, retained).

## Limitations

- Still no target execution; ratings rest on QEMU 10.2.2 behaviour and
  unverified HS-mode C; K3 hardware `NOT RUN`; Helium is a review-and-test PoC,
  not formally verified and not hardware validated; no CBMC harness at this
  commit.
- Public confirmation of fence and `htval` semantics is from secondary
  summaries only; primary specification text was inaccessible (BLOCKED-001,
  BLOCKED-002).
- Single specialist review pass; H6 human review of the target incomplete.
