# MODEL-ITERATION-002

Package ID: `TM-20260911-001`
Title: Helium TE PoC Independent Threat Model (GPT-6 Astra)
Created: 2026-09-11
Status: `Complete`
Distribution: `private`
Supersedes: MODEL-ITERATION-001

## Scope, method and position

Established: this is the complete normalized successor projection, not a
delta requiring mutable prior text. It incorporates FINDING-001/002/003
from the first independent Astra review. The first model/review iterations and
their DOT copies remain unchanged. No earlier-model comparison has occurred.
The expanded projection and retained diagram sources are bound by
`REVIEW-INPUT-002.md`; bounded reviewer closure remains pending.
TM-20260911-001-E0045.

Established: mode create-from-evidence; target clean/detached
`component://helium-te-poc/` at
`1ab289c066b69acdd8b55c9f77055b0145be1316`; historical context only
`component://beryllium-repo/` at
`65f6d895a2007e8e093582cc48726375fd23b563` on
`beryllium/single-hart-runtime-r0`. Both rechecked clean/unchanged at
2026-09-11T22:02:10Z. Owner attestation is not filesystem-enforced
immutability. Evidence E0001-E0045 retains exact-object source observations,
bounded public references and the first review.
TM-20260911-001-E0001, TM-20260911-001-E0032.

Established: full fixed-TE runtime and target-owned host build/evaluation,
evidence, review and publication-support lifecycle are considered. The
three July 20 Beryllium exchanges/curated records are historical context,
not selected implementations. Later broad runtime, CHERI/CAP+TE/VBS results,
earlier TM packages/comparison/planning history and restricted Microsoft
sources are excluded. No target execution, editing, human gate or risk
acceptance is authorized.
TM-20260911-001-E0006 through TM-20260911-001-E0012.

Inferred: source controls constrain fixed direct-access and transition cases.
No executed exploit, successful exact-target run or arbitrary isolation is
established. Six conditional residual risks remain High (12/25):
THREAT-007/008/009/011/013/015. THREAT-014 now retains 9/25 without
default-derived credit for deliberate exceptions. New permitted-output
THREAT-019 is conditional 9/25; no leak is demonstrated.

Established: labels are Established, Inferred, Proposed and Unknown.
Controls are established mechanisms, not measured effectiveness. Inferred
credit is conditional on the named mechanism/profile; proposed mitigations
earn none. The 5x5 ordinal method uses L/I 1-5, from rare/negligible through
plausible/material to readily-repeatable/critical. Products 1-4 Low, 5-9
Moderate, 10-16 High and 17-25 Critical. Confidence is distinct from
likelihood; scores are not observed frequencies or acceptance.

Established: local tiers are complete at their recorded source-led depth,
with unavailable PRV/formal research, unpinned PM and unadmitted AWB
limitations. Public OPEN-003/004 are resolved at semantic-reference depth;
living/unknown-version qualifiers remain. OPEN-002/005/006/007/008/010
limit stronger contextual, execution, environmental, lifecycle and disclosure
claims. No blocking user question is needed for the explicit conditional
analysis. TM-20260911-001-E0010, TM-20260911-001-E0011,
TM-20260911-001-E0033 through TM-20260911-001-E0045.

## Lifecycle and components

| Stage/component | Label | Behavior, interface and authority | Limits / evidence |
| --- | --- | --- | --- |
| Native build/configuration | Established | Explicit host commands, fixed source/policy/layout, canonical outputs, separate JSON report | Tools/source trusted; no executable-rule sandbox; TM-20260911-001-E0020 |
| Image dependencies | Established | Networked construction from declared files, pinned base, mutable package/lock closure records | Installed code/authenticity unknown; TM-20260911-001-E0022 |
| Boot | Established | Firmware -> HS; BSS and 8 KiB stack before late hart check; FDT ignored | Not multicore-safe bootstrap proof; TM-20260911-001-E0017 |
| TE/config | Established | Trusted bounded labeling/sealing/rules; no guest parser, dynamic policy or CHERI | HS storage/initializer trust; TM-20260911-001-E0012, TM-20260911-001-E0013 |
| G-stage | Established | Trusted HPA/storage inputs, fixed GPAs/RWX, two roots, private absence/shared asymmetry | Backing identity/platform trust; TM-20260911-001-E0014 |
| Writer | Established | Private RW, common RX, shared RW; finite events and cross-private load | Untrusted-role model not replacement payload; TM-20260911-001-E0015 |
| Trap/recovery | Established | Saved state/CSR/fault/event checks, exact PC/phase; four-byte recovery or terminal failure | Non-nesting and exact instruction assumptions; TM-20260911-001-E0015, TM-20260911-001-E0016 |
| Reader transition | Established | GPR/frame/VS reset, root/PC/SP selection, fences/readback | Named state, not universal noninterference; TM-20260911-001-E0016 |
| Reader | Established | Own RW/common RX/shared R, expected store/load denials and final selected words | Not every byte/channel tested; TM-20260911-001-E0015, TM-20260911-001-E0019 |
| Shutdown | Established | Terminal result, SBI request/legacy fallback/WFI | No runtime watchdog, restart service or scrub; TM-20260911-001-E0017 |
| Evaluator | Established | Native preflight precedes restricted captured-image work, readable source/provenance, checked exports | Ordinary confinement differs from dependency failure and semantic disclosure; TM-20260911-001-E0021, TM-20260911-001-E0023, TM-20260911-001-E0024 |
| Evidence tools | Established | Blob/type/hash/tool/report/trace comparison and namespace checking | Correspondence is not authenticity or disclosure authority; TM-20260911-001-E0025, TM-20260911-001-E0026 |
| Docs/review/gate | Established | Generated HTTP/browser input, retained review provenance, blocked structural gate | No actual human authentication or content approval; TM-20260911-001-E0027, TM-20260911-001-E0028 |
| Update/reuse/disposal | Unknown | New source needs a new exact scope; retention/interruption/erasure unresolved | No dynamic lifecycle invented; TM-20260911-001-E0018, TM-20260911-001-E0029 |

Established: runtime TCB includes fixed policy/configuration, C/storage/linker,
privileged assembly, compiler/linker, firmware and emulator/ISA behavior.
Host TCB includes native tools/filesystem, documentation/browser dependencies,
package/image producers, Podman/OCI/kernel/SELinux and evidence/checker code.
Fixture layout is trusted for interpreting the experiment, while VS actions
are untrusted for mediation. Public references E0033-E0044 qualify these
dependencies without adding measured execution, coherence, binary,
installed-closure, erasure or authentication credit.

## Objectives and assets

All objectives are Proposed; confidence High except OBJECTIVE-007 Medium.
Their evidence and limits are retained below.

