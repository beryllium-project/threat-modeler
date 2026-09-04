# Threat-model scope

Package ID: `TM-20260901-001`
Title: Helium TE PoC Initial Threat Model
Created: 2026-09-01
Status: `Complete`
Phase: `Complete`
Mode: `create-from-evidence`
Distribution: `private`
Latest model iteration: `MODEL-ITERATION-001`
Latest review iteration: `REVIEW-ITERATION-001`

## Target snapshot

| Role | Target | Logical locator | Revision | Worktree state | Included dirty paths | Checked |
| --- | --- | --- | --- | --- | --- | --- |
| Modeled target | `helium-te-poc` | `component://helium-te-poc/` | `1ab289c066b69acdd8b55c9f77055b0145be1316` (`for-review`) | Clean | None | 2026-09-01T18:19:00Z |
| Historical design evidence only | `beryllium-repo` | `component://beryllium-repo/` | `65f6d895a2007e8e093582cc48726375fd23b563` (`beryllium/single-hart-runtime-r0`) | Clean | None | 2026-09-01T18:19:00Z |

## Effective scope

- System or subsystem boundary: The complete Helium fixed Type Enforcement
  proof of concept at the frozen target revision in its documented
  proof-of-concept deployment context. The boundary includes the target
  runtime and its host-side build, evaluation, evidence, review, and
  publication-support surfaces. The model supports review decisions about
  security risks, control gaps, and verification priorities.
- Lifecycle: Build and configuration input; image and evidence generation;
  initialization; writer execution; exception and trap handling;
  writer-to-reader transition; reader execution; failure, recovery, and
  shutdown behavior; evaluation and publication preparation; and teardown or
  disposal where evidence establishes behavior.
- Selected source model: None. Discovery found no standalone formal threat
  model. Embedded model fragments are non-authoritative evidence.
- Included surfaces: All target-owned architecture and implementation
  surfaces, including trusted and untrusted interfaces, privilege and domain
  transitions, memory and capability handling, configuration and build
  inputs, exception and interrupt-related paths, external dependencies,
  tests, retained reviews, evaluator and evidence mechanisms, publication
  controls, and documented assurance mechanisms. Historical rationale also
  includes three committed verbatim 2026-07-20 Beryllium exchanges about
  TE/VBS suitability, multi-hart HS isolation, and CAP+TE/FLASK/CHERI, plus
  their linked curated planning records.
- Exclusions: No target-owned surface is excluded. Adjacent Beryllium
  components are interface, lineage, or context evidence only and are not
  modeled as in-scope implementations. Later broad Beryllium runtime work is
  not imported into Helium's boundary. Hardware validation, formal
  verification beyond exact recorded boundaries, risk acceptance, release or
  publication approval, and
  `component://osr-claude/sources/restricted-microsoft/` are excluded.
- Security objectives: Derive provisional objectives from admitted evidence
  and label them accordingly. Expected subjects include integrity of
  HS/TE/policy/G-stage state; confidentiality and integrity of
  subject-private state; writer-RW/reader-R shared-page semantics;
  policy-to-PTE consistency; trusted transition and register/CSR state;
  fail-closed event handling; evidence and result integrity; and claim and
  provenance discipline.
- Review depth: `Deep`.
- Public research: Permitted only for gaps recorded after the local evidence
  pass, using generic public-safe terms.
- Local evidence order: Parent coordination; target instructions, handoff,
  design, and code plus the confirmed historical transcript lineage;
  existing threat and security material; tests, assurance, claim limits, and
  acceptance records; completed PRV and AWB packages at exact committed
  snapshots only; relevant registered research components; then public
  primary sources for recorded gaps.
- Initial distribution: `private`.
- Intended post-analysis distribution: Request `public-candidate`. This is an
  intention only and does not promote the package.
- Target commands: None; target execution is prohibited.
- Write boundary: This package and repository only.
- Known limitations: No formal source model, hardware validation, or complete
  formal verification exists. Retained AI reviews cover older commits and
  have self-attested or incomplete provenance. The maintained remediation
  ledger contains stale worktree-status wording. Larger raw session reports
  are unavailable outside the three committed transcript pages. Historical
  chat redistribution authority is unknown. Dirty external overlays,
  including the current `provenance-review` overlay, are excluded.

## Confirmation

- Discovery-mode choice: User selected `Create from evidence`.
- Scope confirmation: User selected `Begin threat modeling` after review of
  the complete effective scope.
- Responsible human: User in this engagement; identity not independently
  established. This is scope confirmation, not approval or promotion.
- Confirmation date: 2026-09-01.

## Activity

| Activity ID | Date | Actor | Action | Evidence IDs | Notes |
| --- | --- | --- | --- | --- | --- |
| ACTIVITY-001 | 2026-09-01 | Threat-modeler | Allocated a private draft package. | None | No substantive analysis has started. |
| ACTIVITY-002 | 2026-09-01 | Threat-modeler | Froze the clean Helium target and clean historical Beryllium evidence snapshot. | None | No dirty content was approved or included. |
| ACTIVITY-003 | 2026-09-01 | User and threat-modeler | Confirmed create-from-evidence mode and the complete effective scope. | None | Intended `public-candidate` distribution does not change the private package state. |
