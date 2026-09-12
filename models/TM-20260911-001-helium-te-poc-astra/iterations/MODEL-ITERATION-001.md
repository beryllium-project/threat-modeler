# MODEL-ITERATION-001

Package ID: `TM-20260911-001`
Title: Helium TE PoC Independent Threat Model (GPT-6 Astra)
Created: 2026-09-11
Status: `Complete`
Distribution: `private`
Supersedes: None

## Scope and position

Established: this is the first complete blind model iteration, populated from
the unfinished scaffolder placeholder before its first review freeze. It is a
self-contained normalized projection, not a change log. Its corresponding
expanded current projection, evidence set and DOT files are hash-bound in
`REVIEW-INPUT-001.md`. No earlier complete numbered iteration is replaced.

Established: mode is `create-from-evidence`; target is
`component://helium-te-poc/` at clean detached
`1ab289c066b69acdd8b55c9f77055b0145be1316`. Historical Beryllium context is
`65f6d895a2007e8e093582cc48726375fd23b563`, not an additional implementation
target. Fresh states were unchanged at 2026-09-11T21:23:54Z. Owner stability
attestation is not filesystem-enforced immutability.
TM-20260911-001-E0001, TM-20260911-001-E0002,
TM-20260911-001-E0031, TM-20260911-001-E0032.

Inferred: fixed-source controls support bounded direct-access and transition
reasoning, not demonstrated execution or arbitrary guest isolation. Highest
residual scores are High, 12/25, for conditional platform/tool trust, host
substitution, native-evaluation misuse, dependency closure, producer
authenticity and human-decision attribution. None establishes compromise,
an exploit, a CVE, or accepted risk.

Established: the complete target-owned runtime and host build/evaluation,
evidence, retained-review and publication-support boundary is considered.
The three July 20 historical exchanges and linked curated context are
research inputs only. Later broad Beryllium runtime, CHERI/CAP+TE/VBS
implementations, earlier TM analyses and planning-session history are not
inputs. No target/sibling execution or modification is authorized.
TM-20260911-001-E0006, TM-20260911-001-E0007,
TM-20260911-001-E0008, TM-20260911-001-E0009.

## Method and evidence boundary

Established: evidence set is TM-20260911-001-E0001 through
TM-20260911-001-E0044, as frozen in the ledger. Facts are labeled Established,
Inferred, Proposed or Unknown. Established controls mean source-supported
mechanisms; effectiveness credit is conditional on the inspected mechanism
and profile, not measured operation. Proposed work earns no current credit.
The 5x5 method uses L/I integers 1-5: rare/negligible, substantial-prerequisite
or minor, plausible/material, capable-actor-likely/major, and
readily-repeatable/critical. Products 1-4 Low, 5-9 Moderate, 10-16 High,
17-25 Critical. Confidence is separate from ordinal likelihood.

Established: local tiers were examined in order with explicit unavailable
PRV/formal research, unpinned PM and unadmitted AWB limitations. Public
OPEN-003/004 were resolved at semantic depth; versioned and living sources
do not identify the installed runtime. OPEN-005/006/007 constrain execution,
deployment and lifecycle claims; OPEN-002/008 constrain context. No remaining
answer is silently assumed to support a stronger claim.
TM-20260911-001-E0010, TM-20260911-001-E0011,
TM-20260911-001-E0033, TM-20260911-001-E0044.

## System boundary and lifecycle

| Stage | Label | Behavior and limitation | Evidence |
| --- | --- | --- | --- |
| Build/configuration | Established | Trusted native source/tools and networked image dependencies precede retained-container restrictions. | TM-20260911-001-E0020, TM-20260911-001-E0021, TM-20260911-001-E0022 |
| Boot | Established | Firmware enters HS; BSS/8 KiB stack initialization precedes late hart-zero rejection; FDT ignored. | TM-20260911-001-E0017 |
| Policy/root initialization | Established | Assign/seal labels, derive two roots, check private absence and shared asymmetry. | TM-20260911-001-E0013, TM-20260911-001-E0014 |
| Writer | Established | Private RW stack/data, common RX code, shared RW; finite expected event/fault sequence. | TM-20260911-001-E0012, TM-20260911-001-E0015 |
| Trap/recovery | Established | Exact state/PC/origin/cause/address checks; only listed transitions recover by four bytes; non-nesting assumed. | TM-20260911-001-E0015, TM-20260911-001-E0016 |
| Writer-to-reader | Established | Clear frame/GPRs, reset listed VS state, fence, select root/SP/PC and read back HGATP. | TM-20260911-001-E0016 |
| Reader | Established | Private RW, shared R; expected store/load denials and final selected sentinel checks. | TM-20260911-001-E0015, TM-20260911-001-E0019 |
| Failure/shutdown | Established | Terminal FAIL, SBI reset/shutdown and fallback WFI; no watchdog, restart service or scrub. | TM-20260911-001-E0017 |
| Evaluation/evidence | Established | Native preflight, captured-image work, manifests/trace checks and export have distinct trust boundaries. | TM-20260911-001-E0021, TM-20260911-001-E0023, TM-20260911-001-E0025 |
| Review/publication | Established | Generated/retained documents support separate human decisions; gate blocked. | TM-20260911-001-E0027, TM-20260911-001-E0028 |
| Update/reuse/disposal | Unknown | No dynamic policy lifecycle inferred; new source requires a new snapshot; erasure/retention/crash requirements unresolved. | TM-20260911-001-E0018, TM-20260911-001-E0029 |

## Objectives and assets

All objectives are Proposed, derived from admitted intent rather than claimed
guarantees. Confidence is High except OBJECTIVE-007 Medium.

| ID | Objective and limit | Evidence |
| --- | --- | --- |
| OBJECTIVE-001 | Preserve HS/policy/root/trusted-state integrity; not a proof. | TM-20260911-001-E0012, TM-20260911-001-E0016 |
| OBJECTIVE-002 | Deny unapproved direct private access; retain writer-RW/reader-R sharing, not arbitrary noninterference. | TM-20260911-001-E0012, TM-20260911-001-E0014 |
| OBJECTIVE-003 | Reject invalid transitions and report finite success/failure honestly; no progress SLA. | TM-20260911-001-E0015, TM-20260911-001-E0017 |
| OBJECTIVE-004 | Preserve source/build/tool/artifact correspondence and interpretation; authenticity unknown. | TM-20260911-001-E0020, TM-20260911-001-E0025, TM-20260911-001-E0026 |
| OBJECTIVE-005 | Protect host/source within the stated evaluator boundary; no arbitrary-tree sandbox. | TM-20260911-001-E0021, TM-20260911-001-E0023 |
| OBJECTIVE-006 | Preserve provenance/claims and separate human decisions; no approval inferred. | TM-20260911-001-E0005, TM-20260911-001-E0028 |
| OBJECTIVE-007 | Define safe recovery/freshness/resource use/disposal; requirements remain open. | TM-20260911-001-E0017, TM-20260911-001-E0029 |

