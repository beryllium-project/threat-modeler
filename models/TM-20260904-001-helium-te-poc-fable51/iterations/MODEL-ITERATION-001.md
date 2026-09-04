# MODEL-ITERATION-001

Package ID: `TM-20260904-001`
Title: Helium TE PoC Independent Threat Model (Fable 5.1 replay)
Created: 2026-09-04
Status: `Complete`
Distribution: `private`
Supersedes: None

## Scope of this iteration

First complete projection created from evidence for `component://helium-te-poc`
at exact clean commit `1ab289c066b69acdd8b55c9f77055b0145be1316` (branch
`for-review`), with `component://beryllium-repo` at
`65f6d895a2007e8e093582cc48726375fd23b563` as planning context. Mode
`create-from-evidence`; depth `Standard`; public research permitted for
recorded gaps. The prior package `TM-20260901-001` was excluded from evidence by
user instruction so that the two projections can be compared independently.

## Material changes

Initial content (no prior iteration):

- OBJECTIVE-001 to OBJECTIVE-007; ASSET-001 to ASSET-011; ACTOR-001 to
  ACTOR-009; BOUNDARY-001 to BOUNDARY-005; FLOW-001 to FLOW-010; ENTRY-001 to
  ENTRY-009.
- THREAT-001 to THREAT-018 with inherent and residual 5x5 ratings.
- ATTACK-001 (hostile linked payload) and ATTACK-002 (false or inflated
  assurance claim).
- CONTROL-001 to CONTROL-014 (existing, evidence-supported); MITIGATION-001 to
  MITIGATION-010 (proposed).
- ASSUMPTION-001 to ASSUMPTION-008; OPEN-001 to OPEN-006.
- Four normative DOT diagrams and generated SVG.

Position: guest-boundary threats reduce to `Low` residual under
evidence-supported controls in the fixed QEMU profile; residual risk is
dominated by THREAT-016 (claim inflation and lineage misattribution, `High`),
THREAT-013 (fabricated self-consistent evidence, `High`), THREAT-008 (HS-mode C
defect, `High` on impact), THREAT-010, THREAT-014 and THREAT-015 (`Moderate`).

## Evidence basis

TM-20260904-001-E0001 through TM-20260904-001-E0061 in `evidence-ledger.md`:
orchestrator state and discovery records (E0001–E0004); target design, limits
and code at the frozen commit (E0005–E0041); tests, reviews and assurance
records (E0042–E0052); parent coordination, completed PRV and AWB packages,
Beryllium planning transcripts and registered research (E0053–E0061). Two
specialist evidence passes were discarded before admission because the target
worktree was found on a different branch during their reads (`ACTIVITY-004`).

## Limitations

- No target code was executed; QEMU, unit and negative-image results are read
  from test sources and maintained documentation, not observed.
- All ratings rest on QEMU 10.2.2 behaviour and unverified HS-mode C; K3
  hardware is `NOT RUN`; Helium is a review-and-test PoC, not formally verified
  and not hardware validated; no CBMC harness exists at this commit.
- Public gap research (OPEN-001, OPEN-006) was dispatched after this projection
  was frozen; its results are recorded in `search-log.md` and appended evidence
  and, if material, would produce `MODEL-ITERATION-002`.
- Nothing in this iteration is acceptance, approval, sign-off or risk
  acceptance.