| ID | Objective and limitation | Evidence |
| --- | --- | --- |
| OBJECTIVE-001 | Preserve HS/policy/root/trusted-state integrity; not a proof | TM-20260911-001-E0012, TM-20260911-001-E0016 |
| OBJECTIVE-002 | Deny unapproved direct private access; preserve writer-RW/reader-R sharing, not arbitrary noninterference | TM-20260911-001-E0012, TM-20260911-001-E0014 |
| OBJECTIVE-003 | Reject invalid transitions and distinguish finite success/failure honestly; no progress SLA | TM-20260911-001-E0015, TM-20260911-001-E0017 |
| OBJECTIVE-004 | Preserve source/build/tool/artifact correspondence and interpretation; authenticity unknown | TM-20260911-001-E0020, TM-20260911-001-E0025, TM-20260911-001-E0026 |
| OBJECTIVE-005 | Protect host/source C/I within the specified evaluator/disclosure boundary; no arbitrary-tree sandbox | TM-20260911-001-E0021, TM-20260911-001-E0023, TM-20260911-001-E0045 |
| OBJECTIVE-006 | Preserve provenance/claims and separate human/disclosure decisions; no authority inferred | TM-20260911-001-E0005, TM-20260911-001-E0028 |
| OBJECTIVE-007 | Define safe recovery/freshness/resource use/disposal; requirements open | TM-20260911-001-E0017, TM-20260911-001-E0029 |

| ID | Label / confidence | Asset/property | Authority | Evidence |
| --- | --- | --- | --- | --- |
| ASSET-001 | Established / High | HS code/stack/TE/config/rules/tables: integrity and exclusive trusted mutation | HS; human ownership not inferred | TM-20260911-001-E0012, TM-20260911-001-E0013 |
| ASSET-002 | Established / High | Writer-private stack/data: direct-access C/I against reader | Monitor-assigned writer | TM-20260911-001-E0012 |
| ASSET-003 | Established / High | Reader-private stack/data: direct-access C/I against writer | Monitor-assigned reader | TM-20260911-001-E0012 |
| ASSET-004 | Established / High | Common RX code integrity and shared writer-RW/reader-R data | Fixed policy/HS mappings | TM-20260911-001-E0012, TM-20260911-001-E0014 |
| ASSET-005 | Established / High | Subject/phase/GPR/CSR/root/SP: correct binding/reset/order | HS only | TM-20260911-001-E0015, TM-20260911-001-E0016 |
| ASSET-006 | Inferred / Medium | Host checkout/Git/user data/evaluator state: C/I and bounded work | Invoking account; exact secrets/owners unknown | TM-20260911-001-E0021, TM-20260911-001-E0023 |
| ASSET-007 | Established / High | Images/closure/reports/logs/bundles: integrity/freshness/correspondence/provenance; Proposed authorized disclosure of embedded private input | Producers/checkers; no authenticated trust root | TM-20260911-001-E0022, TM-20260911-001-E0025 |
| ASSET-008 | Established / High | Docs/reviews: attribution/limits/appropriate disclosure | Source and separate human review | TM-20260911-001-E0027, TM-20260911-001-E0028 |
| ASSET-009 | Established / High | Gate/decision metadata: integrity/non-impersonation | Responsible human, not agent | TM-20260911-001-E0028 |

## Actors

All are Inferred/Medium except ACTOR-007 Proposed/Medium. No replacement
payload, actual misconduct or recipient mismatch is assumed established.

| ID | Trust/access/constraints | Goals | Evidence |
| --- | --- | --- | --- |
| ACTOR-001 | Untrusted writer VS, mapped state/events; no HS policy API | Cross-private access, false events, stalled progress | TM-20260911-001-E0012, TM-20260911-001-E0015 |
| ACTOR-002 | Untrusted reader VS, reader mappings/events, shared read only | Shared write, writer-private access, false completion | TM-20260911-001-E0012, TM-20260911-001-E0015 |
| ACTOR-003 | Required privileged dependency trust: HS, firmware/emulator or host kernel/OCI according to failed component | Bypass/misimplement assumed enforcement | TM-20260911-001-E0013, TM-20260911-001-E0017, TM-20260911-001-E0023 |
| ACTOR-004 | Source/dependency/image/evidence producer; input/output influence, not assumed direct HS access | Poison execution/evidence; conditional disclosure through accepted contents | TM-20260911-001-E0021, TM-20260911-001-E0022, TM-20260911-001-E0025 |
| ACTOR-005 | Fallible operator or conditional host actor with permitted file/override/distribution authority | Misconfiguration, substitution, resource use/disclosure | TM-20260911-001-E0020, TM-20260911-001-E0024 |
| ACTOR-006 | Document/output client; loopback default, remote exposure and entitlement conditions explicit | Obtain content, confuse interpretation or exhaust service | TM-20260911-001-E0027 |
| ACTOR-007 | Separate human reviewer/publisher, potentially mistaken/deceived; rights not presumed | Legitimate decisions; conditional recipient role | TM-20260911-001-E0028 |

## Boundaries, flows and entries

All boundaries are Established/High except BOUNDARY-009 Inferred/Medium.

| ID | Crossing and enforcement limit | Evidence |
| --- | --- | --- |
| BOUNDARY-001 | Source/dependencies -> native host/build; graph checks, not arbitrary-source confinement | TM-20260911-001-E0020, TM-20260911-001-E0021 |
| BOUNDARY-002 | Platform -> HS; required trust/selected checks | TM-20260911-001-E0016, TM-20260911-001-E0017 |
| BOUNDARY-003 | VS/HS state; exact event/fault/transition code | TM-20260911-001-E0015, TM-20260911-001-E0016 |
| BOUNDARY-004 | Subject private/shared memory; policy-derived roots | TM-20260911-001-E0012, TM-20260911-001-E0014 |
| BOUNDARY-005 | Retained container/host; requested restrictions, probes/fingerprints; dependency/disclosure limits separate | TM-20260911-001-E0023, TM-20260911-001-E0024 |
| BOUNDARY-006 | Produced artifacts -> interpretation; correspondence not authenticity/confidentiality | TM-20260911-001-E0025, TM-20260911-001-E0026 |
| BOUNDARY-007 | Docs/browser/HTTP -> host/client; defaults/routes/readiness, not semantic approval | TM-20260911-001-E0027 |
| BOUNDARY-008 | Automation -> human decision/disclosure; blocked structural gate, not authentication | TM-20260911-001-E0028 |
| BOUNDARY-009 | Run -> reuse/disposal; partial cleanup/rollback and unknown requirements | TM-20260911-001-E0018, TM-20260911-001-E0029 |

Flows are Established except FLOW-014 Inferred; conditional unauthorized
disclosure is an Inferred misuse of existing flows, not a new implemented
export interface.