| ID | Label / confidence | Asset and required property | Authority | Evidence |
| --- | --- | --- | --- | --- |
| ASSET-001 | Established / High | HS code, trusted stack, TE/config/rule state and tables: integrity/exclusive trusted mutation | HS mechanism; human ownership not inferred | TM-20260911-001-E0012, TM-20260911-001-E0013 |
| ASSET-002 | Established / High | Writer-private stack/data: direct-access C/I against reader | Monitor-assigned writer | TM-20260911-001-E0012 |
| ASSET-003 | Established / High | Reader-private stack/data: direct-access C/I against writer | Monitor-assigned reader | TM-20260911-001-E0012 |
| ASSET-004 | Established / High | Common RX code and shared data: code integrity; shared writer RW/reader R | Fixed policy/HS mappings | TM-20260911-001-E0012, TM-20260911-001-E0014 |
| ASSET-005 | Established / High | Active subject, phase, GPR/CSR/root/SP: correct binding/sanitization/order | HS only | TM-20260911-001-E0015, TM-20260911-001-E0016 |
| ASSET-006 | Inferred / Medium | Host checkout/Git/user-accessible data/evaluator state: C/I and bounded work | Invoking account; exact secrets/owners unknown | TM-20260911-001-E0021, TM-20260911-001-E0023 |
| ASSET-007 | Established / High | Images, dependency/report/log/bundle data: integrity/freshness/correspondence/provenance | Producers/checkers; no authenticated trust root | TM-20260911-001-E0022, TM-20260911-001-E0025 |
| ASSET-008 | Established / High | Generated docs/retained reviews: attribution, limits, appropriate disclosure | Maintained source and separate human review | TM-20260911-001-E0027, TM-20260911-001-E0028 |
| ASSET-009 | Established / High | Gate bytes/decision metadata: integrity/non-impersonation | Responsible human, not agent | TM-20260911-001-E0028 |

## Actors and capabilities

All actor capability analyses are Inferred/Medium except ACTOR-007,
Proposed/Medium. A different linked payload is a different snapshot;
adversarial-role cases do not assert an exploit in the unchanged fixture.

| ID | Trust, access and constraints | Goal | Evidence |
| --- | --- | --- | --- |
| ACTOR-001 | Untrusted writer VS; mapped code/private/shared state and event/fault inputs; no HS policy API | Cross-private access, false events, stalled progress | TM-20260911-001-E0012, TM-20260911-001-E0015 |
| ACTOR-002 | Untrusted reader VS; reader mappings/events, shared read only | Shared write, writer-private access, false completion | TM-20260911-001-E0012, TM-20260911-001-E0015 |
| ACTOR-003 | Required privileged/platform trust; hypothetical faulty/compromised HS, firmware or emulator | Bypass/misimplement required enforcement | TM-20260911-001-E0013, TM-20260911-001-E0017 |
| ACTOR-004 | Source/dependency/image/evidence producer; supplies inputs/results, not assumed direct guest-to-HS access | Poison execution or misrepresent evidence | TM-20260911-001-E0021, TM-20260911-001-E0022, TM-20260911-001-E0025 |
| ACTOR-005 | Fallible operator or conditional co-resident host authority over permitted files/overrides | Misconfiguration, substitution, resource use/disclosure | TM-20260911-001-E0020, TM-20260911-001-E0024 |
| ACTOR-006 | Untrusted document client/consumer; loopback default, remote only after opt-in | Obtain content, confuse interpretation, exhaust serving resources | TM-20260911-001-E0027 |
| ACTOR-007 | Separate responsible reviewer/publisher; legitimate authority not presumed exercised | Legitimate decisions, potentially mistaken/deceived | TM-20260911-001-E0028 |

## TCB, components and interfaces

Established: required runtime trust comprises configuration/policy, mechanism
C, static storage/linker placement, assembly/CSR boundary, compiler/linker
output, firmware and exercised emulator/ISA behavior. The linked fixture is
untrusted for event/access mediation but is an evidence/layout dependency.
No capability parser, dynamic policy server or CHERI backend exists in the
admitted fixed source. Host trust comprises native shell/Make/Git/filesystem,
build toolchains, Node/npm/docs/Graphviz/browser dependencies, package/image
producers, Podman/OCI/kernel/SELinux, inventory and verifier code.
TM-20260911-001-E0012 through TM-20260911-001-E0028.

| Component | Label | Interface and authority |
| --- | --- | --- |
| Fixed TE/config | Established | Bounded internal identifiers, trusted labeling/sealing, exact rules; no guest policy input |
| G-stage | Established | Trusted storage/HPA and fixed GPA/resource/access-bit/root interface |
| Runtime/assembly | Established | VS accesses/events/faults, saved state, root/CSR/SP transitions, SBI diagnostics/shutdown |
| Native build/report | Established | Explicit commands/metadata, canonical outputs, separately compiled JSON |
| Evaluator | Established | Native preflight, networked construction, captured image, constrained work/source/provenance/export |
| Evidence tools | Established | Manifests, finite trace grammar, local tool identity, exact export namespace |
| Docs/review/gate | Established | Generated HTTP/browser inputs, review attestations, structural gate records |

Established: public evidence TM-20260911-001-E0033 through
TM-20260911-001-E0044 qualifies architecture, compiler, build, container and
installation semantics. Inferred: retain the fixed leaf/fault design and
stage-specific bounds; add no new binary, coherence, erasure, installed-code
or producer-authentication credit. Living-page and unknown installed-version
limits remain explicit. Public documentation does not reduce the risk scores.

## Boundaries, flows and entry points

| ID | Label / confidence | Crossing and enforcement | Evidence |
| --- | --- | --- | --- |
| BOUNDARY-001 | Established / High | Producers to native host/build; fixed graph, not arbitrary-source confinement | TM-20260911-001-E0020, TM-20260911-001-E0021 |
| BOUNDARY-002 | Established / High | Platform to HS; required trust plus selected readback/protocol checks | TM-20260911-001-E0016, TM-20260911-001-E0017 |
| BOUNDARY-003 | Established / High | VS to HS state; exact event/fault and transition code | TM-20260911-001-E0015, TM-20260911-001-E0016 |
| BOUNDARY-004 | Established / High | Subject/private/shared memory; per-root policy-derived access | TM-20260911-001-E0012, TM-20260911-001-E0014 |
| BOUNDARY-005 | Established / High | Retained container/host; requested mounts/network/probes/fingerprints | TM-20260911-001-E0023, TM-20260911-001-E0024 |
| BOUNDARY-006 | Established / High | Produced artifacts to interpretation; fields/manifests/traces, not authenticity | TM-20260911-001-E0025, TM-20260911-001-E0026 |
| BOUNDARY-007 | Established / High | Docs/browser/HTTP to host; routes/readiness/default sandbox and loopback | TM-20260911-001-E0027 |
| BOUNDARY-008 | Established / High | Automation to human decision; blocked gate/structural checks | TM-20260911-001-E0028 |
| BOUNDARY-009 | Inferred / Medium | Run to reuse/disposal; partial cleanup/rollback, requirements unknown | TM-20260911-001-E0018, TM-20260911-001-E0029 |

All flows below are Established except FLOW-014 Inferred. Their evidence
follows the associated component/boundary records and the exact IDs listed.

