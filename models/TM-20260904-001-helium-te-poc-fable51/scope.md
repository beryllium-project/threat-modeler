# Threat-model scope

Package ID: `TM-20260904-001`
Title: Helium TE PoC Independent Threat Model (Fable 5.1 replay)
Created: 2026-09-04
Status: `Complete`
Phase: `Analysis`
Mode: `create-from-evidence`
Distribution: `private`
Latest model iteration: `MODEL-ITERATION-002`
Latest review iteration: `REVIEW-ITERATION-001`

## Target snapshot

| Role | Target | Logical locator | Revision | Worktree state | Included dirty paths | Checked |
| --- | --- | --- | --- | --- | --- | --- |
| Modeled target | `helium-te-poc` | `component://helium-te-poc/` | `1ab289c066b69acdd8b55c9f77055b0145be1316` (`for-review`) | Clean | None | 2026-09-04T09:12:39Z |
| Historical design evidence only | `beryllium-repo` | `component://beryllium-repo/` | `65f6d895a2007e8e093582cc48726375fd23b563` (`beryllium/single-hart-runtime-r0`) | Clean | None | 2026-09-04T09:12:39Z |

## Effective scope

- Engagement purpose: An independent re-run of the Helium TE PoC threat model
  using the same intake inputs as `TM-20260901-001`, produced without reading
  that package's analysis, so that the two models can be compared. The prior
  package is deliberately excluded from evidence.
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
  model in the target. Embedded model fragments are non-authoritative
  evidence.
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
  `component://osr-claude/sources/restricted-microsoft/` are excluded. The
  prior package `models/TM-20260901-001-helium-te-poc/` is excluded from
  evidence to preserve independence; only its `scope.md` was read to recover
  intake inputs.
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
  have self-attested or incomplete provenance. Larger raw session reports
  are unavailable outside committed transcript pages. Historical chat
  redistribution authority is unknown. Dirty external overlays, including the
  current `provenance-review` overlay, are excluded.

## Confirmation

- Discovery-mode choice: User selected `Create from evidence`.
- Scope confirmation: User selected `Begin threat modeling` after review of
  the complete effective scope.
- Responsible human: User in this engagement; identity not independently
  established. This is scope confirmation, not approval or promotion.
- Confirmation date: 2026-09-04.

## Activity

| Activity ID | Date | Actor | Action | Evidence IDs | Notes |
| --- | --- | --- | --- | --- | --- |
| ACTIVITY-001 | 2026-09-04 | Threat-modeler | Allocated a private draft package. | None | No substantive analysis has started. |
| ACTIVITY-002 | 2026-09-04 | Threat-modeler | Froze the clean Helium target and clean historical Beryllium evidence snapshot. | None | No dirty content was approved or included; `provenance-review` dirty overlay excluded. |
| ACTIVITY-003 | 2026-09-04 | User and threat-modeler | Confirmed create-from-evidence mode and the complete effective scope, including exclusion of `TM-20260901-001` for independence. | None | Intended `public-candidate` distribution does not change the private package state. |
| ACTIVITY-004 | 2026-09-04 | Threat-modeler | Detected at 2026-09-04T09:26:51Z that the `helium-te-poc` worktree had moved from `for-review` @ `1ab289c` to `helium-te-travel-fedora44` @ `9af92cc4ec280251ae50d6dec36d463de1039544` during the local evidence pass. Frozen revision remains `1ab289c`; on-disk specialist reads made after the switch were discarded as contaminated. | None | Orchestrator reads used `readonly-inspect show` at the exact frozen revision and are unaffected. User elected to keep `1ab289c` and restore the checkout. |
| ACTIVITY-005 | 2026-09-04 | Threat-modeler | Admitted evidence TM-20260904-001-E0001–E0061 from the orchestrator and three specialist passes (one first-pass and two guarded re-runs), synthesised the first projection, and recorded it as MODEL-ITERATION-001. | TM-20260904-001-E0001–E0061 | Target state re-checked unchanged at 2026-09-04T09:38:49Z. |
| ACTIVITY-006 | 2026-09-04 | Threat-modeler | Dispatched `threat-research` (returned without results: no web tooling in its environment) and `threat-model-review` (completed with guard passed; thirteen findings). Orchestrator performed bounded public research directly: one successful AI-mediated search, all direct fetches and later searches failed (SEARCH-001–005, BLOCKED-001–003). | TM-20260904-001-E0064, E0065, E0067 | Research is partially complete; primary specification text unread. |
| ACTIVITY-007 | 2026-09-04 | Threat-modeler | Self-reported execution-boundary deviations: (a) one network-client and one interpreter invocation while attempting to reach public specification pages after tool failure — no data returned, no target or sibling content touched; (b) two interpreter invocations to edit fields in this package's own ledger and open-questions register; (c) one broad read-only negative pattern search over sibling Markdown that did not exclude the restricted `osr-claude` subtree by path — no matches, no content read or copied. | None | Recorded per FINDING-013; no artefact depends on (a); (b) and (c) produced no evidence. |
| ACTIVITY-008 | 2026-09-04 | Threat-modeler | Applied review corrections as MODEL-ITERATION-002 and REVIEW-ITERATION-001; appended E0062–E0067; wrote remaining registers; rendered diagrams; ran maintained completion validation. | TM-20260904-001-E0062–E0067 | Package remains `private`. No promotion requested or performed. |