| ID | Source -> destination, data/authority and control | Boundaries | Evidence |
| --- | --- | --- | --- |
| FLOW-001 | Source/config/packages -> native tools/image; executable inputs/metadata; fixed graph/context | BOUNDARY-001 | TM-20260911-001-E0020, TM-20260911-001-E0022 |
| FLOW-002 | Firmware/platform -> HS; hart/state/image; fixed assumptions | BOUNDARY-002 | TM-20260911-001-E0017 |
| FLOW-003 | Sealed policy/config -> roots; exposure/RWX; combined/individual/map checks | BOUNDARY-004 | TM-20260911-001-E0013, TM-20260911-001-E0014 |
| FLOW-004 | HS -> writer PC/SP/root/registers; selected reset/fences | BOUNDARY-003, BOUNDARY-004 | TM-20260911-001-E0016 |
| FLOW-005 | Writer <-> own/shared memory; private/shared RW, common RX; writer root | BOUNDARY-004 | TM-20260911-001-E0012, TM-20260911-001-E0014 |
| FLOW-006 | VS -> HS saved state/events/faults; exact sequence/non-nesting assumption | BOUNDARY-003 | TM-20260911-001-E0015, TM-20260911-001-E0016 |
| FLOW-007 | HS writer completion -> reader root/SP/PC/reset state; validated switch/fences/readback | BOUNDARY-003, BOUNDARY-004 | TM-20260911-001-E0016 |
| FLOW-008 | Reader <-> private RW; common RX/shared R -> reader; root and denials | BOUNDARY-004 | TM-20260911-001-E0012, TM-20260911-001-E0015 |
| FLOW-009 | HS via SBI/emulator -> bounded logs; terminal and host checks | BOUNDARY-002, BOUNDARY-006 | TM-20260911-001-E0015, TM-20260911-001-E0026 |
| FLOW-010 | Readable source/Git/image/provenance -> work/export; RO inputs/writable copy, capture/mount/fingerprint/namespace checks | BOUNDARY-005, BOUNDARY-006 | TM-20260911-001-E0023, TM-20260911-001-E0024 |
| FLOW-011 | Bundle/source -> checker/consumer; manifests/hashes/tools/semantics; correspondence, not recipient authorization | BOUNDARY-006 | TM-20260911-001-E0025 |
| FLOW-012 | Generated site -> browser/client; content/readiness; confined/default-loopback delivery | BOUNDARY-007 | TM-20260911-001-E0027 |
| FLOW-013 | Automated docs/gate/output -> human; decision support; separate authority | BOUNDARY-008 | TM-20260911-001-E0028 |
| FLOW-014 | Completed/interrupted run -> reuse/disposal; residual state; partial cleanup, no erasure proof | BOUNDARY-009 | TM-20260911-001-E0017, TM-20260911-001-E0029 |

All entry definitions are Established source interfaces, not completed runs.

| ID | Exposed party; operation; validation | Evidence |
| --- | --- | --- |
| ENTRY-001 | Operator/producers; build/source/metadata/paths/tools/Make; protected graph | TM-20260911-001-E0020 |
| ENTRY-002 | Package/registry producers; construction/installation; pin/lock/inventory | TM-20260911-001-E0022 |
| ENTRY-003 | Platform; hart/state/image; fixed boot assumptions/checks | TM-20260911-001-E0017 |
| ENTRY-004 | Writer/reader; loads/stores/execute; per-root leaves | TM-20260911-001-E0014, TM-20260911-001-E0015 |
| ENTRY-005 | VS/platform; ECALL/fault/interrupt; exact finite state machine | TM-20260911-001-E0015 |
| ENTRY-006 | Trusted runtime; root/SP/PC/frame/CSRs; reset/fence/readback with valid caller | TM-20260911-001-E0016 |
| ENTRY-007 | Operator/source; native preflight then container; no first-command sandbox | TM-20260911-001-E0021, TM-20260911-001-E0023 |
| ENTRY-008 | Producers; export/bundle/manifests/reports/tools; namespace/correspondence, not disclosure proof | TM-20260911-001-E0024, TM-20260911-001-E0025 |
| ENTRY-009 | Log producer; positive/negative markers; distinct finite grammars | TM-20260911-001-E0026 |
| ENTRY-010 | Dependencies/operator/clients; docs/HTTP/bind/sandbox; defaults/routes/readiness | TM-20260911-001-E0027 |
| ENTRY-011 | Producers/human; review/gate/source/disclosure metadata; structure not authentic decision | TM-20260911-001-E0028 |
| ENTRY-012 | Runtime/operator/later consumers; failure/cleanup/reinit; checked terminal caller/handled rollback | TM-20260911-001-E0018, TM-20260911-001-E0029 |

## Threat catalogue

All nineteen scenarios are Inferred. Each entry includes preconditions,
links, controls, proposed mitigation, inherent/residual rationale, confidence,
status, evidence and limits. Numeric notation is L x I = product / band.
Slash lists retain their prefix: ASSET-001/002 means ASSET-001 and ASSET-002,
not a different identifier or omitted relationship.

### THREAT-001: Privileged mutation defeats software-only policy sealing
- STRIDE: Tampering; Elevation of privilege.
- Scenario/preconditions: Privileged mutation or initializer defect changes valid label/rule state after init; no guest policy API.
- Assets/objectives/actors: ASSET-001/002/003/004; OBJECTIVE-001/002; ACTOR-003.
- Surfaces: ENTRY-001/006, BOUNDARY-004, FLOW-003.
- Controls/mitigations: CONTROL-001/002; MITIGATION-002/003.
- Inherent: 2 x 4 = 8 / Moderate; substantial privileged prerequisites, major cross-boundary effect.
- Residual: 2 x 4 = 8 / Moderate; normal API checks do not constrain an already privileged writer.
- Confidence/status: Medium; Unresolved.
- Uncertainty/counter-evidence/limits: No actual mutation or reachable corruption trigger; fixed/no-parser policy narrows ordinary input, not a proved VS-to-HS escape.
- Evidence: TM-20260911-001-E0012, TM-20260911-001-E0013, TM-20260911-001-E0014.

### THREAT-002: Wrong backing or permissions expose a private resource
- STRIDE: Tampering; Information disclosure; Elevation of privilege.
- Scenario/preconditions: Trusted layout/builder/composition or compiled defect exposes private/HS backing or reader write; VS exercises it.
- Assets/objectives/actors: ASSET-001/002/003/004; OBJECTIVE-001/002; ACTOR-001/002/003.
- Surfaces: ENTRY-004, BOUNDARY-004, FLOW-003/005/008.
- Controls/mitigations: CONTROL-001/002/013; MITIGATION-001/002.
- Inherent: 3 x 4 = 12 / High; mapping errors plausibly violate major isolation.
- Residual: 2 x 4 = 8 / Moderate; bounds/alias/permission/absence checks constrain ordinary mistakes, not all identity/platform defects.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: Exact images/walks/composition proof absent; four source mappings per root, no direct guest table write or observed unauthorized access.
- Evidence: TM-20260911-001-E0014, TM-20260911-001-E0019, TM-20260911-001-E0033, TM-20260911-001-E0035.

### THREAT-003: Forged or misplaced events cause false progress or transition
- STRIDE: Spoofing; Tampering; Elevation of privilege.
- Scenario/preconditions: VS event/control flow/fault identity mistaken for expected step; requires trap, while defeat of trusted CSRs is separate.
- Assets/objectives/actors: ASSET-005/007; OBJECTIVE-001/003/004; ACTOR-001/002.
- Surfaces: ENTRY-005/006, BOUNDARY-003, FLOW-006/007.
- Controls/mitigations: CONTROL-003/005; MITIGATION-001/002.
- Inherent: 4 x 4 = 16 / High; unvalidated guest event/order is direct authority surface.
- Residual: 2 x 4 = 8 / Moderate; exact subject/phase/PC/cause/address/final words reject obvious substitutions.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: Arbitrary sequences unproved; malformed/early events fail. Hardware fields not assumed guest-writable; progress markers are not terminal proof.
- Evidence: TM-20260911-001-E0015, TM-20260911-001-E0019, TM-20260911-001-E0033.