| ID | Source -> destination; data/authority; protection | Boundaries | Evidence |
| --- | --- | --- | --- |
| FLOW-001 | Source/config/packages -> native tools/image; executable inputs/metadata; fixed graph/context | BOUNDARY-001 | TM-20260911-001-E0020, TM-20260911-001-E0022 |
| FLOW-002 | Firmware/platform -> HS; hart/state/loaded image; fixed assumptions | BOUNDARY-002 | TM-20260911-001-E0017 |
| FLOW-003 | Sealed policy/config -> roots; exposure/RWX; combined/individual/map checks | BOUNDARY-004 | TM-20260911-001-E0013, TM-20260911-001-E0014 |
| FLOW-004 | HS -> writer; PC/SP/root/GPRs; selected reset/fences | BOUNDARY-003, BOUNDARY-004 | TM-20260911-001-E0016 |
| FLOW-005 | Writer <-> own/shared pages; private/shared RW and common RX; writer root | BOUNDARY-004 | TM-20260911-001-E0012, TM-20260911-001-E0014 |
| FLOW-006 | VS -> HS; saved state/events/faults; exact sequence/non-nesting assumption | BOUNDARY-003 | TM-20260911-001-E0015, TM-20260911-001-E0016 |
| FLOW-007 | HS writer completion -> reader; root/PC/SP/cleared state; validated switch/fences/readback | BOUNDARY-003, BOUNDARY-004 | TM-20260911-001-E0016 |
| FLOW-008 | Reader <-> own pages, shared/code -> reader; private RW/shared R/code RX; reader root and denials | BOUNDARY-004 | TM-20260911-001-E0012, TM-20260911-001-E0015 |
| FLOW-009 | HS via SBI/emulator -> logs; bounded markers/diagnostics; terminal/host checks | BOUNDARY-002, BOUNDARY-006 | TM-20260911-001-E0015, TM-20260911-001-E0026 |
| FLOW-010 | Source/image/provenance -> work/export; RO inputs/writable copy; capture/mount/fingerprint/export controls | BOUNDARY-005, BOUNDARY-006 | TM-20260911-001-E0023, TM-20260911-001-E0024 |
| FLOW-011 | Bundle/exact source -> verifier; manifests/hashes/semantics/tools; correspondence, not attestation | BOUNDARY-006 | TM-20260911-001-E0025 |
| FLOW-012 | Generated server/docs -> browser/client; content/readiness; confined routes/default loopback | BOUNDARY-007 | TM-20260911-001-E0027 |
| FLOW-013 | Automated docs/gate -> human; decision support; blocked gate/separate authority | BOUNDARY-008 | TM-20260911-001-E0028 |
| FLOW-014 | Complete/interrupted run -> later reuse/disposal; residual state; partial cleanup, no erasure proof | BOUNDARY-009 | TM-20260911-001-E0017, TM-20260911-001-E0029 |

All entry definitions are Established, describing source interfaces rather
than observed successful invocation.

| ID | Exposed party; input/operation; validation | Evidence |
| --- | --- | --- |
| ENTRY-001 | Operator/producers; sources/metadata/paths/tools/Make; protected maintained graph | TM-20260911-001-E0020 |
| ENTRY-002 | Package/registry producer; image construction/installation; pin/lock/closure records | TM-20260911-001-E0022 |
| ENTRY-003 | Platform; hart/state/image/memory; fixed boot assumptions/checks | TM-20260911-001-E0017 |
| ENTRY-004 | Writer/reader; memory loads/stores/execute; per-root leaves | TM-20260911-001-E0014, TM-20260911-001-E0015 |
| ENTRY-005 | VS/platform; ECALL/fault/interrupt state; exact finite state machine | TM-20260911-001-E0015 |
| ENTRY-006 | Trusted runtime; root/PC/SP/frame/CSRs; reset/fence/readback, valid caller required | TM-20260911-001-E0016 |
| ENTRY-007 | Operator/source; native preflight then retained evaluation; no first-command sandbox | TM-20260911-001-E0021, TM-20260911-001-E0023 |
| ENTRY-008 | Artifact producer; paths/manifests/reports/tools; source-derived namespace/correspondence | TM-20260911-001-E0024, TM-20260911-001-E0025 |
| ENTRY-009 | Log producer; positive/negative metadata/diagnostics; distinct finite grammars | TM-20260911-001-E0026 |
| ENTRY-010 | Dependency/operator/client; docs/HTTP/bind/sandbox inputs; routes/readiness/defaults | TM-20260911-001-E0027 |
| ENTRY-011 | Producer/human; review/gate/source metadata; structure, not human authentication | TM-20260911-001-E0028 |
| ENTRY-012 | Runtime/operator/later consumer; failure/cleanup/reinit; terminal caller/handled rollback | TM-20260911-001-E0018, TM-20260911-001-E0029 |

## Threat catalogue

All scenarios below are Inferred. Risk pairs are inherent -> residual
L x I = product/band. Status is analysis, never acceptance. Counter-evidence,
confidence and uncertainty are part of each record, not optional footnotes.

### THREAT-001: Privileged mutation defeats software-only policy sealing
- STRIDE: Tampering; Elevation of privilege.
- Scenario/preconditions: Faulty or compromised HS changes valid label/rule state after initialization; requires privileged storage mutation or initializer defect, not a guest policy API.
- Assets/objectives/actors: ASSET-001, ASSET-002, ASSET-003, ASSET-004; OBJECTIVE-001, OBJECTIVE-002; ACTOR-003.
- Surfaces: ENTRY-001, ENTRY-006, BOUNDARY-004, FLOW-003.
- Controls/mitigations: CONTROL-001, CONTROL-002; MITIGATION-002, MITIGATION-003.
- Inherent: 2 x 4 = 8 / Moderate. Substantial privileged prerequisites precede major cross-boundary effect.
- Residual: 2 x 4 = 8 / Moderate. Ordinary API validation does not constrain an already privileged writer.
- Confidence/status: Medium; Unresolved.
- Uncertainty/counter-evidence/limits: No reachable corruption trigger or mutation demonstrated. Fixed rules/no parser narrow ordinary input; this is dependency risk, not a shown VS-to-HS escape.
- Evidence: TM-20260911-001-E0012, TM-20260911-001-E0013, TM-20260911-001-E0014.

### THREAT-002: Wrong backing or permissions expose a private resource
- STRIDE: Tampering; Information disclosure; Elevation of privilege.
- Scenario/preconditions: A layout/builder/composition or compiled-enforcement defect exposes monitor/private backing or reader-write authority; VS exercises that mapping.
- Assets/objectives/actors: ASSET-001, ASSET-002, ASSET-003, ASSET-004; OBJECTIVE-001, OBJECTIVE-002; ACTOR-001, ACTOR-002, ACTOR-003.
- Surfaces: ENTRY-004, BOUNDARY-004, FLOW-003, FLOW-005, FLOW-008.
- Controls/mitigations: CONTROL-001, CONTROL-002, CONTROL-013; MITIGATION-001, MITIGATION-002.
- Inherent: 3 x 4 = 12 / High. Software-to-hardware mapping errors plausibly violate major isolation.
- Residual: 2 x 4 = 8 / Moderate. Bounds/alias/permission/private-absence checks narrow ordinary errors, not all identity/platform failures.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: No image/walk or full composition proof. Source has four mappings per root and no direct guest table-write path; no unauthorized access observed.
- Evidence: TM-20260911-001-E0014, TM-20260911-001-E0019, TM-20260911-001-E0033, TM-20260911-001-E0035.

