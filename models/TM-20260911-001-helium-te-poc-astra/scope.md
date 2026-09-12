# Threat-model scope

Package ID: `TM-20260911-001`
Title: Helium TE PoC Independent Threat Model (GPT-6 Astra)
Created: 2026-09-11
Status: `Complete`
Phase: `Paused`
Run state: `Paused`
Pause requested: 2026-09-11T23:52:08.181Z
Mode: `create-from-evidence`
Distribution: `private`
Latest model iteration: `MODEL-ITERATION-002`
Latest review iteration: `REVIEW-ITERATION-002`

## Operational pause

Established: the user explicitly requested pausing this TM run on
2026-09-11 at 16:52:08.181-07:00 (23:52:08.181Z). The analytical package
remains Complete and private; this pause does not reopen findings or alter
the confirmed scope, completed iterations, comparison or frozen baseline.
Further substantive work and verification-planning follow-up await explicit
user direction to resume. No target execution, owner-request dispatch, risk
acceptance or publication is authorized by the pause.

## Target snapshot

| Target | Logical locator | Revision | Worktree state | Included dirty paths | Checked |
| --- | --- | --- | --- | --- | --- |
| Helium (target) | `component://helium-te-poc/` | `1ab289c066b69acdd8b55c9f77055b0145be1316` | Clean; detached HEAD | None | 2026-09-11T05:37:07Z |
| Beryllium (historical design context only) | `component://beryllium-repo/` | `65f6d895a2007e8e093582cc48726375fd23b563` | Clean; branch `beryllium/single-hart-runtime-r0` | None | 2026-09-11T05:37:07Z |

Established: the maintained inspector resolved both full commits and reported
zero changed entries. The requesting user explicitly confirmed that both
registered views were owner-prepared and would remain unchanged during
specialist reads. This is an owner-stability attestation, not evidence of
filesystem-enforced immutability. No dirty or untracked content is approved.

Established: supporting source states were reported clean by the maintained
component inventory at 2026-09-11T05:37:07Z. They are evidence, not additional
implementation targets. Only exact-commit helper reads are permitted for
these sources unless another stable view is explicitly confirmed.

| Supporting component | Exact revision | Branch | Role |
| --- | --- | --- | --- |
| `workspace` | `4a91f7f88b41698fd896212f6cac7b2fba1c9c81` | `main` | Coordination and registry |
| `analysis-workbook` | `d003dece93e2072ce68399127464e23b554bafa3` | `main` | Completed, applicable AWB packages only |
| `cheri-riscv-notes-repo` | `655309289ee715cbe40690d41b222e3cba05e6b5` | `main` | Registered research context |
| `xrv-research-repo` | `ca414903b93cab82697a30ec2a57ed62c357d380` | `main` | Registered research context |
| `osr-claude` | `f2edd17c6ed70f09a9b3db98eec27e54e185612a` | `main` | Non-restricted research indexes only |

Established: `formal-verification-research` and `provenance-review` were
reported absent. Unknown: provenance and applicability of supporting material
remain subject to the ordered local pass.

## Effective scope

- Target type: One registered component.
- System or subsystem boundary: Complete fixed Type Enforcement proof of
  concept in its documented PoC deployment, including runtime and target-owned
  host build, evaluation, evidence, retained review, and publication support.
- Decision supported: Security-risk review, control-gap analysis, and
  verification priorities. No approval or risk acceptance.
- Lifecycle: Build/configuration; image/evidence generation; initialization;
  writer execution; exception/trap handling; writer-to-reader transition;
  reader execution; failure/recovery/shutdown; evaluation/publication
  preparation; teardown/disposal where evidence establishes behavior.
- Selected source model: None. User chose `Create from evidence`; eligible
  target-owned fragments and retained reviews are evidence, not authority.
- Included surfaces: All target-owned architecture, implementation,
  trusted/untrusted interfaces, privilege/domain transitions,
  memory/capability handling, configuration/build inputs,
  exception/interrupt-related paths, external dependencies, tests, retained
  reviews, evaluator/evidence mechanisms, publication controls, and documented
  assurance mechanisms.
- Historical context: Three committed July 20, 2026 Beryllium exchanges about
  TE/VBS suitability, multi-hart HS isolation, and CAP+TE/FLASK/CHERI, with
  linked curated planning records at the frozen Beryllium commit.