### THREAT-004: Transition residue or stale translation crosses subjects
- STRIDE: Information disclosure; Tampering; Elevation of privilege.
- Scenario/preconditions: Writer state/translation survives reader entry through omitted/incorrectly compiled handling, failed required fence or unmodeled state channel.
- Assets/objectives/actors: ASSET-002/003/005; OBJECTIVE-001/002; ACTOR-001/002/003.
- Surfaces: ENTRY-006, BOUNDARY-003/004, FLOW-004/007.
- Controls/mitigations: CONTROL-004/013; MITIGATION-001/003/004.
- Inherent: 4 x 4 = 16 / High; sequential context reuse creates a state channel.
- Residual: 2 x 4 = 8 / Moderate; named resets/fences/readback constrain it.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: Optional/microarchitectural state, WARL and binary correspondence unverified; old missing-reset allegations stale and shared data intentional. No general noninterference.
- Evidence: TM-20260911-001-E0016, TM-20260911-001-E0019, TM-20260911-001-E0034, TM-20260911-001-E0035, TM-20260911-001-E0039.

### THREAT-005: An unexpected HS trap reaches stores before origin rejection
- STRIDE: Tampering; Denial of service; Elevation of privilege.
- Scenario/preconditions: Nested/HS fault enters stores with unsuitable SSCRATCH; requires violation of non-nesting/stack/platform assumptions, no current guest trigger.
- Assets/objectives/actors: ASSET-001/005; OBJECTIVE-001/003; ACTOR-003.
- Surfaces: ENTRY-003/005, BOUNDARY-002/003, FLOW-006.
- Controls/mitigations: CONTROL-003/004/013; MITIGATION-001/003.
- Inherent: 2 x 4 = 8 / Moderate; extra privileged fault can cause major corruption.
- Residual: 2 x 4 = 8 / Moderate; later C check does not protect earlier stores.
- Confidence/status: Low; Unresolved.
- Uncertainty/counter-evidence/limits: Reachability/current stack consumption unknown; ordinary interrupts disabled, no demonstrated overflow/exploit; linker gap not an unmapped Bare-mode guard.
- Evidence: TM-20260911-001-E0016, TM-20260911-001-E0017.

### THREAT-006: Untrusted progress prevents the finite experiment completing
- STRIDE: Denial of service.
- Scenario/preconditions: Non-cooperative VS or returned shutdown prevents required progress; no runtime scheduler/watchdog.
- Assets/objectives/actors: ASSET-005/007; OBJECTIVE-003/007; ACTOR-001/002/003.
- Surfaces: ENTRY-005/012, FLOW-005/008/014.
- Controls/mitigations: CONTROL-003/007; MITIGATION-004/011.
- Inherent: 4 x 2 = 8 / Moderate; one bounded experiment readily denied, not a production service.
- Residual: 4 x 2 = 8 / Moderate; fail-closed integrity/host timeout do not make reader progress.
- Confidence/status: High; Open.
- Uncertainty/counter-evidence/limits: No SLA/total budget/hard kill deadline; correct failure is not itself an integrity defect or production-availability claim.
- Evidence: TM-20260911-001-E0017, TM-20260911-001-E0026, TM-20260911-001-E0029, TM-20260911-001-E0034, TM-20260911-001-E0036.

### THREAT-007: A required privileged or tool dependency falsifies enforcement
- STRIDE: Spoofing; Tampering; Information disclosure; Denial of service; Elevation of privilege.
- Scenario/preconditions: Faulty/compromised firmware/emulator/compiler/linker/HS misimplements image/CSR/memory, or host kernel/OCI fails retained confinement; outputs may remain plausible.
- Assets/objectives/actors: ASSET-001/002/003/005/006/007; OBJECTIVE-001/002/004/005; ACTOR-003/004.
- Surfaces: ENTRY-001/003/007, BOUNDARY-001/002/005, FLOW-002/009/010.
- Controls/mitigations: CONTROL-004/007/010; MITIGATION-001/003/006/008.
- Inherent: 3 x 4 = 12 / High; dependency failure invalidates a major boundary.
- Residual: 3 x 4 = 12 / High; its own checks/hashes do not constrain compromised enforcement.
- Confidence/status: Low; Unresolved.
- Uncertainty/counter-evidence/limits: No particular installed vulnerability; score not prevalence. Multiple checks detect some accidental differences, not all required-trust failure. No hardware/CVE/proof assertion.
- Evidence: TM-20260911-001-E0011, TM-20260911-001-E0017, TM-20260911-001-E0023, TM-20260911-001-E0025, TM-20260911-001-E0038, TM-20260911-001-E0039, TM-20260911-001-E0040, TM-20260911-001-E0042.

### THREAT-008: Host-side substitution or races poison maintained outputs
- STRIDE: Spoofing; Tampering; Elevation of privilege.
- Scenario/preconditions: Host tool/input/path authority or unsupported independent concurrency substitutes a canonical artifact; ordinary overrides constrained.
- Assets/objectives/actors: ASSET-006/007; OBJECTIVE-004/005; ACTOR-004/005.
- Surfaces: ENTRY-001/008, BOUNDARY-001, FLOW-001/011.
- Controls/mitigations: CONTROL-006/009/010/013; MITIGATION-001/006/008/011.
- Inherent: 3 x 4 = 12 / High; consequential host influence over build/evidence identity.
- Residual: 3 x 4 = 12 / High; remaining hostile/race branch outside forced-output guarantees.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: Host actors/permissions unknown. Graph/fingerprint/layout guards detect bounded mistakes; added CONTROL-013 link earns no malicious-host/race reduction. No easy BUILD_ROOT bypass or changing frozen view claimed.
- Evidence: TM-20260911-001-E0020, TM-20260911-001-E0024, TM-20260911-001-E0025, TM-20260911-001-E0037.

### THREAT-009: An evaluator is mistaken for an arbitrary-source host sandbox
- STRIDE: Tampering; Information disclosure; Elevation of privilege.
- Scenario/preconditions: Untrusted/compromised source/dependency plus wrong operator expectation causes native preflight with account authority before container restrictions.
- Assets/objectives/actors: ASSET-006/007; OBJECTIVE-004/005; ACTOR-004/005.
- Surfaces: ENTRY-001/007, BOUNDARY-001/005, FLOW-001/010.
- Controls/mitigations: CONTROL-006/008/011; MITIGATION-005/006.
- Inherent: 3 x 4 = 12 / High; native code can reach private user data/later evidence.
- Residual: 3 x 4 = 12 / High; downstream restrictions do not mediate first command.
- Confidence/status: High; Open.
- Uncertainty/counter-evidence/limits: No actual malicious bytes/secret/misuse. Trusted developer workflow intentionally runs native code; no OCI escape or remote compromise shown.
- Evidence: TM-20260911-001-E0021, TM-20260911-001-E0022, TM-20260911-001-E0023, TM-20260911-001-E0037, TM-20260911-001-E0043.