### THREAT-003: Forged or misplaced events cause false progress or transition
- STRIDE: Spoofing; Tampering; Elevation of privilege.
- Scenario/preconditions: VS control flow/event/fault identity is mistaken for an expected step. Requires a trap; defeating trusted CSR semantics is a separate platform prerequisite.
- Assets/objectives/actors: ASSET-005, ASSET-007; OBJECTIVE-001, OBJECTIVE-003, OBJECTIVE-004; ACTOR-001, ACTOR-002.
- Surfaces: ENTRY-005, ENTRY-006, BOUNDARY-003, FLOW-006, FLOW-007.
- Controls/mitigations: CONTROL-003, CONTROL-005; MITIGATION-001, MITIGATION-002.
- Inherent: 4 x 4 = 16 / High. Unvalidated guest event/order would be a direct authority surface.
- Residual: 2 x 4 = 8 / Moderate. Subject/phase/PC/cause/address and terminal-sentinel predicates reject obvious substitutions.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: Arbitrary sequences unproved; malformed/early events have explicit failure branches. Hardware fields not assumed guest-writable. Isolated progress PASS is weaker than final success.
- Evidence: TM-20260911-001-E0015, TM-20260911-001-E0019, TM-20260911-001-E0033.

### THREAT-004: Transition residue or stale translation crosses subjects
- STRIDE: Information disclosure; Tampering; Elevation of privilege.
- Scenario/preconditions: Writer state/translation survives reader entry because of omitted/incorrectly compiled reset, ineffective required fence or unmodeled state channel.
- Assets/objectives/actors: ASSET-002, ASSET-003, ASSET-005; OBJECTIVE-001, OBJECTIVE-002; ACTOR-001, ACTOR-002, ACTOR-003.
- Surfaces: ENTRY-006, BOUNDARY-003, BOUNDARY-004, FLOW-004, FLOW-007.
- Controls/mitigations: CONTROL-004, CONTROL-013; MITIGATION-001, MITIGATION-003, MITIGATION-004.
- Inherent: 4 x 4 = 16 / High. Sequential hart/context reuse creates a plausible unsanitized-state channel.
- Residual: 2 x 4 = 8 / Moderate. Named GPR/frame/VS reset, stage fences and root readback constrain that channel.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: Optional/microarchitectural state, WARL and binary correspondence unverified. Historical missing-reset allegations are stale; permitted shared flow is not a violation. No general noninterference claim.
- Evidence: TM-20260911-001-E0016, TM-20260911-001-E0019, TM-20260911-001-E0034, TM-20260911-001-E0035, TM-20260911-001-E0039.

### THREAT-005: An unexpected HS trap reaches stores before origin rejection
- STRIDE: Tampering; Denial of service; Elevation of privilege.
- Scenario/preconditions: A nested/HS fault reaches vector stores with unsuitable SSCRATCH. Requires violation of non-nesting/stack/platform assumptions; no guest trigger established.
- Assets/objectives/actors: ASSET-001, ASSET-005; OBJECTIVE-001, OBJECTIVE-003; ACTOR-003.
- Surfaces: ENTRY-003, ENTRY-005, BOUNDARY-002, BOUNDARY-003, FLOW-006.
- Controls/mitigations: CONTROL-003, CONTROL-004, CONTROL-013; MITIGATION-001, MITIGATION-003.
- Inherent: 2 x 4 = 8 / Moderate. Additional privileged faults precede potentially major corruption.
- Residual: 2 x 4 = 8 / Moderate. Later C checks do not mediate earlier stores.
- Confidence/status: Low; Unresolved.
- Uncertainty/counter-evidence/limits: Reachability/current stack use unknown; ordinary interrupts disabled and non-nesting intended. No overflow/exploit observed; a linker gap is not an unmapped guard under HS Bare.
- Evidence: TM-20260911-001-E0016, TM-20260911-001-E0017.

### THREAT-006: Untrusted progress prevents the finite experiment completing
- STRIDE: Denial of service.
- Scenario/preconditions: VS spins/fails to reach the event or firmware returns from shutdown. Requires adversarial flow or platform progress failure; no runtime scheduler/watchdog.
- Assets/objectives/actors: ASSET-005, ASSET-007; OBJECTIVE-003, OBJECTIVE-007; ACTOR-001, ACTOR-002, ACTOR-003.
- Surfaces: ENTRY-005, ENTRY-012, FLOW-005, FLOW-008, FLOW-014.
- Controls/mitigations: CONTROL-003, CONTROL-007; MITIGATION-004, MITIGATION-011.
- Inherent: 4 x 2 = 8 / Moderate. Non-cooperation readily denies a bounded experiment, not an assumed production service.
- Residual: 4 x 2 = 8 / Moderate. Fail-closed integrity and host timeout do not make reader progress.
- Confidence/status: High; Open.
- Uncertainty/counter-evidence/limits: No SLA/total work budget/hard kill guarantee. Correct abort is not itself an integrity vulnerability; no production-availability claim.
- Evidence: TM-20260911-001-E0017, TM-20260911-001-E0026, TM-20260911-001-E0029, TM-20260911-001-E0034, TM-20260911-001-E0036.

### THREAT-007: A required privileged or tool dependency falsifies enforcement
- STRIDE: Spoofing; Tampering; Information disclosure; Denial of service; Elevation of privilege.
- Scenario/preconditions: Faulty/compromised firmware, emulator, compiler/linker or HS dependency misimplements image, CSR/fence or memory authority while producing plausible output.
- Assets/objectives/actors: ASSET-001, ASSET-002, ASSET-003, ASSET-005, ASSET-007; OBJECTIVE-001, OBJECTIVE-002, OBJECTIVE-004; ACTOR-003, ACTOR-004.
- Surfaces: ENTRY-001, ENTRY-003, BOUNDARY-001, BOUNDARY-002, FLOW-002, FLOW-009.
- Controls/mitigations: CONTROL-004, CONTROL-007, CONTROL-010; MITIGATION-001, MITIGATION-003, MITIGATION-006, MITIGATION-008.
- Inherent: 3 x 4 = 12 / High. Conditional dependency failure invalidates a major boundary.
- Residual: 3 x 4 = 12 / High. Its own checks/hashes/identity do not constrain a compromised enforcement dependency.
- Confidence/status: Low; Unresolved.
- Uncertainty/counter-evidence/limits: No installed exploitability or particular vulnerability; not a prevalence estimate. Multiple compilers/tests detect some accidental differences, not every dependency failure. No current CVE, hardware or proof claim.
- Evidence: TM-20260911-001-E0011, TM-20260911-001-E0017, TM-20260911-001-E0025, TM-20260911-001-E0038, TM-20260911-001-E0039, TM-20260911-001-E0040.