- Exclusions: Adjacent implementations are context, lineage, or interface
  evidence only. Later broad Beryllium runtime work is not the target. No
  target-owned surface is excluded. Workflow hardening, prior-package
  repairs, and target/sibling changes are outside this engagement.
- Blind-context exclusion: Until the new model and independent review are
  complete and their blind iterations frozen, do not read or search
  `models/TM-20260901-001-helium-te-poc/`,
  `models/TM-20260904-001-helium-te-poc-fable51/`,
  `THREAT-MODEL-RUN-COMPARISON-20260906.md`, the planning session's plan,
  conversation, checkpoints, or history, or downstream material importing
  those analyses. Target-owned retained reviews at the frozen target revision
  remain eligible. Stop and disclose any contamination.
- Restricted exclusion: Never access or copy
  `component://osr-claude/sources/restricted-microsoft/`.
- Security objectives: Proposed, to be derived from admitted evidence.
  Requested subjects are HS/TE/policy/G-stage integrity, subject-private
  confidentiality/integrity, writer-RW/reader-R shared-page semantics,
  policy-to-PTE consistency, trusted transitions and register/CSR state,
  fail-closed events, evidence/result integrity, and claim/provenance
  discipline. Intake subjects are not established design properties.
- Review depth: Deep; full hybrid method, adjacent interfaces and lifecycle
  context, deeper attack trees, bounded historical and negative searching,
  and counter-evidence.
- Local evidence order: Parent coordination; target instructions, handoff,
  design and code; target threat/security material; tests, assurance, claim
  limits and acceptance; completed PRV/AWB; registered research; public
  primary sources only for recorded gaps.
- Public research: Permitted only for locally recorded gaps, with generic
  public-safe terms. No private code, names, URLs, credentials, identifiers,
  or user-supplied private text in public queries.
- Initial and current distribution: `private`.
- Intended post-analysis distribution: Possible future `public-candidate`,
  separately responsible-human-gated. No promotion is requested in this run.
- Target commands: None; target execution is prohibited.
- Execution boundary: Only the seven maintained helpers allowed by the
  repository workflow; no target execution, arbitrary shell, direct Git,
  network clients, interpreters, installers, or substitution for failed
  helpers.
- Write boundary: This package and threat-modeler repository only. No
  staging or Git changes in parent/target/sibling repositories.
- Expected package: `models/TM-20260911-001-helium-te-poc-astra/`.
- Known limitations: Two absent registered components; unestablished
  independent execution/model provenance in retained target reviews;
  owner-attested rather than mechanically immutable evidence views;
  historical correspondence and external applicability still to assess.
  Blocking gaps stop the affected phase.
- Assurance boundary: Beryllium accepted through R7; R8-H0 a committed
  candidate, not accepted; K3 hardware `NOT RUN`. Helium is a review-and-test
  PoC, not formally verified or hardware validated. Selected C properties
  may be described as machine-checked by CBMC only within their exact
  recorded source/property/tool boundary.
- Human-decision boundary: No risk acceptance, exception approval, review
  approval, acceptance, sign-off, licensing, publication, release, formal
  verification, hardware validation, or promotion is granted or inferred.

## Execution configuration

Established: the current orchestrator runtime identifies itself as
`gpt-6-astra`. The user explicitly confirmed `gpt-6-astra` for every
specialist, with no silent fallback and no persistent profile edits. Local
agent profiles name `gpt-5.6-sol`; dispatch must explicitly override the model.
Requested and independently observable runtime metadata are separate fields
in `RUN-MANIFEST.md`.

Proposed: bounded parallel runtime and host-tooling evidence tasks implement
the requested fleet execution. Public gap research follows the local pass.
Independent model review follows a frozen model, DOT, and admitted evidence
set. The orchestrator owns admission, identifiers, synthesis, and artifacts.
Any later comparison is separate and non-normative; comparison-informed
changes cannot rewrite the blind baseline.

Established: the user separately authorized custom-specialist tool restoration
as maintenance while this engagement was paused, then explicitly directed
resumption on 2026-09-11. The specialist tool filters now explicitly name
read/search tools and, for research only, URL fetch/general web search; their
write-disabled capability boundary and profile model defaults are unchanged.
Every resumed analysis specialist is explicitly dispatched as `gpt-6-astra`.
The Astra capability gate passed and both target states stayed exact and
clean. No material target, boundary, lifecycle, objective, inclusion,
exclusion, depth, research-permission or distribution field changed; the
original effective scope remains in force. This records the authorized
maintenance exception to the original no-profile-edit plan, not permission
for further tooling work. TM-20260911-001-E0031,
TM-20260911-001-E0032.