### THREAT-010: Evaluated code crosses the retained container boundary
- STRIDE: Tampering; Information disclosure; Denial of service; Elevation of privilege.
- Scenario/preconditions: Ordinary forbidden write/traversal/network/environment attempt under declared effective restrictions and correctly enforcing engine/kernel. Failed dependency is THREAT-007, total budgets THREAT-018, accepted-content disclosure THREAT-019.
- Assets/objectives/actors: ASSET-006/007; OBJECTIVE-005; ACTOR-004/005.
- Surfaces: ENTRY-007/008, BOUNDARY-005, FLOW-010.
- Controls/mitigations: CONTROL-008/009; MITIGATION-001/005/011.
- Inherent: 4 x 4 = 16 / High; without confinement, direct forbidden paths reach host state.
- Residual: 2 x 4 = 8 / Moderate only for the correctly enforced ordinary-path branch; requested restrictions and export checks mediate it.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: Actual enforcement unverified; not an aggregate evaluator score. RO is not unreadable; other unmediated branches retain separate unreduced scores. Native preflight remains THREAT-009.
- Evidence: TM-20260911-001-E0023, TM-20260911-001-E0024, TM-20260911-001-E0041, TM-20260911-001-E0042.

### THREAT-011: Recorded dependency closure contains malicious or drifting inputs
- STRIDE: Spoofing; Tampering; Elevation of privilege.
- Scenario/preconditions: Compromised producer/repository/tool, mutable resolution or unverified installed bytes yields malicious/unintended construction despite consistent pin/lock/inventory.
- Assets/objectives/actors: ASSET-006/007/008; OBJECTIVE-004/005; ACTOR-004.
- Surfaces: ENTRY-001/002, BOUNDARY-001, FLOW-001.
- Controls/mitigations: CONTROL-006/009/010; MITIGATION-001/006/008.
- Inherent: 3 x 4 = 12 / High; dependencies influence code, images and evidence.
- Residual: 3 x 4 = 12 / High; matching records do not constrain malicious producers or audit all installed npm bytes.
- Confidence/status: Medium; Open.
- Uncertainty/counter-evidence/limits: No specific vulnerability/compromise. Declared context/inventories improve drift detection; no immutable-rebuild or patch applicability claim.
- Evidence: TM-20260911-001-E0022, TM-20260911-001-E0024, TM-20260911-001-E0043, TM-20260911-001-E0044.

### THREAT-012: Noncanonical trace diagnostics survive finite validators
- STRIDE: Spoofing; Tampering; Repudiation.
- Scenario/preconditions: Corrupt/substituted log has required markers and otherwise ignored contradictions; consumer interprets it too broadly.
- Assets/objectives/actors: ASSET-007; OBJECTIVE-003/004; ACTOR-004/005.
- Surfaces: ENTRY-009, BOUNDARY-006, FLOW-009.
- Controls/mitigations: CONTROL-005/007/010; MITIGATION-007/008.
- Inherent: 4 x 3 = 12 / High; unconstrained evidence readily ambiguous.
- Residual: 3 x 3 = 9 / Moderate; defined exact markers reject many errors, not all ignored-line classes.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: Static inference, no reproduced false acceptance. Explicit failure/metadata/post-FAIL checks matter; whole-producer fraud is THREAT-013 and grammar does not authenticate it.
- Evidence: TM-20260911-001-E0015, TM-20260911-001-E0026.

### THREAT-013: Self-consistent evidence is mistaken for authentic execution
- STRIDE: Spoofing; Tampering; Repudiation.
- Scenario/preconditions: Producer control/missing provenance and overreliance turn matching artifacts or overextended namespaces into unsupported execution claims.
- Assets/objectives/actors: ASSET-007/008; OBJECTIVE-004/006; ACTOR-004/005/007.
- Surfaces: ENTRY-008/009, BOUNDARY-006, FLOW-009/011.
- Controls/mitigations: CONTROL-007/009/010/014; MITIGATION-001/007/008.
- Inherent: 3 x 4 = 12 / High; wrong provenance can drive major reliance.
- Residual: 3 x 4 = 12 / High; self-consistency not independently authenticated production/binary correctness.
- Confidence/status: High; Open.
- Uncertainty/counter-evidence/limits: No fraudulent bundle. Exact byte/type/tool checks detect tampering, do not execute bundle-selected programs, and expressly do not promise attestation.
- Evidence: TM-20260911-001-E0005, TM-20260911-001-E0011, TM-20260911-001-E0025, TM-20260911-001-E0028, TM-20260911-001-E0044.

### THREAT-014: Documentation exposure or browser assumptions exceed defaults
- STRIDE: Spoofing; Information disclosure; Denial of service.
- Scenario/preconditions: Explicit exposure/exception, uncleared content or overreliance exceeds generated-site/browser guarantees.
- Assets/objectives/actors: ASSET-006/008; OBJECTIVE-005/006; ACTOR-004/005/006.
- Surfaces: ENTRY-010, BOUNDARY-007, FLOW-012.
- Controls/mitigations: CONTROL-011/014; MITIGATION-005/009/010/011.
- Inherent: 3 x 3 = 9 / Moderate; bounded confidentiality/evidence effect.
- Residual: 3 x 3 = 9 / Moderate; defaults/readiness protect other cases, not deliberate non-loopback, disabled sandbox or uncleared content. No default-derived credit for those branches.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: Actual bind/content/browser/budgets unknown. No default wildcard, traversal or RCE shown; boolean not authenticated container origin, and routing not content approval.
- Evidence: TM-20260911-001-E0027, TM-20260911-001-E0028.

### THREAT-015: Structural gate metadata impersonates a human decision
- STRIDE: Spoofing; Tampering; Repudiation; Elevation of privilege.
- Scenario/preconditions: Record-writing/deceptive-presentation authority yields plausible bytes treated as authentic approval; no current approved gate.
- Assets/objectives/actors: ASSET-008/009; OBJECTIVE-006; ACTOR-004/005/007.
- Surfaces: ENTRY-011, BOUNDARY-008, FLOW-013.
- Controls/mitigations: CONTROL-012/014; MITIGATION-008/010.
- Inherent: 3 x 4 = 12 / High; false attribution can drive major inappropriate reliance/publication.
- Residual: 3 x 4 = 12 / High; fields/topology do not authenticate the supplier.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: Downstream control/human evidence unknown; frozen gate blocked and malformed records rejected. No fabricated decision or observed publication.
- Evidence: TM-20260911-001-E0028.