### THREAT-008: Host-side substitution or races poison maintained outputs
- STRIDE: Spoofing; Tampering; Elevation of privilege.
- Scenario/preconditions: Wrong tool/input identity, independent concurrent build or path mutation substitutes canonical evidence. Requires host authority/unsupported concurrency; ordinary overrides are constrained.
- Assets/objectives/actors: ASSET-006, ASSET-007; OBJECTIVE-004, OBJECTIVE-005; ACTOR-004, ACTOR-005.
- Surfaces: ENTRY-001, ENTRY-008, BOUNDARY-001, FLOW-001, FLOW-011.
- Controls/mitigations: CONTROL-006, CONTROL-009, CONTROL-010; MITIGATION-001, MITIGATION-006, MITIGATION-008, MITIGATION-011.
- Inherent: 3 x 4 = 12 / High. Host influence crosses consequential build/evidence identity.
- Residual: 3 x 4 = 12 / High. Forced canonical outputs narrow mistakes but not the remaining hostile-host/race branch.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: Host permissions/concurrency unknown. Grouped outputs, checks and fingerprints are real; no simple BUILD_ROOT bypass claimed. Frozen evidence view was not observed changing.
- Evidence: TM-20260911-001-E0020, TM-20260911-001-E0024, TM-20260911-001-E0025, TM-20260911-001-E0037.

### THREAT-009: An evaluator is mistaken for an arbitrary-source host sandbox
- STRIDE: Tampering; Information disclosure; Elevation of privilege.
- Scenario/preconditions: Untrusted/compromised source or dependencies execute in native preflight because an operator expects end-to-end container confinement.
- Assets/objectives/actors: ASSET-006, ASSET-007; OBJECTIVE-004, OBJECTIVE-005; ACTOR-004, ACTOR-005.
- Surfaces: ENTRY-001, ENTRY-007, BOUNDARY-001, BOUNDARY-005, FLOW-001, FLOW-010.
- Controls/mitigations: CONTROL-006, CONTROL-008, CONTROL-011; MITIGATION-005, MITIGATION-006.
- Inherent: 3 x 4 = 12 / High. Invoking-account execution can affect private host data and later evidence.
- Residual: 3 x 4 = 12 / High. Later container restrictions do not mediate the first native repository command.
- Confidence/status: High; Open.
- Uncertainty/counter-evidence/limits: No specific host secret/malicious bytes/misuse observed. Trusted developer use intentionally executes native tools; not an OCI escape or remote-compromise claim.
- Evidence: TM-20260911-001-E0021, TM-20260911-001-E0022, TM-20260911-001-E0023, TM-20260911-001-E0037, TM-20260911-001-E0043.

### THREAT-010: Evaluated code crosses the retained container boundary
- STRIDE: Tampering; Information disclosure; Denial of service; Elevation of privilege.
- Scenario/preconditions: Retained-container code reaches host/private source, unintended network or excess resources, or engine/kernel/configuration fails enforcement.
- Assets/objectives/actors: ASSET-006, ASSET-007; OBJECTIVE-005, OBJECTIVE-007; ACTOR-004, ACTOR-005.
- Surfaces: ENTRY-007, ENTRY-008, BOUNDARY-005, FLOW-010.
- Controls/mitigations: CONTROL-008, CONTROL-009; MITIGATION-001, MITIGATION-005, MITIGATION-011.
- Inherent: 4 x 4 = 16 / High. Without confinement, direct host modification/disclosure is available.
- Residual: 2 x 4 = 8 / Moderate. Requested mounts/network/proxy/privilege and export checks constrain ordinary container paths.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: Actual enforcement/budgets unverified; native preflight is THREAT-009. Source flags are not observed isolation or defense against a malicious host kernel.
- Evidence: TM-20260911-001-E0023, TM-20260911-001-E0024, TM-20260911-001-E0041, TM-20260911-001-E0042.

### THREAT-011: Recorded dependency closure contains malicious or drifting inputs
- STRIDE: Spoofing; Tampering; Elevation of privilege.
- Scenario/preconditions: Networked construction installs unintended/malicious behavior with consistent pin/lock/inventory; requires producer/repository/tool compromise, mutable resolution or unverified installed bytes.
- Assets/objectives/actors: ASSET-006, ASSET-007, ASSET-008; OBJECTIVE-004, OBJECTIVE-005; ACTOR-004.
- Surfaces: ENTRY-001, ENTRY-002, BOUNDARY-001, FLOW-001.
- Controls/mitigations: CONTROL-006, CONTROL-009, CONTROL-010; MITIGATION-001, MITIGATION-006, MITIGATION-008.
- Inherent: 3 x 4 = 12 / High. Dependencies influence native code, images and evidence.
- Residual: 3 x 4 = 12 / High. Records do not constrain a matching malicious producer or audit every installed npm byte.
- Confidence/status: Medium; Open.
- Uncertainty/counter-evidence/limits: No installed vulnerability/malicious package identified. Five-file build context and exact inventories aid drift detection; no immutable rebuild or patch applicability claim.
- Evidence: TM-20260911-001-E0022, TM-20260911-001-E0024, TM-20260911-001-E0043, TM-20260911-001-E0044.

### THREAT-012: Noncanonical trace diagnostics survive finite validators
- STRIDE: Spoofing; Tampering; Repudiation.
- Scenario/preconditions: Contradictory lines accompany required markers and evade explicit predicates; requires corrupt/substituted logs or overbroad interpretation.
- Assets/objectives/actors: ASSET-007; OBJECTIVE-003, OBJECTIVE-004; ACTOR-004, ACTOR-005.
- Surfaces: ENTRY-009, BOUNDARY-006, FLOW-009.
- Controls/mitigations: CONTROL-005, CONTROL-007, CONTROL-010; MITIGATION-007, MITIGATION-008.
- Inherent: 4 x 3 = 12 / High. Unconstrained serial evidence is readily ambiguous.
- Residual: 3 x 3 = 9 / Moderate. Exact markers reject many errors; distinct positive/negative ignored-line classes remain.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: Static acceptance inference, not reproduced false positive. Explicit result/metadata and post-FAIL checks matter. Fabricated whole logs are THREAT-013; grammar is not authentication.
- Evidence: TM-20260911-001-E0015, TM-20260911-001-E0026.

### THREAT-013: Self-consistent evidence is mistaken for authentic execution
- STRIDE: Spoofing; Tampering; Repudiation.
- Scenario/preconditions: Matching artifacts do not establish claimed source-to-image execution, or core namespace checks are overextended; requires producer control/missing provenance and consumer overreliance.
- Assets/objectives/actors: ASSET-007, ASSET-008; OBJECTIVE-004, OBJECTIVE-006; ACTOR-004, ACTOR-005, ACTOR-007.
- Surfaces: ENTRY-008, ENTRY-009, BOUNDARY-006, FLOW-009, FLOW-011.
- Controls/mitigations: CONTROL-007, CONTROL-009, CONTROL-010, CONTROL-014; MITIGATION-001, MITIGATION-007, MITIGATION-008.
- Inherent: 3 x 4 = 12 / High. Plausible wrong provenance can drive major inappropriate reliance.
- Residual: 3 x 4 = 12 / High. Self-consistency does not independently establish producer honesty or binary correctness.
- Confidence/status: High; Open.
- Uncertainty/counter-evidence/limits: No fraudulent bundle supplied. Blob/type/tool comparisons detect ordinary tampering and do not run bundle-selected executables. Existing verifier expressly does not promise attestation.
- Evidence: TM-20260911-001-E0005, TM-20260911-001-E0011, TM-20260911-001-E0025, TM-20260911-001-E0028, TM-20260911-001-E0044.