## Confirmation

- Discovery-mode choice: `Create from evidence`, explicitly selected through
  `ask_user` after presentation of all 82 grouped discovery records.
- Scope confirmation: `Begin threat modeling`, explicitly selected through
  `ask_user` after the complete effective scope and Astra-only configuration.
- Requesting user: Interactive scope/stability confirmation; identity and
  responsible-human decision authority not authenticated or inferred.
- Confirmation date: 2026-09-11 UTC. No exact response timestamp was exposed.
- Allocation: Maintained UTC scaffolder returned this package identifier and
  creation date after confirmation.

## Activity

| Activity ID | Date | Actor | Action | Evidence IDs | Notes |
| --- | --- | --- | --- | --- | --- |
| ACTIVITY-001 | 2026-09-11 | Threat-modeler | Allocated a private draft package. | None | No substantive analysis has started. |
| ACTIVITY-002 | 2026-09-11 | Threat-modeler | Recorded fresh exact states, owner stability attestation, deterministic discovery, user mode choice, and full scope confirmation before analysis. | None | No prior TM package, comparison, or planning history opened; no dirty input approved. |
| ACTIVITY-003 | 2026-09-11 | Threat-modeler | Admitted exact-object runtime and host observations and drafted the full hybrid projection with 18 conditional threats and four abuse trees. | TM-20260911-001-E0012, TM-20260911-001-E0021, TM-20260911-001-E0025, TM-20260911-001-E0028 | Public semantic gaps and independent review remain pending; scope and snapshots unchanged. |
| ACTIVITY-004 | 2026-09-11 | Threat-modeler | Stopped the public-research phase at the actual specialist tool mismatch and requested an explicit continuation-path decision. | TM-20260911-001-E0030 | User unavailable; no answer or fallback authorization inferred. Original scope confirmation remains unchanged; dependent completion/review/comparison work is not represented as finished. |
| ACTIVITY-005 | 2026-09-11 | Threat-modeler | Resumed on the user's explicit instruction after a successful Astra-only custom-specialist capability gate and unchanged clean snapshot/hash checks. | TM-20260911-001-E0031, TM-20260911-001-E0032 | Original scope and blind exclusions preserved; maintenance controls are not imported as target-analysis results. |
| ACTIVITY-006 | 2026-09-11 | Threat-modeler | Completed the recorded public-semantic gaps, admitted twelve primary observations and prepared the blind model for independent review. | TM-20260911-001-E0033, TM-20260911-001-E0044 | No target or scope change; no extra numerical risk reduction from public documentation. |
| ACTIVITY-007 | 2026-09-11T22:02:10Z | Threat-modeler | Rechecked both exact clean snapshots, populated the first complete model iteration and retained immutable copies of the seven diagram sources for review. | TM-20260911-001-E0032 | Model and evidence input freeze does not complete the package or imply review approval; earlier models remain unopened. |
| ACTIVITY-008 | 2026-09-11T22:16:40Z | Threat-modeler | Confirmed unchanged first-review input hashes, admitted the independent return and incorporated three model corrections into a successor candidate. | TM-20260911-001-E0045 | No blocking user questions; first model/review iterations and retained DOT remain unchanged; bounded closure required. |
| ACTIVITY-009 | 2026-09-11T22:40:33Z | Threat-modeler | Verified unchanged closure-input hashes and exact clean targets; recorded same-reviewer closure of all three modeling findings in REVIEW-ITERATION-002. | TM-20260911-001-E0046 | Analysis and independent review complete; no human approval or target-risk closure; maintained completion validation still to run. |
| ACTIVITY-010 | 2026-09-11 | Threat-modeler | Passed maintained package completion validation, froze the completed blind baseline, regenerated the index and passed all 159 agent-contract checks. | TM-20260911-001-E0046 | Private package complete; earlier model content still unopened at the completion checkpoint; separate comparison may now proceed without rewriting this baseline. |
| ACTIVITY-011 | 2026-09-11T23:52:08.181Z | Requesting user / Threat-modeler | Recorded an explicit operational pause of this TM run and its follow-up. | None | Completed private analysis/review and frozen baseline preserved; resume only on explicit user direction. Timestamp is the user request. |