### THREAT-016: Bounded PoC evidence is inflated into a stronger security claim
- STRIDE: Spoofing; Repudiation; Tampering.
- Scenario/preconditions: Misinterpretation/selective presentation turns bounded tests/reviews/lineage into arbitrary isolation, CAP+TE/CHERI/VBS, formal/hardware or acceptance claim.
- Assets/objectives/actors: ASSET-007/008/009; OBJECTIVE-004/006; ACTOR-004/006/007.
- Surfaces: ENTRY-008/010/011, BOUNDARY-006/008, FLOW-013.
- Controls/mitigations: CONTROL-010/012/014; MITIGATION-001/004/010/012.
- Inherent: 3 x 4 = 12 / High; major inappropriate assurance/publication reliance.
- Residual: 2 x 4 = 8 / Moderate; explicit limits reduce accidental misunderstanding, not deliberate fraud.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: Consumers unknown; deception THREAT-013/015. No CBMC harness at target, no adopted earlier model. Package validation is not security/approval.
- Evidence: TM-20260911-001-E0005, TM-20260911-001-E0006, TM-20260911-001-E0008, TM-20260911-001-E0011, TM-20260911-001-E0019, TM-20260911-001-E0028.

### THREAT-017: Failed reinitialization leaves stale authority for an unsafe caller
- STRIDE: Tampering; Elevation of privilege.
- Scenario/preconditions: Old valid tree AND invalid reinit AND unchecked reuse despite misleading unusable-on-zero contract; no such fixed-runtime continuation.
- Assets/objectives/actors: ASSET-001/002/003; OBJECTIVE-001/002/007; ACTOR-003.
- Surfaces: ENTRY-006/012, BOUNDARY-009, FLOW-003/014.
- Controls/mitigations: CONTROL-003; MITIGATION-002/012.
- Inherent: 3 x 4 = 12 / High for unchecked-reuse composition; wrong authority may survive.
- Residual: 1 x 4 = 4 / Low; fixed caller terminates on zero with no guest reinit service.
- Confidence/status: High; Mitigated.
- Uncertainty/counter-evidence/limits: Future callers not target; valid init clears storage. Observed contract mismatch is not an exploit or permission to ignore failure.
- Evidence: TM-20260911-001-E0018.

### THREAT-018: Retained state, interruption or unbounded work defeats lifecycle intent
- STRIDE: Information disclosure; Tampering; Denial of service.
- Scenario/preconditions: Later residual-state access, unhandled interruption or excess work harms C/I/A through retained memory/files/cache, confused reuse or resource exhaustion.
- Assets/objectives/actors: ASSET-005/006/007/008; OBJECTIVE-005/007; ACTOR-003/004/005/006.
- Surfaces: ENTRY-007/010/012, BOUNDARY-009, FLOW-014.
- Controls/mitigations: CONTROL-007/008/009; MITIGATION-003/009/011.
- Inherent: 3 x 3 = 9 / Moderate; realistic bounded lifecycle conditions.
- Residual: 3 x 3 = 9 / Moderate; cleanup/tmpfs/handled rollback are not erasure, crash durability or complete budgets.
- Confidence/status: Medium; Unresolved.
- Uncertainty/counter-evidence/limits: Requirements/sensitivity/reset/budgets unknown. Recovery failures surfaced and retention may be intended; no particular disclosure/exhaustion observed.
- Evidence: TM-20260911-001-E0017, TM-20260911-001-E0024, TM-20260911-001-E0027, TM-20260911-001-E0029.

### THREAT-019: Permitted outputs disclose readable private inputs
- STRIDE: Information disclosure.
- Scenario/preconditions: Sensitive readable input AND information placed in output accepted by actual content checks AND an unauthorized recipient receives it. All three are necessary and remain unestablished for a real deployment.
- Assets/objectives/actors: ASSET-006/007/008; OBJECTIVE-005/006; ACTOR-004/005/006/007.
- Surfaces: ENTRY-007/008/010/011, BOUNDARY-005/006/007/008, FLOW-010/011/012/013.
- Controls/mitigations: CONTROL-008/009/010/012/014; MITIGATION-005/008/010/011/013.
- Inherent: 3 x 3 = 9 / Moderate; the explicit conjunction yields plausible bounded disclosure.
- Residual: 3 x 3 = 9 / Moderate; RO/integrity/namespace checks do not authorize semantic disclosure. Private handling/gate get no credit for an already unauthorized-recipient branch.
- Confidence/status: Medium; Unresolved.
- Uncertainty/counter-evidence/limits: OPEN-010 may remove or rerate the branch. Reads may be intended, recipients entitled, or content checks block a carrier. No specific secret-bearing artifact, unrestricted carrier, leak or container escape established.
- Evidence: TM-20260911-001-E0023, TM-20260911-001-E0024, TM-20260911-001-E0025, TM-20260911-001-E0027, TM-20260911-001-E0028, TM-20260911-001-E0045.

## Controls and verification plan

Established: controls below are source mechanisms. Confidence High except
CONTROL-014 Medium. All forward/reverse threat relationships are defined by
the catalogue above; CONTROL-010 includes THREAT-007 and CONTROL-013 includes
THREAT-008 with no extra numerical credit.

| ID | Effectiveness and limitation | Evidence |
| --- | --- | --- |
| CONTROL-001 | Bounded labels/seal/exact default deny; not privileged immutability | TM-20260911-001-E0013 |
| CONTROL-002 | Policy/bounds/alias/absence checks; backing/platform trusted | TM-20260911-001-E0014 |
| CONTROL-003 | Exact sequence/terminal/checked init; no pre-store nesting guard or progress guarantee | TM-20260911-001-E0015, TM-20260911-001-E0018 |
| CONTROL-004 | Named reset/VT/fence/readback; not every state or binary | TM-20260911-001-E0016 |
| CONTROL-005 | Selected volatile words/final predicates; not whole-page/noninterference/progress proof | TM-20260911-001-E0015, TM-20260911-001-E0014 |
| CONTROL-006 | Protected canonical forced graph; not malicious tool/rule/host/race isolation | TM-20260911-001-E0020 |
| CONTROL-007 | Process/count/timeout/finite grammar; not total deadline/authenticity/all diagnostics | TM-20260911-001-E0026 |
| CONTROL-008 | Ordinary container path restrictions under correct enforcement; not native/kernel-failure/budget/disclosure protection | TM-20260911-001-E0023 |
| CONTROL-009 | Private lock/capture/fingerprint/rollback; not authentication/atomic source/crash durability/disclosure | TM-20260911-001-E0024 |
| CONTROL-010 | Exact blob/type/hash/tool/report/trace correspondence; not binary proof or disclosure authority | TM-20260911-001-E0025 |
| CONTROL-011 | Confined server/defaults/readiness; not deliberate-exception, semantic approval or host sandbox | TM-20260911-001-E0027 |
| CONTROL-012 | Blocked structural gate; not authenticated human decision or recipient entitlement | TM-20260911-001-E0028 |
| CONTROL-013 | Layout/linker/assertion/entry definitions detect bounded malformed outputs; no executed test or malicious-host credit | TM-20260911-001-E0014, TM-20260911-001-E0019 |
| CONTROL-014 | Explicit PoC/provenance/claim limits reduce accidents; no anti-fraud or recipient-right proof | TM-20260911-001-E0005, TM-20260911-001-E0011, TM-20260911-001-E0028 |