### THREAT-014: Documentation exposure or browser assumptions exceed defaults
- STRIDE: Spoofing; Information disclosure; Denial of service.
- Scenario/preconditions: Explicit external serving reveals uncleared content, or readiness/rendering/sandbox boolean is overinterpreted; requires opt-in/exception, inappropriate content or consumer overreliance.
- Assets/objectives/actors: ASSET-006, ASSET-008; OBJECTIVE-005, OBJECTIVE-006; ACTOR-004, ACTOR-005, ACTOR-006.
- Surfaces: ENTRY-010, BOUNDARY-007, FLOW-012.
- Controls/mitigations: CONTROL-011, CONTROL-014; MITIGATION-005, MITIGATION-009, MITIGATION-010, MITIGATION-011.
- Inherent: 3 x 3 = 9 / Moderate. Delivery can violate a bounded confidentiality/evidence objective.
- Residual: 2 x 3 = 6 / Moderate. Safe defaults, routes and child readiness reduce ordinary exposure/stale-listener errors.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: Actual bind/sensitivity/browser defects/budgets unknown. No default wildcard, traversal or RCE demonstrated; boolean is not container-origin authentication or content approval.
- Evidence: TM-20260911-001-E0027, TM-20260911-001-E0028.

### THREAT-015: Structural gate metadata impersonates a human decision
- STRIDE: Spoofing; Tampering; Repudiation; Elevation of privilege.
- Scenario/preconditions: Plausible gate/review bytes are treated as authentic human approval; requires record-writing or deceptive-presentation authority. Frozen gate is not approved.
- Assets/objectives/actors: ASSET-008, ASSET-009; OBJECTIVE-006; ACTOR-004, ACTOR-005, ACTOR-007.
- Surfaces: ENTRY-011, BOUNDARY-008, FLOW-013.
- Controls/mitigations: CONTROL-012, CONTROL-014; MITIGATION-008, MITIGATION-010.
- Inherent: 3 x 4 = 12 / High. False attribution can cause major inappropriate reliance/publication.
- Residual: 3 x 4 = 12 / High. Matching name/time/topology is not actor authentication.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: Downstream human evidence/access controls unknown. Frozen gate blocked and malformed records rejected. No fabricated decision or unauthorized publication observed.
- Evidence: TM-20260911-001-E0028.

### THREAT-016: Bounded PoC evidence is inflated into a stronger security claim
- STRIDE: Spoofing; Repudiation; Tampering.
- Scenario/preconditions: Selective/mistaken use of tests/reports/reviews/later lineage becomes arbitrary isolation, CHERI/CAP+TE/VBS, formal/hardware or acceptance claim.
- Assets/objectives/actors: ASSET-007, ASSET-008, ASSET-009; OBJECTIVE-004, OBJECTIVE-006; ACTOR-004, ACTOR-006, ACTOR-007.
- Surfaces: ENTRY-008, ENTRY-010, ENTRY-011, BOUNDARY-006, BOUNDARY-008, FLOW-013.
- Controls/mitigations: CONTROL-010, CONTROL-012, CONTROL-014; MITIGATION-001, MITIGATION-004, MITIGATION-010, MITIGATION-012.
- Inherent: 3 x 4 = 12 / High. Overreliance can cross major assurance/publication boundaries.
- Residual: 2 x 4 = 8 / Moderate. Explicit limits/gate wording reduce accidental misinterpretation, not intentional fraud.
- Confidence/status: Medium; Partially mitigated.
- Uncertainty/counter-evidence/limits: Downstream consumers unknown; deliberate deception is THREAT-013/015. No CBMC harness at this target, no silent source-model adoption. Package validation is not target security/approval.
- Evidence: TM-20260911-001-E0005, TM-20260911-001-E0006, TM-20260911-001-E0008, TM-20260911-001-E0011, TM-20260911-001-E0019, TM-20260911-001-E0028.

### THREAT-017: Failed reinitialization leaves stale authority for an unsafe caller
- STRIDE: Tampering; Elevation of privilege.
- Scenario/preconditions: Previously valid tree, invalid reinitialization and unchecked reuse despite misleading unusable-on-zero postcondition. No such continuation in fixed runtime.
- Assets/objectives/actors: ASSET-001, ASSET-002, ASSET-003; OBJECTIVE-001, OBJECTIVE-002, OBJECTIVE-007; ACTOR-003.
- Surfaces: ENTRY-006, ENTRY-012, BOUNDARY-009, FLOW-003, FLOW-014.
- Controls/mitigations: CONTROL-003; MITIGATION-002, MITIGATION-012.
- Inherent: 3 x 4 = 12 / High. An unchecked-reuse caller can retain wrong authority; the contract can mislead composition.
- Residual: 1 x 4 = 4 / Low. Fixed caller terminates on zero; no guest reinitialization service.
- Confidence/status: High; Mitigated.
- Uncertainty/counter-evidence/limits: Future callers are not this target. Valid init clears storage; current caller checks failure. The contract mismatch is observed, not an exploit or permission to ignore it.
- Evidence: TM-20260911-001-E0018.

### THREAT-018: Retained state, interruption or unbounded work defeats lifecycle intent
- STRIDE: Information disclosure; Tampering; Denial of service.
- Scenario/preconditions: Residual memory/artifacts/cache, unhandled interruption or excess work discloses data, confuses reuse or exhausts evaluation; requires later access/interruption/workload.
- Assets/objectives/actors: ASSET-006, ASSET-007, ASSET-008, ASSET-005; OBJECTIVE-005, OBJECTIVE-007; ACTOR-003, ACTOR-004, ACTOR-005, ACTOR-006.
- Surfaces: ENTRY-007, ENTRY-010, ENTRY-012, BOUNDARY-009, FLOW-014.
- Controls/mitigations: CONTROL-007, CONTROL-008, CONTROL-009; MITIGATION-003, MITIGATION-009, MITIGATION-011.
- Inherent: 3 x 3 = 9 / Moderate. Realistic retention/interruption/workload conditions affect bounded C/I/A.
- Residual: 3 x 3 = 9 / Moderate. Cleanup, tmpfs sizes and handled rollback are not erasure/crash durability/total budgets.
- Confidence/status: Medium; Unresolved.
- Uncertainty/counter-evidence/limits: Retention/sensitivity/reset/work limits unknown. Cleanup failures are surfaced; retaining evidence can be intentional. No specific disclosure or exhaustion exploit observed.
- Evidence: TM-20260911-001-E0017, TM-20260911-001-E0024, TM-20260911-001-E0027, TM-20260911-001-E0029.

## Controls and mitigation plan

All controls are Established from source; confidence High except
CONTROL-014 Medium. This table includes both effectiveness and its limit.
Threat associations are fully listed in the catalogue above.

| ID | Mechanism/effectiveness and limit | Evidence |
| --- | --- | --- |
| CONTROL-001 | Bounded label/seal/exact whole-rule denial; no privileged immutability | TM-20260911-001-E0013 |
| CONTROL-002 | Exposure/permission/bounds/alias/private checks; backing identity/platform trusted | TM-20260911-001-E0014 |
| CONTROL-003 | Exact sequence/terminal failure/checked init; no pre-store origin guard or liveness | TM-20260911-001-E0015, TM-20260911-001-E0018 |
| CONTROL-004 | Named reset/VT/fence/root readback; not all state/binary behavior | TM-20260911-001-E0016 |
| CONTROL-005 | Volatile selected words/final predicates; not all memory or isolated-progress proof | TM-20260911-001-E0015, TM-20260911-001-E0014 |
| CONTROL-006 | Canonical protected forced graph; not hostile rule/tool/host isolation | TM-20260911-001-E0020 |
| CONTROL-007 | Process/count/timeout/finite grammar; not complete diagnostics/authenticity/deadline | TM-20260911-001-E0026 |
| CONTROL-008 | Retained-container requested constraints; actual enforcement unknown; excludes native preflight | TM-20260911-001-E0023 |
| CONTROL-009 | Private lock/captured identity/fingerprints/export rollback; no atomic source/authenticity/crash proof | TM-20260911-001-E0024 |
| CONTROL-010 | Blob/type/hash/tool/report/trace correspondence; namespace-specific, not binary proof | TM-20260911-001-E0025 |
| CONTROL-011 | Confined default-loopback/sandbox/readiness; no content approval or authenticated exception | TM-20260911-001-E0027 |
| CONTROL-012 | Blocked structural exact gate; no human authentication | TM-20260911-001-E0028 |
| CONTROL-013 | Layout/linker/assertion/entry-assurance definitions; not executed tests or whole-C proof | TM-20260911-001-E0014, TM-20260911-001-E0019 |
| CONTROL-014 | Explicit PoC/non-attestation/provenance limits; accidental interpretation control, not anti-fraud | TM-20260911-001-E0005, TM-20260911-001-E0011, TM-20260911-001-E0028 |

All mitigations are Proposed/Open, earn no current risk reduction and have
Unknown owners. Suggested owner roles below are not assignments. Their
threat links are fully specified by the catalogue.

| ID | Work and verification | Suggested owner / dependency | Evidence |
| --- | --- | --- | --- |
| MITIGATION-001 | Exact-target owner bundle of commands/exits/tools/images/failures; independently compare source/binaries/disassembly/log/environment | Target/evaluator owner | TM-20260911-001-E0011, TM-20260911-001-E0019, TM-20260911-001-E0025 |
| MITIGATION-002 | Composition/negative properties for labels, backing, split rules and event/fault sequences; exact fixtures/results | Runtime owner | TM-20260911-001-E0013, TM-20260911-001-E0014, TM-20260911-001-E0018 |
| MITIGATION-003 | Boot/trap/stack/platform/lifecycle assumptions; exact-image bounds and violation checks, new scope for extra state/harts | Runtime/platform owner | TM-20260911-001-E0016, TM-20260911-001-E0017 |
| MITIGATION-004 | Explicit direct-access/flow/progress limits; trace every claimed state/channel/liveness condition | Architecture owner; approved profile for extra state | TM-20260911-001-E0012, TM-20260911-001-E0019 |
| MITIGATION-005 | External trusted launcher before any native repository code if arbitrary-untrusted evaluation required; adversarial source/dependency verification | Evaluator owner; use-case decision required | TM-20260911-001-E0021, TM-20260911-001-E0023 |
| MITIGATION-006 | Pin/inspect actual closure, installed bytes/patches/config and trusted build environment; independent correspondence | Build/dependency owner | TM-20260911-001-E0022 |
| MITIGATION-007 | Canonical trace grammars and contradictory-prefix/terminal-position mutation tests with exact rejection results | Evidence-tool owner | TM-20260911-001-E0026 |
| MITIGATION-008 | Independent producer/source-to-image provenance and namespace limits; trusted capture/comparison, no self-issued assurance upgrade | Assurance owner; requirements decision | TM-20260911-001-E0025, TM-20260911-001-E0028 |
| MITIGATION-009 | Non-loopback/sandbox/content-delivery/work-budget boundaries; explicit default/opt-in and resource tests | Documentation/evaluator owner | TM-20260911-001-E0027 |
| MITIGATION-010 | Separate authenticated human decisions and exact-output disclosure review from structural checks | Responsible human required | TM-20260911-001-E0028 |
| MITIGATION-011 | Retention/cleanup/interruption/concurrency/total-work requirements and fault/recovery/resource evidence | Operations owner; no execution by this engagement | TM-20260911-001-E0024, TM-20260911-001-E0029 |
| MITIGATION-012 | Align API/fixture/diagram/historical-state wording with actual supported path and provenance | Target documentation owner | TM-20260911-001-E0005, TM-20260911-001-E0018, TM-20260911-001-E0019 |

## Assumptions and non-goals

| ID | Label | Premise, consequence if false and check | Evidence |
| --- | --- | --- | --- |
| ASSUMPTION-001 | Established | Fixed one-hart/two-subject/policy/resources, no dynamic devices/DMA/interrupt/multicore service; expansion requires new scope and actual profile check | TM-20260911-001-E0012, TM-20260911-001-E0017 |
| ASSUMPTION-002 | Unknown | Platform/tool semantics realize source intent; failure invalidates readback/log reliance; primary semantics plus independent exact-platform evidence needed | TM-20260911-001-E0011, TM-20260911-001-E0016, TM-20260911-001-E0025 |
| ASSUMPTION-003 | Established | HS caller/storage/backing integrity required; failure breaks policy/root claims; inspect exact callers/dataflow/corruption properties | TM-20260911-001-E0013, TM-20260911-001-E0014, TM-20260911-001-E0018 |
| ASSUMPTION-004 | Established / Unknown | Four-byte labels/selected-word fixture source established, exact binary unknown; disassembly/image correspondence needed | TM-20260911-001-E0015, TM-20260911-001-E0019 |
| ASSUMPTION-005 | Inferred | Adversarial role is not an unrecorded replacement payload; check reachability and counterfactual prerequisites without importing another snapshot | TM-20260911-001-E0012, TM-20260911-001-E0015 |
| ASSUMPTION-006 | Established / Unknown | Native trust precedes retained isolation; arbitrary-tree expectation unknown; if required, external launcher boundary is missing | TM-20260911-001-E0021, TM-20260911-001-E0023 |
| ASSUMPTION-007 | Established / Inferred | Records bind specified bytes, not producer honesty; independent exact-run/tool provenance needed under OPEN-005/006 | TM-20260911-001-E0025, TM-20260911-001-E0028 |
| ASSUMPTION-008 | Established | No human gate delegated; treating a score/agent/metadata as acceptance breaks objective; separate authenticated human record required | TM-20260911-001-E0001, TM-20260911-001-E0028 |
| ASSUMPTION-009 | Unknown | Retention/erasure/crash requirements unresolved; OPEN-007 may change lifecycle impact and needed controls | TM-20260911-001-E0017, TM-20260911-001-E0029 |
| ASSUMPTION-010 | Established / Unknown | Shared flow allowed; stronger noninterference/availability not established; selected checks/timeout/abort do not prove them | TM-20260911-001-E0012, TM-20260911-001-E0017, TM-20260911-001-E0026 |