All mitigations are Proposed/Open with Unknown actual owners. Suggested
roles are not assignments. Catalogue links define the complete threat
association; none earns present credit.

| ID | Work / verification | Suggested owner or dependency | Evidence |
| --- | --- | --- | --- |
| MITIGATION-001 | Obtain owner exact-target commands/exits/tools/images/failures; independently compare source/binaries/disassembly/log/environment | Target/evaluation owner | TM-20260911-001-E0011, TM-20260911-001-E0019, TM-20260911-001-E0025 |
| MITIGATION-002 | Composition/negative properties for labels/backing/split rules/events/faults with exact fixtures/results | Runtime owner | TM-20260911-001-E0013, TM-20260911-001-E0014, TM-20260911-001-E0018 |
| MITIGATION-003 | Boot/trap/stack/platform/lifecycle evidence, exact-image bounds/violation checks; new scope for expansion | Runtime/platform owner | TM-20260911-001-E0016, TM-20260911-001-E0017 |
| MITIGATION-004 | Trace direct-access/flow/progress claims to actual channels/state/liveness conditions | Architecture owner; approved extra profile | TM-20260911-001-E0012, TM-20260911-001-E0019 |
| MITIGATION-005 | External trusted launcher before native repository code if arbitrary untrusted use required; include readable inputs/outputs/browser in tests | Evaluator owner; use-case decision | TM-20260911-001-E0021, TM-20260911-001-E0023 |
| MITIGATION-006 | Pin/inspect actual installed closure/patches/configuration and independent build correspondence | Build/dependency owner | TM-20260911-001-E0022 |
| MITIGATION-007 | Canonical trace grammar and contradictory-prefix/terminal mutation tests with exact rejection results | Evidence-tool owner | TM-20260911-001-E0026 |
| MITIGATION-008 | Independent producer/binary provenance and namespace/confidentiality limits; trusted capture, no self-issued assurance | Assurance owner; requirements decision | TM-20260911-001-E0025, TM-20260911-001-E0028 |
| MITIGATION-009 | Explicit disclosure/sandbox/readiness/work-budget boundaries; test default/opt-in and limits | Docs/evaluator owner | TM-20260911-001-E0027 |
| MITIGATION-010 | Authenticated human/exact-output disclosure review and recipient controls separate from structure | Responsible human required | TM-20260911-001-E0028 |
| MITIGATION-011 | Retention/recipient/cleanup/interruption/concurrency/work requirements plus bounded owner tests | Operations owner | TM-20260911-001-E0024, TM-20260911-001-E0029 |
| MITIGATION-012 | Align API/fixture/diagram/historical metadata with supported paths and evidence | Target documentation owner | TM-20260911-001-E0005, TM-20260911-001-E0018, TM-20260911-001-E0019 |
| MITIGATION-013 | Readable-class/accepted-carrier/recipient/content-control matrix; benign canary flow tests, not real secrets | Evaluator/disclosure owner; OPEN-010 | TM-20260911-001-E0023, TM-20260911-001-E0024, TM-20260911-001-E0025, TM-20260911-001-E0045 |

## Assumptions and non-goals

| ID | Label | Premise, consequence and check | Evidence |
| --- | --- | --- | --- |
| ASSUMPTION-001 | Established | Fixed one-hart/two-subject/resources/policy, no dynamic devices/DMA/interrupt/multicore service; expansion invalidates argument and requires new scope/profile check | TM-20260911-001-E0012, TM-20260911-001-E0017 |
| ASSUMPTION-002 | Unknown | Platform/tools realize source intent; failure invalidates readback/log reliance; independent exact-platform evidence needed | TM-20260911-001-E0011, TM-20260911-001-E0016, TM-20260911-001-E0025 |
| ASSUMPTION-003 | Established | HS storage/caller/backing integrity required; inspect callers/dataflow/corruption properties; fixed return checked | TM-20260911-001-E0013, TM-20260911-001-E0014, TM-20260911-001-E0018 |
| ASSUMPTION-004 | Established / Unknown | Four-byte/selected-word fixture established, binary unknown; exact image/disassembly required | TM-20260911-001-E0015, TM-20260911-001-E0019 |
| ASSUMPTION-005 | Inferred | Adversarial role is not replacement payload; check actual reachability and counterfactual prerequisites | TM-20260911-001-E0012, TM-20260911-001-E0015 |
| ASSUMPTION-006 | Established / Unknown | Native execution precedes confinement; arbitrary-source expectation unknown; external first-command boundary needed if required | TM-20260911-001-E0021, TM-20260911-001-E0023 |
| ASSUMPTION-007 | Established / Inferred | Correspondence not honest production; OPEN-005/006 constrain stronger execution/tool identity claims | TM-20260911-001-E0025, TM-20260911-001-E0028 |
| ASSUMPTION-008 | Established | Human gates not delegated; treating score/metadata as approval breaks objective; independent human records needed | TM-20260911-001-E0001, TM-20260911-001-E0028 |
| ASSUMPTION-009 | Unknown | Retention/erasure/crash requirements unresolved; OPEN-007 may change lifecycle rating/controls | TM-20260911-001-E0017, TM-20260911-001-E0029 |
| ASSUMPTION-010 | Established / Unknown | Shared flow allowed; stronger noninterference/progress not established by selected checks/timeout/abort | TM-20260911-001-E0012, TM-20260911-001-E0017, TM-20260911-001-E0026 |
| ASSUMPTION-011 | Unknown | Sensitive readable classes, accepted carriers and recipient rights unknown; THREAT-019 needs all three, OPEN-010/MITIGATION-013 test them | TM-20260911-001-E0023, TM-20260911-001-E0024, TM-20260911-001-E0025, TM-20260911-001-E0045 |

## Abuse cases and attack trees

All trees are Inferred conditional structures. OR means alternatives; AND
requires every prerequisite. No exploit was executed. The retained seven
DOT sources are enumerated in REVIEW-INPUT-002.md; they cannot widen these
semantics.

### ATTACK-001: Violate fixed subject isolation
Goal actual forbidden private/HS memory/context influence, OBJECTIVE-001/002.
ACTOR-001/002 exploit defects or ACTOR-003 supplies privileged prerequisites.
OR THREAT-001 policy, THREAT-002 mapping, THREAT-003/004 event/state,
THREAT-005/007 trap/platform. THREAT-017 is AND old valid tree + failed
reinit + unchecked reuse; fixed caller blocks last. BOUNDARY-002/003/004/009;
CONTROL-001/002/003/004/013 constrain separate branches. Reachability/proof
unknown, not progress-marker success.
TM-20260911-001-E0013 through TM-20260911-001-E0018.

### ATTACK-002: Obtain misleading positive evidence
Goal unsupported reliance, OBJECTIVE-004, ACTOR-004/005, BOUNDARY-006.
OR THREAT-008 substitution, THREAT-012 ignored contradiction, THREAT-013
self-consistent dishonest production. Trace AND required grammar + ignored
contrary line + consumer overreliance. CONTROL-007/009/010 check narrower
correspondence; producer identity remains unknown.
TM-20260911-001-E0020, TM-20260911-001-E0025, TM-20260911-001-E0026.