## Attack trees and abuse cases

Inferred: OR denotes alternative branches; AND requires every prerequisite.
No attack was executed. The seven current normative DOT sources are frozen by
hash for this iteration in `REVIEW-INPUT-001.md`; diagram edges summarize, not
expand, the following complete semantics.

### ATTACK-001: Violate fixed subject isolation
Goal: unauthorized private/HS memory or context influence; OBJECTIVE-001/002,
ACTOR-001/002 exploiting defects or ACTOR-003 supplying privileged conditions.
OR: THREAT-001 policy mutation, THREAT-002 mapping, THREAT-003/004
event/transition, THREAT-005/007 trap/platform. Stale authority THREAT-017 is
AND of valid old tree, failed reinit and unchecked reuse; fixed caller blocks
the last. Boundaries BOUNDARY-002/003/004/009; controls
CONTROL-001/002/003/004/013 constrain different branches. Success is actual
forbidden influence, not a progress marker. Reachability/proof unknown.
TM-20260911-001-E0013 through TM-20260911-001-E0018.

### ATTACK-002: Obtain misleading positive evidence
Goal: unsupported reliance, OBJECTIVE-004, ACTOR-004/005, BOUNDARY-006.
OR: THREAT-008 substitution, THREAT-012 ignored contradictory lines,
THREAT-013 dishonest self-consistent producer. Trace branch AND: required
predicates satisfied, contrary line outside rejection, consumer overreliance.
CONTROL-007/009/010 check narrower changes; producer identity remains
unknown. TM-20260911-001-E0020, TM-20260911-001-E0025,
TM-20260911-001-E0026.

### ATTACK-003: Influence the host through evaluation
Goal: unauthorized host/data effect, OBJECTIVE-004/005, ACTOR-004/005,
BOUNDARY-001/005/007. Native THREAT-009 branch AND: malicious/untrusted
source/dependency and incorrect operator sandbox expectation. Other OR
branches THREAT-011 construction, THREAT-010 retained boundary,
THREAT-014 inappropriate exposure/exception. CONTROL-008 starts downstream
of native execution and cannot protect its first command. No escape observed.
TM-20260911-001-E0021, TM-20260911-001-E0022,
TM-20260911-001-E0023, TM-20260911-001-E0027.

### ATTACK-004: Misuse a decision or later lifecycle
OR goals: THREAT-015 false attribution, THREAT-016 claim inflation,
THREAT-006 denied progress, THREAT-018 inappropriate reuse/disposal.
Attribution is AND of plausible supplied metadata and belief in unestablished
human identity/authority. ACTOR-004/005/006/007 and conditional ACTOR-003;
BOUNDARY-008/009; OBJECTIVE-003/006/007. CONTROL-012/014 preserve
distinctions but do not authenticate deception. Lifecycle requirements remain
unknown. TM-20260911-001-E0017, TM-20260911-001-E0028,
TM-20260911-001-E0029.

## Coverage matrix

Inferred: S/T/R/I/D/E mean Spoofing/Tampering/Repudiation/Information
disclosure/Denial of service/Elevation of privilege. The matrix is
consideration, not security proof. Inert memory/transition S/R concerns trace
to actual subject-binding/emitted evidence, not invented identity protocols.

| Surfaces | STRIDE threats or bounded disposition |
| --- | --- |
| BOUNDARY-001, FLOW-001, ENTRY-001, ENTRY-002 | S/T/E THREAT-008/011; I THREAT-009; R THREAT-013; D THREAT-018 |
| BOUNDARY-002, FLOW-002, ENTRY-003 | S/T/I/D/E THREAT-007; D THREAT-006; R via FLOW-009/THREAT-013 |
| BOUNDARY-004, FLOW-003 | T/I/E THREAT-001/002/017; S THREAT-003; D THREAT-006; R THREAT-013 |
| FLOW-004, ENTRY-006 | S/T/E THREAT-003/005; I THREAT-004; D THREAT-006; R THREAT-013 |
| FLOW-005, FLOW-008, ENTRY-004 | T/I/E THREAT-002; S THREAT-003; D THREAT-006; R THREAT-012/013; shared writer-to-reader flow permitted |
| BOUNDARY-003, FLOW-006, ENTRY-005 | S/T/E THREAT-003/005; I THREAT-004; D THREAT-006; R THREAT-012/013 |
| FLOW-007 | S/T/E THREAT-003; I/T THREAT-004; D THREAT-006; R THREAT-012/013 |
| BOUNDARY-006, FLOW-009, ENTRY-009 | S/T/R THREAT-012/013; D THREAT-006/018; I THREAT-018; E only downstream overreliance THREAT-016, not a parser exploit |
| BOUNDARY-005, FLOW-010, ENTRY-007 | S/T/R THREAT-011/013; I/E THREAT-009/010; D THREAT-018 |
| FLOW-011, ENTRY-008 | S/T/R THREAT-013; D THREAT-018; I/E direct path constrained, additional trusted-source/tool failure THREAT-008/009/011 |
| BOUNDARY-007, FLOW-012, ENTRY-010 | S/I/D THREAT-014; T/R THREAT-013/016; E requires additional native/dependency failure THREAT-009/011 |
| BOUNDARY-008, FLOW-013, ENTRY-011 | S/T/R/E THREAT-015/016; I THREAT-014/018; D THREAT-018; waiting for genuine approval is intended gating |
| BOUNDARY-009, FLOW-014, ENTRY-012 | T/I/D THREAT-017/018; S/R THREAT-013/015; E THREAT-017; D THREAT-006 |

Established: every objective, asset and actor is explicitly traced in the
threat catalogue's links. Every boundary/flow/entry appears above and carries
source evidence in its registry. CONTROL and MITIGATION associations are
specified for every threat; no proposed control receives credit.

## Residual concerns and limits

Inferred: residual High threats are THREAT-007, THREAT-008, THREAT-009,
THREAT-011, THREAT-013 and THREAT-015, all 12/25. The highest score is not
observed exploitation probability. THREAT-017 is Low, 4/25, only under its
fixed-caller qualification. Other threats remain Moderate, 6-9/25.

Established: source coverage is broad, not exhaustive line/input/binary/run
coverage. Host fixture ranges, generated output and exact execution bundles
remain explicitly limited in RUN-MANIFEST.md. All substantive observations
retain evidence/counter-evidence; no private implementation was copied here.

Established: Beryllium accepted through R7, R8-H0 committed candidate not
accepted, K3 hardware NOT RUN. Helium is a review-and-test PoC, not formally
verified or hardware validated; this exact configuration has no CBMC harness.
Selected later properties and prior approvals are not inherited. Distribution
is private; no responsible-human decision, promotion, sign-off, publication
or risk acceptance is granted. Independent review remains the next gate.
TM-20260911-001-E0004, TM-20260911-001-E0009,
TM-20260911-001-E0011, TM-20260911-001-E0028.