### ATTACK-003: Influence the host or disclose input through evaluation
Goal unauthorized host/data effect, OBJECTIVE-004/005/006,
BOUNDARY-001/005/006/007/008. ACTOR-004/005 supply source/operator cases;
ACTOR-006/007 are conditional recipients/decision roles, not presumed
misconduct. OR THREAT-009 native execution (AND untrusted input + wrong
sandbox expectation), THREAT-011 construction, THREAT-010 ordinary
correctly-enforced-path attempt, THREAT-014 inappropriate exposure/exception,
or THREAT-019 disclosure (AND sensitive readable input + actual accepted
carrier + unauthorized recipient). Failed kernel/OCI remains THREAT-007;
total budgets THREAT-018. CONTROL-008 begins after native preflight and
integrity checks do not grant disclosure authority. No carrier/leak proven.
TM-20260911-001-E0021, TM-20260911-001-E0022,
TM-20260911-001-E0023, TM-20260911-001-E0025,
TM-20260911-001-E0027, TM-20260911-001-E0045.

### ATTACK-004: Misuse a decision or later lifecycle
OR THREAT-015 false attribution, THREAT-016 inflation, THREAT-006
non-progress, THREAT-018 reuse/disposal. Attribution AND plausible metadata
and belief in unestablished human identity. ACTOR-001/002 supply VS
non-progress; ACTOR-004/005/006/007 and conditional ACTOR-003 supply other
branches. BOUNDARY-008/009, OBJECTIVE-003/006/007.
CONTROL-012/014 preserve distinctions, not authenticated decisions.
TM-20260911-001-E0017, TM-20260911-001-E0028, TM-20260911-001-E0029.

## Coverage matrix and risk summary

Inferred: S/T/R/I/D/E mean Spoofing/Tampering/Repudiation/Information
disclosure/Denial of service/Elevation of privilege. These dispositions mean
considered, not proven secure. Subject-binding and emitted evidence address
S/R where an inert memory surface has no separate identity protocol.

| Surfaces | Applicable STRIDE trace / bounded disposition |
| --- | --- |
| BOUNDARY-001, FLOW-001, ENTRY-001/002 | S/T/E THREAT-008/011; I THREAT-009; R THREAT-013; D THREAT-018 |
| BOUNDARY-002, FLOW-002, ENTRY-003 | S/T/I/D/E THREAT-007; D THREAT-006; R via FLOW-009/THREAT-013 |
| BOUNDARY-004, FLOW-003 | T/I/E THREAT-001/002/017; S THREAT-003; D THREAT-006; R THREAT-013 |
| FLOW-004, ENTRY-006 | S/T/E THREAT-003/005; I THREAT-004; D THREAT-006; R THREAT-013 |
| FLOW-005/008, ENTRY-004 | T/I/E THREAT-002; S THREAT-003; D THREAT-006; R THREAT-012/013; intended sharing permitted |
| BOUNDARY-003, FLOW-006, ENTRY-005 | S/T/E THREAT-003/005; I THREAT-004; D THREAT-006; R THREAT-012/013 |
| FLOW-007 | S/T/E THREAT-003; I/T THREAT-004; D THREAT-006; R THREAT-012/013 |
| BOUNDARY-006, FLOW-009, ENTRY-009 | S/T/R THREAT-012/013; D THREAT-006/018; I THREAT-018; E only overreliance THREAT-016, not direct parser exploit |
| BOUNDARY-005, FLOW-010, ENTRY-007 | S/T/R THREAT-011/013; I/E THREAT-009/010; failed enforcement THREAT-007; D THREAT-018; permitted-content I THREAT-019 |
| FLOW-011, ENTRY-008 | S/T/R THREAT-013; D THREAT-018; I THREAT-019; direct I/E paths constrained, extra trusted-code failure THREAT-008/009/011 |
| BOUNDARY-007, FLOW-012, ENTRY-010 | S/I/D THREAT-014; I THREAT-019; T/R THREAT-013/016; E requires THREAT-009/011 prerequisite |
| BOUNDARY-008, FLOW-013, ENTRY-011 | S/T/R/E THREAT-015/016; I THREAT-014/018/019; D THREAT-018; genuine approval waiting is intended |
| BOUNDARY-009, FLOW-014, ENTRY-012 | T/I/D THREAT-017/018; S/R THREAT-013/015; E THREAT-017; D THREAT-006 |

Established: each objective, asset and actor has explicit catalogue links,
and each flow/entry/boundary appears above with evidence in its registry.
OBJECTIVE-004 includes THREAT-003; OBJECTIVE-005 includes host-dependency
THREAT-007 and new THREAT-019; OBJECTIVE-007 no longer relies on the narrowed
THREAT-010. ASSET-006/007/008 and ACTOR-004/005/006/007 include THREAT-019.
The new mitigation/assumption/question preserve unknown disclosure facts.

| Threat | Inherent | Residual | Confidence |
| --- | --- | --- | --- |
| THREAT-001 | 8 Moderate | 8 Moderate | Medium |
| THREAT-002 | 12 High | 8 Moderate | Medium |
| THREAT-003 | 16 High | 8 Moderate | Medium |
| THREAT-004 | 16 High | 8 Moderate | Medium |
| THREAT-005 | 8 Moderate | 8 Moderate | Low |
| THREAT-006 | 8 Moderate | 8 Moderate | High |
| THREAT-007 | 12 High | 12 High | Low |
| THREAT-008 | 12 High | 12 High | Medium |
| THREAT-009 | 12 High | 12 High | High |
| THREAT-010 | 16 High | 8 Moderate, ordinary correctly-enforced paths only | Medium |
| THREAT-011 | 12 High | 12 High | Medium |
| THREAT-012 | 12 High | 9 Moderate | Medium |
| THREAT-013 | 12 High | 12 High | High |
| THREAT-014 | 9 Moderate | 9 Moderate | Medium |
| THREAT-015 | 12 High | 12 High | Medium |
| THREAT-016 | 12 High | 8 Moderate | Medium |
| THREAT-017 | 12 High | 4 Low, fixed-caller qualification | High |
| THREAT-018 | 9 Moderate | 9 Moderate | Medium |
| THREAT-019 | 9 Moderate | 9 Moderate, three required conditions | Medium |

## Completion and assurance limits

Established: broad source coverage is not exhaustive line/input/binary/runtime
coverage. Selected fixture ranges, generated outputs and exact run bundles
remain limited. The first review is complete; this correction candidate
requires bounded closure, then package completion validation and final blind
freeze before earlier-model comparison.

Established: Beryllium accepted through R7; R8-H0 committed candidate not
accepted; K3 hardware NOT RUN. Helium remains a review-and-test PoC, not
formally verified or hardware validated; this exact source has no CBMC
harness. No inherited later assurance, accepted risk, human review approval,
sign-off, licensing, promotion, publication or release is granted.
TM-20260911-001-E0004, TM-20260911-001-E0009,
TM-20260911-001-E0011, TM-20260911-001-E0028,
TM-20260911-001-E0045.
