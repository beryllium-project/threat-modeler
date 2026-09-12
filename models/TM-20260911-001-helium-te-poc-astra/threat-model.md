# Helium fixed-TE threat model

Package ID: `TM-20260911-001`
Title: Helium TE PoC Independent Threat Model (GPT-6 Astra)
Created: 2026-09-11
Status: `Complete`
Distribution: `private`
Latest model iteration: `MODEL-ITERATION-002`

## Executive summary

Established: this is a source-led, `create-from-evidence` model of clean
Helium `1ab289c066b69acdd8b55c9f77055b0145be1316`, not an execution-backed
assessment. The fixed source assigns types, derives two roots, validates a
finite writer/reader sequence and resets selected transition state.
TM-20260911-001-E0012, TM-20260911-001-E0014,
TM-20260911-001-E0015, TM-20260911-001-E0016.

Inferred: the strongest remaining concerns are conditional trust failures in
native evaluation, privileged/platform dependencies, mutable dependency
installation, host-side races, evidence producers and human-decision
attribution. They are not demonstrated guest escapes or current compromised
dependencies. Highest residual ratings are **High (12/25)** under the
capabilities and prerequisites below. The assessment neither authenticates a
successful run at this commit nor proves end-to-end isolation.
TM-20260911-001-E0021, TM-20260911-001-E0022,
TM-20260911-001-E0024, TM-20260911-001-E0025,
TM-20260911-001-E0028.

Established: no target-owned surface is excluded from consideration, but
absence of a subsystem is not evidence that its future design is secure.
The snapshot has no CBMC harness or stronger formal/hardware assurance.
Later Beryllium, Helium, CHERI, multi-hart or VBS results are not inherited.
Public-primary-source gap research is complete at its bounded semantic depth.
OPEN-003/004 are resolved through twelve admitted primary observations;
OPEN-009 and the current BLOCKED-004 tooling state were resolved through the
explicit Astra resumption gate. The first independent review identified
three model corrections, incorporated below and closed in the same
reviewer's bounded follow-up. No earlier-model comparison informed this
blind projection.
TM-20260911-001-E0001, TM-20260911-001-E0006,
TM-20260911-001-E0009, TM-20260911-001-E0011,
TM-20260911-001-E0031, TM-20260911-001-E0032,
TM-20260911-001-E0033, TM-20260911-001-E0044,
TM-20260911-001-E0046.

## Iteration and review reconciliation

Established: the first complete model/review iterations and their retained
DOT input remain unchanged. This complete successor adds one conditional
disclosure scenario and proposed mitigation, makes branch-specific control
credit explicit, and repairs reciprocal coverage. No target behavior changed.
Established: all three modeling findings were closed in REVIEW-ITERATION-002.
Only workflow/closure annotations in this expanded projection changed after
that review; its threat records, ratings and the immutable MODEL-ITERATION-002
remain unchanged.
TM-20260911-001-E0045, TM-20260911-001-E0046.

| Finding | Reconciliation | Risk consequence |
| --- | --- | --- |
| FINDING-001 | THREAT-019, MITIGATION-013, ASSUMPTION-011 and OPEN-010 explicitly trace readable input through permitted output to an unauthorized recipient; ATTACK-003 and diagrams retain all three AND prerequisites. | New conditional Moderate 9/25; no leak or output-content freedom assumed established |
| FINDING-002 | THREAT-010 now rates only ordinary paths under correct enforcement; failed kernel/OCI enforcement is THREAT-007, total budgets THREAT-018, permitted-output disclosure THREAT-019. THREAT-014 retains deliberate exposure/exception branches without default-derived credit. | THREAT-010 remains conditionally 8/25; THREAT-014 rises from 6/25 to 9/25 |
| FINDING-003 | Restore THREAT-003 in OBJECTIVE-004 coverage; THREAT-007 in CONTROL-010's reverse list; CONTROL-013 in THREAT-008's forward list; ACTOR-001/002 in ATTACK-004. New relationships are propagated below. | No numerical reduction for link repair; CONTROL-013's THREAT-008 role is only bounded malformed-output detection |

## Fact labels

- `Established`: directly supported by admitted evidence.
- `Inferred`: reasoned from evidence with alternatives and limitations.
- `Proposed`: a candidate design, control, or mitigation.
- `Unknown`: evidence is missing or conflicting.

## System boundary and lifecycle

Established: the boundary includes the fixed RV64 image, linked policy,
privileged assembly/CSR/firmware seam, host build/evaluation/evidence and
documentation/review/publication-support code. Historical Beryllium is design
context only. All controls below mean mechanisms present in source, not
observed successful execution. TM-20260911-001-E0001,
TM-20260911-001-E0012, TM-20260911-001-E0011.

| Stage | Label | Behavior and authority | Limits and evidence |
| --- | --- | --- | --- |
| Build/configuration | Established | Trusted host tools compile fixed source, policy, payload and layout; image construction has a networked dependency phase. | Host source/tool trust precedes container isolation; TM-20260911-001-E0020, TM-20260911-001-E0021, TM-20260911-001-E0022 |
| Boot/initialization | Established | Firmware enters HS; assembly clears BSS and creates the trusted stack; C validates hart zero, labels/seals policy and derives roots. | Late hart rejection is not a multicore-safe bootstrap; TM-20260911-001-E0013, TM-20260911-001-E0014, TM-20260911-001-E0017 |
| Writer | Established | One VS context has private RW stack/data, common RX code and RW shared data; fixed events and a cross-private load exercise the monitor. | Shared communication is intentional; TM-20260911-001-E0012, TM-20260911-001-E0015 |
| Trap/recovery | Established | Only exact phase/identity/PC/address events recover; unlisted events terminate. | Four-byte recovery, non-nesting and platform CSR behavior are dependencies; TM-20260911-001-E0015, TM-20260911-001-E0016 |
| Writer-to-reader | Established | Validated completion clears saved GPRs, resets listed VS state, changes root/SP and fences before return. | No arbitrary context-switch or microarchitectural proof; TM-20260911-001-E0016 |
| Reader | Established | Reader has its own private RW pages and shared R access; expected shared-store and opposite-private-load faults precede final checks. | Selected sentinel words, not every memory byte, are observed; TM-20260911-001-E0015, TM-20260911-001-E0019 |
| Failure/shutdown | Established | Failure is terminal; SBI shutdown/reset and legacy fallback precede WFI if firmware returns. | No runtime scheduler, watchdog, restart service or scrub; TM-20260911-001-E0017 |
| Evaluation/evidence | Established | Native preflight, captured-image evaluation, manifests, trace checks and export are distinct phases. | Correspondence is not producer authenticity; TM-20260911-001-E0021, TM-20260911-001-E0023, TM-20260911-001-E0025 |
| Review/publication | Established | Generated documentation and retained reviews inform separate responsible-human decisions; frozen gate is blocked. | No human authentication or approval inferred; TM-20260911-001-E0027, TM-20260911-001-E0028 |
| Update/reuse/disposal | Unknown | Source/dependency changes require a new exact snapshot; retention, abrupt interruption and erasure requirements are not established. | No dynamic policy update or in-run reset service is invented; TM-20260911-001-E0018, TM-20260911-001-E0029 |

## Security objectives

| Objective ID | Label | Objective | Evidence IDs | Confidence | Limitations |
| --- | --- | --- | --- | --- | --- |
| OBJECTIVE-001 | Proposed | Preserve HS code/data, policy, roots and trusted transition integrity. | TM-20260911-001-E0012, TM-20260911-001-E0016 | High | Objective derived from intent; not a proven property |
| OBJECTIVE-002 | Proposed | Deny unapproved direct cross-private access and preserve writer-RW/reader-R shared-page semantics. | TM-20260911-001-E0012, TM-20260911-001-E0014 | High | Not arbitrary noninterference; writer-to-reader sharing is allowed |
| OBJECTIVE-003 | Proposed | Reject invalid authority transitions and distinguish finite success from honest failure without silently weakening policy. | TM-20260911-001-E0015, TM-20260911-001-E0017 | High | No availability SLA or runtime progress guarantee |
| OBJECTIVE-004 | Proposed | Preserve exact source/build/tool/artifact correspondence and truthful evidence interpretation. | TM-20260911-001-E0020, TM-20260911-001-E0025, TM-20260911-001-E0026 | High | Independent producer authenticity remains unknown |
| OBJECTIVE-005 | Proposed | Protect host/source confidentiality and integrity across the stated evaluator boundary. | TM-20260911-001-E0021, TM-20260911-001-E0023 | High | No arbitrary-tree sandbox; actual host asset value/configuration unknown |
| OBJECTIVE-006 | Proposed | Preserve claim/provenance discipline and separate automation from responsible-human publication decisions. | TM-20260911-001-E0005, TM-20260911-001-E0028 | High | No decision authority granted by this model |
| OBJECTIVE-007 | Proposed | Define safe recovery, freshness, resource use and disposal for retained state. | TM-20260911-001-E0017, TM-20260911-001-E0029 | Medium | Requirements and platform retention behavior remain open |

## Protected assets

| Asset ID | Label | Asset | Required property | Owner or authority | Evidence IDs | Confidence |
| --- | --- | --- | --- | --- | --- | --- |
| ASSET-001 | Established | HS code, trusted stack, TE state, rule/config data and G-stage tables | Integrity and exclusive trusted mutation | HS mechanism; human owner identity not inferred | TM-20260911-001-E0012, TM-20260911-001-E0013 | High |
| ASSET-002 | Established | Writer-private stack and data | Direct-access confidentiality/integrity against reader | Monitor-assigned writer role | TM-20260911-001-E0012 | High |
| ASSET-003 | Established | Reader-private stack and data | Direct-access confidentiality/integrity against writer | Monitor-assigned reader role | TM-20260911-001-E0012 | High |
| ASSET-004 | Established | Common RX code and directional shared data | Code integrity; shared writer RW and reader R | Fixed policy and HS mappings | TM-20260911-001-E0012, TM-20260911-001-E0014 | High |
| ASSET-005 | Established | Active subject, phase, saved GPR/CSR/root/SP state | Correct binding, sanitization and transition ordering | HS only | TM-20260911-001-E0015, TM-20260911-001-E0016 | High |
| ASSET-006 | Inferred | Host checkout/Git, user-accessible files and evaluator state | Confidentiality, integrity and bounded resource use | Invoking account; specific secrets/owners unknown | TM-20260911-001-E0021, TM-20260911-001-E0023 | Medium |
| ASSET-007 | Established | Images, dependency records, authority reports, logs and evidence bundles | Integrity, freshness, correspondence and honest provenance; Proposed: authorized disclosure where outputs carry private inputs | Producers/checkers; no authenticated trust root established | TM-20260911-001-E0022, TM-20260911-001-E0025 | High |
| ASSET-008 | Established | Generated documentation and retained review content | Correct attribution, claim limits and appropriate disclosure | Maintained source and separate human review | TM-20260911-001-E0027, TM-20260911-001-E0028 | High |
| ASSET-009 | Established | Publication-gate bytes and declared human-decision metadata | Integrity and non-impersonation | Responsible human, not this agent | TM-20260911-001-E0028 | High |

## Actors and capabilities

| Actor ID | Label | Actor | Trust | Access and capabilities | Goals | Evidence IDs | Confidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ACTOR-001 | Inferred | Adversarial writer behavior | Untrusted VS role | Instructions/state permitted by its mapped code/private/shared pages; ECALL/fault inputs; no direct HS policy API | Cross-private access, false events or stalled progress | TM-20260911-001-E0012, TM-20260911-001-E0015 | Medium |
| ACTOR-002 | Inferred | Adversarial reader behavior | Untrusted VS role | Reader mappings and event/fault inputs; shared read only | Shared write, writer-private access or false completion | TM-20260911-001-E0012, TM-20260911-001-E0015 | Medium |
| ACTOR-003 | Inferred | Faulty/compromised privileged TCB dependency | Required trust, not established correctness | HS storage/control, firmware/emulator or host kernel/OCI enforcement according to the failed dependency | Bypass or misimplement assumed enforcement | TM-20260911-001-E0013, TM-20260911-001-E0017, TM-20260911-001-E0023 | Medium |
| ACTOR-004 | Inferred | Source/dependency/image/evidence producer | Trusted for some inputs; potentially malicious | Supplies source/build inputs, package bytes, reports or logs; no assumed direct runtime HS entry | Poison execution or present misleading evidence | TM-20260911-001-E0021, TM-20260911-001-E0022, TM-20260911-001-E0025 | Medium |
| ACTOR-005 | Inferred | Invoking operator or co-resident host process | Operator trusted but fallible; co-resident authority conditional | Supported overrides and, where permissions allow, host files/output races | Misconfigure, substitute artifacts, consume resources or disclose data | TM-20260911-001-E0020, TM-20260911-001-E0024 | Medium |
| ACTOR-006 | Inferred | Documentation client/content consumer | Untrusted client | Loopback HTTP by default; remote access only after explicit non-loopback exposure | Obtain published content, confuse interpretation or exhaust serving resources | TM-20260911-001-E0027 | Medium |
| ACTOR-007 | Proposed | Responsible reviewer/publisher | Separate human authority | Reviews exact inputs and makes decisions; can be mistaken or deceived | Legitimate review/publication, not presumed approval | TM-20260911-001-E0028 | Medium |

Inferred: the adversarial VS cases test the intended untrusted boundary;
they do not assert that the frozen cooperative payload actually performs an
exploit or secretly replace its linked code. A different payload/build is a
different source snapshot. The linked payload is untrusted for access/event
mediation but its exact layout and labeled instructions are part of the
fixture/evidence dependency. TM-20260911-001-E0015,
TM-20260911-001-E0019.

## Trusted computing base and dependencies

Established: runtime trust includes fixed configuration/policy, mechanism C,
static storage and linker placement, privileged transition assembly, compiler
and linker output, firmware and exercised QEMU/ISA behavior. Payload actions
are mediated as untrusted, although interpreting its finite experiment depends
on the linked fixture. No hardware-tagged capabilities or dynamic policy
service is inferred. TM-20260911-001-E0012, TM-20260911-001-E0013,
TM-20260911-001-E0014, TM-20260911-001-E0016,
TM-20260911-001-E0019.

Established: host trust includes shell/Make/Git and filesystem semantics,
compiler/binutils/LLVM, Node/npm and documentation dependencies, Graphviz,
Chromium/Playwright, registry/package repositories, Podman/OCI/kernel/SELinux,
inventory/checker code and the evidence producer. A recorded version/hash
identifies a claimed input; it does not establish correctness. Native preflight
is outside retained-container restrictions. TM-20260911-001-E0020,
TM-20260911-001-E0021, TM-20260911-001-E0022,
TM-20260911-001-E0023, TM-20260911-001-E0025.

### Public-source applicability

Established: the public pass addresses normative/tool semantics, not an
execution record. Versioned references and living-page qualifications are in
the ledger. Inferred: the application below supports existing narrow controls
and non-claims; it does not reduce risk merely because a specification exists.

| Public evidence | Model consequence | Remaining boundary |
| --- | --- | --- |
| TM-20260911-001-E0033, TM-20260911-001-E0034, TM-20260911-001-E0035 | Preserve the source's leaf/fault design; limit state and fence claims to the fixed profile. | Emulator/CSR behavior and compiled transitions remain unverified |
| TM-20260911-001-E0036 | Shutdown requests remain firmware-dependent, not an erasure or completion deadline. | Firmware support/conformance unknown |
| TM-20260911-001-E0037 | Protected assignments do not sandbox executable build rules. | Trusted host/tools and path races remain |
| TM-20260911-001-E0038, TM-20260911-001-E0039, TM-20260911-001-E0040 | No extra coherence, atomicity or binary-correctness credit is added. | Exact installed compiler and lowering unknown |
| TM-20260911-001-E0041, TM-20260911-001-E0042 | Keep native preflight separate from the configured retained-container boundary. | Actual host/OCI/SELinux enforcement unknown |
| TM-20260911-001-E0043, TM-20260911-001-E0044 | Do not promote lock consistency into installed-code or producer trust. | Installed closure, patches and authenticity unknown |

## Components and interfaces

| Component | Label | Interface and authority | Evidence IDs |
| --- | --- | --- | --- |
| Fixed configuration/TE | Established | Internal bounded identifiers, label initialization, seal and exact rule lookup; no runtime guest policy input | TM-20260911-001-E0012, TM-20260911-001-E0013 |
| G-stage mechanism | Established | Trusted storage/HPA inputs, fixed GPA resources, leaf access bits and root encoding | TM-20260911-001-E0014, TM-20260911-001-E0018 |
| Runtime/assembly | Established | VS memory operations, ECALLs, faults, saved state, CSR/root/stack transitions and SBI output/shutdown | TM-20260911-001-E0015, TM-20260911-001-E0016, TM-20260911-001-E0017 |
| Native builder/report | Established | Explicit commands, selected toolchains/metadata, canonical outputs and offline JSON projection | TM-20260911-001-E0020 |
| Evaluator | Established | Native preflight, networked image construction, captured image, restricted work/source/provenance/export mounts | TM-20260911-001-E0021, TM-20260911-001-E0022, TM-20260911-001-E0023 |
| Evidence tools | Established | Source/artifact manifests, trace grammar, local tool identities, strict transport namespace and staged publication | TM-20260911-001-E0024, TM-20260911-001-E0025, TM-20260911-001-E0026 |
| Documentation/review/gate | Established | Generated HTTP content, browser option, declared review provenance and exact gate-only commit structure | TM-20260911-001-E0027, TM-20260911-001-E0028 |

## Trust boundaries

| Boundary ID | Label | Boundary | Crossing parties | Enforcement | Evidence IDs | Confidence |
| --- | --- | --- | --- | --- | --- | --- |
| BOUNDARY-001 | Established | Source/dependency to trusted host/build | Producer, operator, compiler/tools | Maintained graph/input checks, not arbitrary-source confinement | TM-20260911-001-E0020, TM-20260911-001-E0021 | High |
| BOUNDARY-002 | Established | Firmware/emulator/ISA to HS | Privileged dependencies and monitor | Required platform trust; selected readback/protocol checks | TM-20260911-001-E0016, TM-20260911-001-E0017 | High |
| BOUNDARY-003 | Established | VS/HS privilege and trap state | Writer/reader and monitor | Exact event/origin/phase/PC/fault checks and transition code | TM-20260911-001-E0015, TM-20260911-001-E0016 | High |
| BOUNDARY-004 | Established | Subject memory and authorized sharing | Writer, reader, HS-owned roots | Policy-derived mappings and private absence | TM-20260911-001-E0012, TM-20260911-001-E0014 | High |
| BOUNDARY-005 | Established | Retained container and host | Evaluated code, host/source/export | Read-only mounts, restricted execution environment, probes and fingerprints | TM-20260911-001-E0023, TM-20260911-001-E0024 | High |
| BOUNDARY-006 | Established | Produced artifacts to interpreted evidence | Producers, parsers, verifier and consumer | Exact fields/manifests/trace checks, not authenticity | TM-20260911-001-E0025, TM-20260911-001-E0026 | High |
| BOUNDARY-007 | Established | Generated web content/client/browser to host | Content, HTTP clients and native renderer | Confined server, loopback default, child readiness, default browser sandbox | TM-20260911-001-E0027 | High |
| BOUNDARY-008 | Established | Automation to human decision/publication | Review producers and responsible human | Blocked gate and structural checks; decision remains separate | TM-20260911-001-E0028 | High |
| BOUNDARY-009 | Inferred | Current run to reuse/recovery/disposal | Runtime, host storage and later consumers | Partial cleanup/rollback; freshness and erasure requirements unknown | TM-20260911-001-E0018, TM-20260911-001-E0029 | Medium |

## Data and control flows

| Flow ID | Label | Source | Destination | Data or authority | Boundary IDs | Protection | Evidence IDs |
| --- | --- | --- | --- | --- | --- | --- | --- |
| FLOW-001 | Established | Source/config/packages | Native tools/image build | Executable inputs, metadata and dependencies | BOUNDARY-001 | Fixed graph and declared image inputs; producer trust remains | TM-20260911-001-E0020, TM-20260911-001-E0022 |
| FLOW-002 | Established | Firmware/platform | HS bootstrap | Hart/state, memory and privilege assumptions | BOUNDARY-002 | Fixed profile; late hart check is not full boot confinement | TM-20260911-001-E0017 |
| FLOW-003 | Established | Sealed policy/configuration | G-stage roots | Mapping exposure and R/W/X authority | BOUNDARY-004 | Open/individual/combined decisions and mapping checks | TM-20260911-001-E0013, TM-20260911-001-E0014 |
| FLOW-004 | Established | HS | Writer VS | Initial PC/SP/root and registers | BOUNDARY-003, BOUNDARY-004 | Selected entry reset and fences | TM-20260911-001-E0016 |
| FLOW-005 | Established | Writer | Private/common/shared memory | Private RW, shared RW and code RX | BOUNDARY-004 | Writer root and fixed policy | TM-20260911-001-E0012, TM-20260911-001-E0014 |
| FLOW-006 | Established | VS subject | HS trap handler | Saved GPRs, events and fault/CSR observations | BOUNDARY-003 | Exact monitored sequence; non-nested entry assumption | TM-20260911-001-E0015, TM-20260911-001-E0016 |
| FLOW-007 | Established | HS writer completion | Reader VS | New root/SP/PC, cleared frame and VS state | BOUNDARY-003, BOUNDARY-004 | Validated transition, fences and root readback | TM-20260911-001-E0016 |
| FLOW-008 | Established | Reader | Private/common/shared memory | Private RW, shared R and code RX | BOUNDARY-004 | Reader root; denied shared store and cross-private load | TM-20260911-001-E0012, TM-20260911-001-E0015 |
| FLOW-009 | Established | HS via SBI/emulator | Host serial logs | Fixed progress/final markers and bounded diagnostics | BOUNDARY-002, BOUNDARY-006 | Terminal checks plus host process/trace checks | TM-20260911-001-E0015, TM-20260911-001-E0026 |
| FLOW-010 | Established | Source/image/provenance | Container work and host export | Read-only inputs, writable copy and retained outputs | BOUNDARY-005, BOUNDARY-006 | Captured image, mounts, fingerprints and export contract | TM-20260911-001-E0023, TM-20260911-001-E0024 |
| FLOW-011 | Established | Bundle and exact source | Offline checker/consumer | Manifests, hashes, semantics, logs and tool identities | BOUNDARY-006 | Source/blob/type correspondence; no producer attestation | TM-20260911-001-E0025 |
| FLOW-012 | Established | Generated documents/server | Browser and HTTP clients | HTML/assets/reviews and readiness metadata | BOUNDARY-007 | Confined routes and loopback default, not content approval | TM-20260911-001-E0027 |
| FLOW-013 | Established | Automated records/gate | Responsible reviewer/publisher | Declared provenance, exact source and decision metadata | BOUNDARY-008 | Blocked gate; separate human authority | TM-20260911-001-E0028 |
| FLOW-014 | Inferred | Completed/interrupted run | Later reuse or disposal | Residual memory, artifacts, locks and caches | BOUNDARY-009 | Partial cleanup and rollback, no proven erasure | TM-20260911-001-E0017, TM-20260911-001-E0029 |

## Entry points and attack surface

| Entry ID | Label | Entry point | Exposed to | Input or operation | Validation or mediation | Evidence IDs |
| --- | --- | --- | --- | --- | --- | --- |
| ENTRY-001 | Established | Build/configuration/tool selection | Operator and producers | Fixed source, flags/metadata, paths, tools and Make invocation | Protected maintained graph; no arbitrary caller-code sandbox | TM-20260911-001-E0020 |
| ENTRY-002 | Established | Networked image/dependency construction | Registry/package producers | Declared build context and package installation | Pinned base/lock and recorded closure, not semantic trust | TM-20260911-001-E0022 |
| ENTRY-003 | Established | Firmware bootstrap | Privileged platform | Hart ID, initial state, loaded image and memory | Fixed assumptions and bounded initialization | TM-20260911-001-E0017 |
| ENTRY-004 | Established | VS memory access | Writer/reader | Loads, stores and execution within mapped address space | Per-root leaves and fixed authority | TM-20260911-001-E0014, TM-20260911-001-E0015 |
| ENTRY-005 | Established | ECALL/fault/interrupt trap | VS inputs and platform | Event registers, PC, fault values and origin/cause | Exact state machine; unsupported events terminate | TM-20260911-001-E0015 |
| ENTRY-006 | Established | HS entry/switch code | Trusted runtime | Root, PC, SP, saved frame and CSR writes | Reset/fence/readback; valid caller and non-nesting required | TM-20260911-001-E0016 |
| ENTRY-007 | Established | Complete evaluator command | Operator and evaluated source | Native preflight followed by container execution | No protection before the first repository-owned native command | TM-20260911-001-E0021, TM-20260911-001-E0023 |
| ENTRY-008 | Established | Evidence/export/verifier | Artifact producers | Paths, types, manifests, reports and tool records | Source-derived comparison and namespace checks | TM-20260911-001-E0024, TM-20260911-001-E0025 |
| ENTRY-009 | Established | Positive/negative serial parser | Log producer | Expected markers, metadata and diagnostics | Different finite grammars with explicit omissions | TM-20260911-001-E0026 |
| ENTRY-010 | Established | Documentation build/render/HTTP | Dependencies, caller and clients | Generated content, routes, bind options and sandbox boolean | Route/readiness checks; default sandbox/loopback | TM-20260911-001-E0027 |
| ENTRY-011 | Established | Review/publication metadata | Producers and human reviewer | Review attestations, gate bytes and source topology | Structural checks; no authenticated human grant | TM-20260911-001-E0028 |
| ENTRY-012 | Established | Failure/cleanup/reinitialization | Runtime, host operator and later state consumers | Shutdown, retained state, locks and storage | Terminal fixed caller; handled rollback only | TM-20260911-001-E0018, TM-20260911-001-E0029 |

## Threat catalogue

Inferred: ratings assess the named conditional scenario, not a discovered
exploitation probability. Existing controls receive credit only for their
source-supported boundary; a trusted dependency becoming malicious is not
stopped by its own hashes, a software seal or a policy statement.

Inferred: control credit in this source-led model is conditional on the
implemented mechanism behaving as inspected within the stated fixed profile.
It is not measured operational effectiveness. No exact-target execution,
full installed dependency inventory or provider/human authentication was
admitted. Confidence in the source mechanism is distinct from confidence in
likelihood/impact; a high-confidence trust-boundary observation does not make
its ordinal score an observed incident frequency. Proposed mitigation owners
are suggestions, not assignments or accepted work.

### THREAT-001: Privileged mutation defeats software-only policy sealing
- Fact label: Inferred
- STRIDE: Tampering; Elevation of privilege
- Scenario: Faulty or compromised HS authority changes valid label/rule state after initialization and allows an unintended exposure.
- Preconditions: Privileged storage mutation or trusted initializer defect; no guest policy-update interface exists.
- Asset IDs: ASSET-001, ASSET-002, ASSET-003, ASSET-004
- Objective IDs: OBJECTIVE-001, OBJECTIVE-002
- Actor IDs: ACTOR-003
- Surface IDs: ENTRY-001, ENTRY-006, BOUNDARY-004, FLOW-003
- Existing control IDs: CONTROL-001, CONTROL-002
- Mitigation IDs: MITIGATION-002, MITIGATION-003
- Inherent likelihood: 2
- Inherent impact: 4
- Inherent risk: Moderate
- Inherent rationale: 2 x 4 = 8; privileged prerequisites are substantial, but a successful mutation can cross subject boundaries.
- Residual likelihood: 2
- Residual impact: 4
- Residual risk: Moderate
- Residual rationale: 2 x 4 = 8; normal API checks reject malformed operations but do not constrain an already privileged writer.
- Risk uncertainty: No reachable HS corruption trigger or actual mutated policy was established.
- Confidence: Medium
- Evidence IDs: TM-20260911-001-E0012, TM-20260911-001-E0013, TM-20260911-001-E0014
- Status: Unresolved
- Alternatives and counter-evidence: Fixed labels/rules and no guest parser sharply limit ordinary input exposure; do not invent a runtime relabel API.
- Limitations: Dependency risk, not a demonstrated VS-to-HS escalation.

### THREAT-002: Wrong backing or permissions expose a private resource
- Fact label: Inferred
- STRIDE: Tampering; Information disclosure; Elevation of privilege
- Scenario: Erroneous mapping composition, aliasing or access bits expose monitor/private backing or allow reader writes.
- Preconditions: Defect in trusted layout/builder/composition or compiled enforcement; VS then exercises the resulting mapping.
- Asset IDs: ASSET-001, ASSET-002, ASSET-003, ASSET-004
- Objective IDs: OBJECTIVE-001, OBJECTIVE-002
- Actor IDs: ACTOR-001, ACTOR-002, ACTOR-003
- Surface IDs: ENTRY-004, BOUNDARY-004, FLOW-003, FLOW-005, FLOW-008
- Existing control IDs: CONTROL-001, CONTROL-002, CONTROL-013
- Mitigation IDs: MITIGATION-001, MITIGATION-002
- Inherent likelihood: 3
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: 3 x 4 = 12; software-to-hardware mapping errors plausibly violate a major isolation objective.
- Residual likelihood: 2
- Residual impact: 4
- Residual risk: Moderate
- Residual rationale: 2 x 4 = 8; range/alias/permission/private-absence checks narrow ordinary construction errors, not every backing-identity or compiled-platform failure.
- Risk uncertainty: Actual images/walks and a complete composition argument are unavailable.
- Confidence: Medium
- Evidence IDs: TM-20260911-001-E0014, TM-20260911-001-E0019, TM-20260911-001-E0033, TM-20260911-001-E0035
- Status: Partially mitigated
- Alternatives and counter-evidence: Current source maps only the fixed four resources per root; no direct guest table-write path was established.
- Limitations: No observed unauthorized access or architectural correctness theorem.

### THREAT-003: Forged or misplaced events cause false progress or transition
- Fact label: Inferred
- STRIDE: Spoofing; Tampering; Elevation of privilege
- Scenario: VS event values, unexpected control flow or fault identity are mistaken for the exact writer/reader step and authorize recovery, switching or success.
- Preconditions: Adversarial VS behavior reaches a trap; defeating trusted CSR semantics is a separate platform prerequisite.
- Asset IDs: ASSET-005, ASSET-007
- Objective IDs: OBJECTIVE-001, OBJECTIVE-003, OBJECTIVE-004
- Actor IDs: ACTOR-001, ACTOR-002
- Surface IDs: ENTRY-005, ENTRY-006, BOUNDARY-003, FLOW-006, FLOW-007
- Existing control IDs: CONTROL-003, CONTROL-005
- Mitigation IDs: MITIGATION-001, MITIGATION-002
- Inherent likelihood: 4
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: 4 x 4 = 16; unvalidated event registers/order would give a capable VS actor a direct authority-transition surface.
- Residual likelihood: 2
- Residual impact: 4
- Residual risk: Moderate
- Residual rationale: 2 x 4 = 8; active-subject/phase/PC/cause/address and terminal-sentinel checks reject the obvious substitutions.
- Risk uncertainty: Arbitrary sequences and all malformed CSR/address combinations have not been executed or proved.
- Confidence: Medium
- Evidence IDs: TM-20260911-001-E0015, TM-20260911-001-E0019, TM-20260911-001-E0033
- Status: Partially mitigated
- Alternatives and counter-evidence: Wrong order, early completion and unsupported causes have explicit failure branches; hardware-origin fields are not assumed guest-writable.
- Limitations: An isolated intermediate PASS precedes some checks and must not be treated as terminal success.

### THREAT-004: Transition residue or stale translation crosses subjects
- Fact label: Inferred
- STRIDE: Information disclosure; Tampering; Elevation of privilege
- Scenario: Writer state or stale translation survives entry into reader and conveys unauthorized state or authority.
- Preconditions: Omitted/incorrectly compiled transition state handling, ineffective required fence or an unmodeled state channel.
- Asset IDs: ASSET-002, ASSET-003, ASSET-005
- Objective IDs: OBJECTIVE-001, OBJECTIVE-002
- Actor IDs: ACTOR-001, ACTOR-002, ACTOR-003
- Surface IDs: ENTRY-006, BOUNDARY-003, BOUNDARY-004, FLOW-004, FLOW-007
- Existing control IDs: CONTROL-004, CONTROL-013
- Mitigation IDs: MITIGATION-001, MITIGATION-003, MITIGATION-004
- Inherent likelihood: 4
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: 4 x 4 = 16; sequential reuse of a hart/root context makes unsanitized state a credible channel.
- Residual likelihood: 2
- Residual impact: 4
- Residual risk: Moderate
- Residual rationale: 2 x 4 = 8; the source clears GPR/frame and listed VS state, fences both stages and checks root selection.
- Risk uncertainty: Optional state, microarchitectural channels, WARL behavior and exact-binary correspondence remain outside demonstrated evidence.
- Confidence: Medium
- Evidence IDs: TM-20260911-001-E0016, TM-20260911-001-E0019, TM-20260911-001-E0034, TM-20260911-001-E0035, TM-20260911-001-E0039
- Status: Partially mitigated
- Alternatives and counter-evidence: Historical missing-GPR/CSR-reset allegations do not describe current source; shared-page communication is intentionally allowed.
- Limitations: No general noninterference, arbitrary context-switch or hardware claim.

### THREAT-005: An unexpected HS trap reaches stores before origin rejection
- Fact label: Inferred
- STRIDE: Tampering; Denial of service; Elevation of privilege
- Scenario: A nested/HS-origin fault enters the direct vector with SSCRATCH unsuitable as trusted stack and performs frame stores before C rejects origin.
- Preconditions: Violation of the non-nested handler/trusted-stack/platform assumption; no current triggering guest path established.
- Asset IDs: ASSET-001, ASSET-005
- Objective IDs: OBJECTIVE-001, OBJECTIVE-003
- Actor IDs: ACTOR-003
- Surface IDs: ENTRY-003, ENTRY-005, BOUNDARY-002, BOUNDARY-003, FLOW-006
- Existing control IDs: CONTROL-003, CONTROL-004, CONTROL-013
- Mitigation IDs: MITIGATION-001, MITIGATION-003
- Inherent likelihood: 2
- Inherent impact: 4
- Inherent risk: Moderate
- Inherent rationale: 2 x 4 = 8; substantial additional privileged fault conditions precede a potentially major corruption.
- Residual likelihood: 2
- Residual impact: 4
- Residual risk: Moderate
- Residual rationale: 2 x 4 = 8; later C origin checks do not mediate the earlier stores, so no false credit is assigned against this branch.
- Risk uncertainty: Reachability and current maximum HS stack use are unknown.
- Confidence: Low
- Evidence IDs: TM-20260911-001-E0016, TM-20260911-001-E0017
- Status: Unresolved
- Alternatives and counter-evidence: Normal interrupts are disabled and the fixed handler is intended not to nest; no overflow or exploit was demonstrated.
- Limitations: A linker gap would not by itself be an unmapped guard under HS Bare translation.

### THREAT-006: Untrusted progress prevents the finite experiment completing
- Fact label: Inferred
- STRIDE: Denial of service
- Scenario: A VS context spins or repeatedly fails to reach the required event, or firmware returns from shutdown, preventing reader/final completion.
- Preconditions: Adversarial control flow or failed platform progress; the fixed runtime has no scheduling/watchdog service.
- Asset IDs: ASSET-005, ASSET-007
- Objective IDs: OBJECTIVE-003, OBJECTIVE-007
- Actor IDs: ACTOR-001, ACTOR-002, ACTOR-003
- Surface IDs: ENTRY-005, ENTRY-012, FLOW-005, FLOW-008, FLOW-014
- Existing control IDs: CONTROL-003, CONTROL-007
- Mitigation IDs: MITIGATION-004, MITIGATION-011
- Inherent likelihood: 4
- Inherent impact: 2
- Inherent risk: Moderate
- Inherent rationale: 4 x 2 = 8; a non-cooperative context can readily deny one bounded experiment, not an assumed production service.
- Residual likelihood: 4
- Residual impact: 2
- Residual risk: Moderate
- Residual rationale: 4 x 2 = 8; fail-closed handling protects integrity, not progress; the host timeout invocation does not make the reader execute.
- Risk uncertainty: No SLA, complete evaluator time budget or proved hard process-kill deadline is established.
- Confidence: High
- Evidence IDs: TM-20260911-001-E0017, TM-20260911-001-E0026, TM-20260911-001-E0029, TM-20260911-001-E0034, TM-20260911-001-E0036
- Status: Open
- Alternatives and counter-evidence: Abort on malformed behavior is correct fail-closed behavior, not itself an integrity vulnerability.
- Limitations: Do not convert this PoC limitation into an unsupported production-availability claim.

### THREAT-007: A required privileged or tool dependency falsifies enforcement
- Fact label: Inferred
- STRIDE: Spoofing; Tampering; Information disclosure; Denial of service; Elevation of privilege
- Scenario: Firmware, emulator, compiler/linker or HS dependency misimplements image/CSR/memory authority, or a host kernel/OCI dependency fails retained-container enforcement, while outputs remain plausible.
- Preconditions: Fault or compromise in a required trusted dependency; no specific current vulnerability is established.
- Asset IDs: ASSET-001, ASSET-002, ASSET-003, ASSET-005, ASSET-006, ASSET-007
- Objective IDs: OBJECTIVE-001, OBJECTIVE-002, OBJECTIVE-004, OBJECTIVE-005
- Actor IDs: ACTOR-003, ACTOR-004
- Surface IDs: ENTRY-001, ENTRY-003, ENTRY-007, BOUNDARY-001, BOUNDARY-002, BOUNDARY-005, FLOW-002, FLOW-009, FLOW-010
- Existing control IDs: CONTROL-004, CONTROL-007, CONTROL-010
- Mitigation IDs: MITIGATION-001, MITIGATION-003, MITIGATION-006, MITIGATION-008
- Inherent likelihood: 3
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: 3 x 4 = 12; conditional dependency failure can invalidate a major modeled boundary.
- Residual likelihood: 3
- Residual impact: 4
- Residual risk: High
- Residual rationale: 3 x 4 = 12; source checks, hashes and self-reported identity do not independently constrain a compromised enforcement dependency.
- Risk uncertainty: Installed versions, patches, actual behavior and exploitability are unknown; rating is not a prevalence estimate.
- Confidence: Low
- Evidence IDs: TM-20260911-001-E0011, TM-20260911-001-E0017, TM-20260911-001-E0023, TM-20260911-001-E0025, TM-20260911-001-E0038, TM-20260911-001-E0039, TM-20260911-001-E0040, TM-20260911-001-E0042
- Status: Unresolved
- Alternatives and counter-evidence: Multiple compiler/test paths and exact identity records can expose accidental differences but are not independent proof of all dependency semantics.
- Limitations: No hardware, current-CVE, full-system proof or compromised-platform claim.

### THREAT-008: Host-side substitution or races poison maintained outputs
- Fact label: Inferred
- STRIDE: Spoofing; Tampering; Elevation of privilege
- Scenario: Wrong tool/input identity, independently concurrent build activity or host path mutation substitutes an artifact later interpreted as canonical.
- Preconditions: Host authority over tools/paths or unsupported concurrency; ordinary caller variable overrides alone are constrained.
- Asset IDs: ASSET-006, ASSET-007
- Objective IDs: OBJECTIVE-004, OBJECTIVE-005
- Actor IDs: ACTOR-004, ACTOR-005
- Surface IDs: ENTRY-001, ENTRY-008, BOUNDARY-001, FLOW-001, FLOW-011
- Existing control IDs: CONTROL-006, CONTROL-009, CONTROL-010, CONTROL-013
- Mitigation IDs: MITIGATION-001, MITIGATION-006, MITIGATION-008, MITIGATION-011
- Inherent likelihood: 3
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: 3 x 4 = 12; the host can influence source/artifact identity across a consequential build-to-evidence boundary.
- Residual likelihood: 3
- Residual impact: 4
- Residual risk: High
- Residual rationale: 3 x 4 = 12; canonical forced outputs narrow ordinary mistakes, but the remaining hostile-host/race branch is explicitly outside those guarantees.
- Risk uncertainty: Actual concurrent actors and host access control are unknown.
- Confidence: Medium
- Evidence IDs: TM-20260911-001-E0020, TM-20260911-001-E0024, TM-20260911-001-E0025, TM-20260911-001-E0037
- Status: Partially mitigated
- Alternatives and counter-evidence: Maintained input/goal/path checks, grouped outputs, layout/assertion guards and per-phase fingerprints detect bounded mistakes; CONTROL-013 adds no credit against malicious host authority or races. No easy BUILD_ROOT override bypass is claimed.
- Limitations: Not evidence that the current frozen owner-prepared view changed.

### THREAT-009: An evaluator is mistaken for an arbitrary-source host sandbox
- Fact label: Inferred
- STRIDE: Tampering; Information disclosure; Elevation of privilege
- Scenario: An operator evaluates untrusted source/dependencies expecting container confinement, but repository-owned native preflight executes with invoking-account authority first.
- Preconditions: Untrusted or compromised source/dependency and a mistaken end-to-end isolation expectation.
- Asset IDs: ASSET-006, ASSET-007
- Objective IDs: OBJECTIVE-004, OBJECTIVE-005
- Actor IDs: ACTOR-004, ACTOR-005
- Surface IDs: ENTRY-001, ENTRY-007, BOUNDARY-001, BOUNDARY-005, FLOW-001, FLOW-010
- Existing control IDs: CONTROL-006, CONTROL-008, CONTROL-011
- Mitigation IDs: MITIGATION-005, MITIGATION-006
- Inherent likelihood: 3
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: 3 x 4 = 12; native execution can reach user-accessible private files and influence later evaluation.
- Residual likelihood: 3
- Residual impact: 4
- Residual risk: High
- Residual rationale: 3 x 4 = 12; later container restrictions do not mediate the first native repository command.
- Risk uncertainty: Specific host secrets, supplied malicious bytes and actual misuse are not established.
- Confidence: High
- Evidence IDs: TM-20260911-001-E0021, TM-20260911-001-E0022, TM-20260911-001-E0023, TM-20260911-001-E0037, TM-20260911-001-E0043
- Status: Open
- Alternatives and counter-evidence: A trusted-checkout developer workflow intentionally runs native tools; this is not a demonstrated OCI escape or unexpected malicious code in the snapshot.
- Limitations: Conditional workflow trust-boundary risk, not a claim of remote compromise.

### THREAT-010: Evaluated code crosses the retained container boundary
- Fact label: Inferred
- STRIDE: Tampering; Information disclosure; Denial of service; Elevation of privilege
- Scenario: Evaluated code attempts an ordinary forbidden write, traversal or network/environment crossing outside the declared writable work/export surface.
- Preconditions: Attempt from the retained container with the declared effective restrictions and a correctly enforcing engine/kernel. Dependency failure is separately THREAT-007; undeclared total work budgets are THREAT-018; disclosure through permitted outputs is THREAT-019.
- Asset IDs: ASSET-006, ASSET-007
- Objective IDs: OBJECTIVE-005
- Actor IDs: ACTOR-004, ACTOR-005
- Surface IDs: ENTRY-007, ENTRY-008, BOUNDARY-005, FLOW-010
- Existing control IDs: CONTROL-008, CONTROL-009
- Mitigation IDs: MITIGATION-001, MITIGATION-005, MITIGATION-011
- Inherent likelihood: 4
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: 4 x 4 = 16; unconfined evaluated code could directly modify or disclose host state.
- Residual likelihood: 2
- Residual impact: 4
- Residual risk: Moderate
- Residual rationale: 2 x 4 = 8 only for the correctly enforced ordinary-path branch; read-only/network/proxy/capability restrictions and export checks mediate those attempted crossings. No credit transfers to failed dependencies, uncapped work or permitted-content disclosure.
- Risk uncertainty: Actual OCI/kernel behavior is unverified, so this conditional score is not an aggregate score for every evaluator failure. The unmediated branches retain their separate unreduced ratings.
- Confidence: Medium
- Evidence IDs: TM-20260911-001-E0023, TM-20260911-001-E0024, TM-20260911-001-E0041, TM-20260911-001-E0042
- Status: Partially mitigated
- Alternatives and counter-evidence: Source/provenance mounts and hidden overlays are read-only by request, not unreadable. Native preflight is THREAT-009; readable input reaching permitted output is THREAT-019, not a container escape.
- Limitations: Flags and fixture definitions are not observed isolation or protection from a malicious host kernel.

### THREAT-011: Recorded dependency closure contains malicious or drifting inputs
- Fact label: Inferred
- STRIDE: Spoofing; Tampering; Elevation of privilege
- Scenario: Networked package/image construction installs unintended or malicious dependency behavior while retaining internally consistent base, lock and inventory records.
- Preconditions: Producer/repository/tool compromise, mutable package resolution or unverified installed bytes.
- Asset IDs: ASSET-006, ASSET-007, ASSET-008
- Objective IDs: OBJECTIVE-004, OBJECTIVE-005
- Actor IDs: ACTOR-004
- Surface IDs: ENTRY-001, ENTRY-002, BOUNDARY-001, FLOW-001
- Existing control IDs: CONTROL-006, CONTROL-009, CONTROL-010
- Mitigation IDs: MITIGATION-001, MITIGATION-006, MITIGATION-008
- Inherent likelihood: 3
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: 3 x 4 = 12; dependencies can influence native execution, generated images and evidence.
- Residual likelihood: 3
- Residual impact: 4
- Residual risk: High
- Residual rationale: 3 x 4 = 12; pinned base and recorded closure do not constrain a malicious matching producer or audit all installed npm bytes.
- Risk uncertainty: No applicable installed vulnerability or malicious package is identified.
- Confidence: Medium
- Evidence IDs: TM-20260911-001-E0022, TM-20260911-001-E0024, TM-20260911-001-E0043, TM-20260911-001-E0044
- Status: Open
- Alternatives and counter-evidence: Five-file image input and exact inventories make accidental drift more detectable; an observed mutable closure is honestly documented.
- Limitations: No current advisory, distro-patch or reproducible-build conclusion.

### THREAT-012: Noncanonical trace diagnostics survive finite validators
- Fact label: Inferred
- STRIDE: Spoofing; Tampering; Repudiation
- Scenario: Additional contradictory diagnostic/metadata lines accompany all required markers and are interpreted as complete, unambiguous evidence.
- Preconditions: Log corruption/substitution or an overbroad consumer interpretation; the altered lines avoid the validators' explicit rejection predicates.
- Asset IDs: ASSET-007
- Objective IDs: OBJECTIVE-003, OBJECTIVE-004
- Actor IDs: ACTOR-004, ACTOR-005
- Surface IDs: ENTRY-009, BOUNDARY-006, FLOW-009
- Existing control IDs: CONTROL-005, CONTROL-007, CONTROL-010
- Mitigation IDs: MITIGATION-007, MITIGATION-008
- Inherent likelihood: 4
- Inherent impact: 3
- Inherent risk: High
- Inherent rationale: 4 x 3 = 12; unconstrained serial evidence is readily ambiguous or substituted.
- Residual likelihood: 3
- Residual impact: 3
- Residual risk: Moderate
- Residual rationale: 3 x 3 = 9; existing exact markers reject many errors but positive and negative grammars leave different ignored-line classes.
- Risk uncertainty: Static acceptance reasoning, not an executed false-positive or reachable runtime transcript.
- Confidence: Medium
- Evidence IDs: TM-20260911-001-E0015, TM-20260911-001-E0026
- Status: Partially mitigated
- Alternatives and counter-evidence: Positive failure/result and metadata checks are real; negative validation rejects post-FAIL Helium lines. Entirely fabricated logs remain THREAT-013.
- Limitations: Stricter grammar cannot authenticate a malicious producer.

### THREAT-013: Self-consistent evidence is mistaken for authentic execution
- Fact label: Inferred
- STRIDE: Spoofing; Tampering; Repudiation
- Scenario: A producer presents matching hashes/manifests/reports/logs that do not establish the claimed source-to-image execution, or consumers extend core namespace validation to ungoverned material.
- Preconditions: Producer control or missing independent provenance; consumers rely beyond the exact checked correspondence boundary.
- Asset IDs: ASSET-007, ASSET-008
- Objective IDs: OBJECTIVE-004, OBJECTIVE-006
- Actor IDs: ACTOR-004, ACTOR-005, ACTOR-007
- Surface IDs: ENTRY-008, ENTRY-009, BOUNDARY-006, FLOW-009, FLOW-011
- Existing control IDs: CONTROL-007, CONTROL-009, CONTROL-010, CONTROL-014
- Mitigation IDs: MITIGATION-001, MITIGATION-007, MITIGATION-008
- Inherent likelihood: 3
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: 3 x 4 = 12; wrong provenance can drive a major reliance decision despite plausible artifacts.
- Residual likelihood: 3
- Residual impact: 4
- Residual risk: High
- Residual rationale: 3 x 4 = 12; self-consistency checks do not independently establish producer honesty or source-to-binary correctness.
- Risk uncertainty: No fraudulent bundle supplied; authentication requirements and exact-target run records remain unknown.
- Confidence: High
- Evidence IDs: TM-20260911-001-E0005, TM-20260911-001-E0011, TM-20260911-001-E0025, TM-20260911-001-E0028, TM-20260911-001-E0044
- Status: Open
- Alternatives and counter-evidence: Exact source/blob/type/tool checks substantially detect ordinary tampering; bundle-selected executable paths are not executed.
- Limitations: No claim that the existing verifier promises attestation; its documented boundary is narrower.

### THREAT-014: Documentation exposure or browser assumptions exceed defaults
- Fact label: Inferred
- STRIDE: Spoofing; Information disclosure; Denial of service
- Scenario: Deliberate non-loopback serving exposes uncleared generated content, or source freshness/browser containment is inferred from readiness, rendering or a caller-supplied sandbox exception.
- Preconditions: Explicit exposure/exception, inappropriate generated content or a consumer relying beyond verified delivery.
- Asset IDs: ASSET-006, ASSET-008
- Objective IDs: OBJECTIVE-005, OBJECTIVE-006
- Actor IDs: ACTOR-004, ACTOR-005, ACTOR-006
- Surface IDs: ENTRY-010, BOUNDARY-007, FLOW-012
- Existing control IDs: CONTROL-011, CONTROL-014
- Mitigation IDs: MITIGATION-005, MITIGATION-009, MITIGATION-010, MITIGATION-011
- Inherent likelihood: 3
- Inherent impact: 3
- Inherent risk: Moderate
- Inherent rationale: 3 x 3 = 9; content delivery can violate a bounded confidentiality or evidence objective.
- Residual likelihood: 3
- Residual impact: 3
- Residual risk: Moderate
- Residual rationale: 3 x 3 = 9; defaults and listener checks protect ordinary configuration/readiness errors, not deliberate non-loopback exposure, an intentionally disabled sandbox or uncleared content. Those branches receive no default-derived numerical credit.
- Risk uncertainty: Actual bind, output sensitivity, browser defects and request-load budget are unknown.
- Confidence: Medium
- Evidence IDs: TM-20260911-001-E0027, TM-20260911-001-E0028
- Status: Partially mitigated
- Alternatives and counter-evidence: No default wildcard listener or demonstrated traversal/RCE is claimed. A boolean exception does not authenticate container origin.
- Limitations: Path confinement is not semantic sanitization, human approval or source-revision attestation.

### THREAT-015: Structural gate metadata impersonates a human decision
- Fact label: Inferred
- STRIDE: Spoofing; Tampering; Repudiation; Elevation of privilege
- Scenario: A structurally plausible gate/review record is represented as an authentic responsible-human approval without establishing who made the decision.
- Preconditions: Authority to supply/change records or deceive a downstream consumer; no current approved gate exists.
- Asset IDs: ASSET-008, ASSET-009
- Objective IDs: OBJECTIVE-006
- Actor IDs: ACTOR-004, ACTOR-005, ACTOR-007
- Surface IDs: ENTRY-011, BOUNDARY-008, FLOW-013
- Existing control IDs: CONTROL-012, CONTROL-014
- Mitigation IDs: MITIGATION-008, MITIGATION-010
- Inherent likelihood: 3
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: 3 x 4 = 12; false decision attribution can cause a major inappropriate reliance/publication action.
- Residual likelihood: 3
- Residual impact: 4
- Residual risk: High
- Residual rationale: 3 x 4 = 12; name/time/topology checks do not authenticate an actor already able to provide matching bytes.
- Risk uncertainty: Downstream publication controls and responsible-human evidence are not established.
- Confidence: Medium
- Evidence IDs: TM-20260911-001-E0028
- Status: Partially mitigated
- Alternatives and counter-evidence: Frozen gate is blocked; structural checks reject stale/invalid records and publication is explicitly a separate human action.
- Limitations: This model neither fabricates a record nor claims an unauthorized publication occurred.

### THREAT-016: Bounded PoC evidence is inflated into a stronger security claim
- Fact label: Inferred
- STRIDE: Spoofing; Repudiation; Tampering
- Scenario: A consumer interprets selected sentinel/tests, a policy report, prior reviews or later lineage as arbitrary isolation, CHERI/CAP+TE/VBS behavior, formal verification, hardware validation or acceptance.
- Preconditions: Misinterpretation or selective presentation of evidence beyond its recorded boundary.
- Asset IDs: ASSET-007, ASSET-008, ASSET-009
- Objective IDs: OBJECTIVE-004, OBJECTIVE-006
- Actor IDs: ACTOR-004, ACTOR-006, ACTOR-007
- Surface IDs: ENTRY-008, ENTRY-010, ENTRY-011, BOUNDARY-006, BOUNDARY-008, FLOW-013
- Existing control IDs: CONTROL-010, CONTROL-012, CONTROL-014
- Mitigation IDs: MITIGATION-001, MITIGATION-004, MITIGATION-010, MITIGATION-012
- Inherent likelihood: 3
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: 3 x 4 = 12; inappropriate reliance can cross a major assurance or publication boundary.
- Residual likelihood: 2
- Residual impact: 4
- Residual risk: Moderate
- Residual rationale: 2 x 4 = 8; repeated explicit PoC/non-attestation/blocked-gate wording reduces accidental misinterpretation, not deliberate fraud.
- Risk uncertainty: Actual consumers and intended downstream reliance are unknown; deliberate deception remains THREAT-013/015.
- Confidence: Medium
- Evidence IDs: TM-20260911-001-E0005, TM-20260911-001-E0006, TM-20260911-001-E0008, TM-20260911-001-E0011, TM-20260911-001-E0019, TM-20260911-001-E0028
- Status: Partially mitigated
- Alternatives and counter-evidence: Current source explicitly disclaims CBMC/formal/hardware evidence; historical review claims are qualified and no source model was silently adopted.
- Limitations: Current package validation also does not establish target security or human approval.

### THREAT-017: Failed reinitialization leaves stale authority for an unsafe caller
- Fact label: Inferred
- STRIDE: Tampering; Elevation of privilege
- Scenario: A caller assumes failed G-stage initialization invalidated storage, then reuses an old valid tree.
- Preconditions: Previously valid storage, invalid reinitialization arguments and failure to honor the return value; no such continuation in the fixed runtime.
- Asset IDs: ASSET-001, ASSET-002, ASSET-003
- Objective IDs: OBJECTIVE-001, OBJECTIVE-002, OBJECTIVE-007
- Actor IDs: ACTOR-003
- Surface IDs: ENTRY-006, ENTRY-012, BOUNDARY-009, FLOW-003, FLOW-014
- Existing control IDs: CONTROL-003
- Mitigation IDs: MITIGATION-002, MITIGATION-012
- Inherent likelihood: 3
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: 3 x 4 = 12 for an unchecked-reuse caller; the documented postcondition can mislead future composition.
- Residual likelihood: 1
- Residual impact: 4
- Residual risk: Low
- Residual rationale: 1 x 4 = 4; the actual fixed caller terminates on zero and exposes no guest reinitialization service.
- Risk uncertainty: Future callers are not part of this target; the API documentation mismatch is directly observed, not an executed exploit.
- Confidence: High
- Evidence IDs: TM-20260911-001-E0018
- Status: Mitigated
- Alternatives and counter-evidence: Valid initialization clears storage; current source checks the result before mapping/entry.
- Limitations: Mitigated means bounded fixed-caller control, not risk acceptance or permission to reuse the API contract unchanged.

### THREAT-018: Retained state, interruption or unbounded work defeats lifecycle intent
- Fact label: Inferred
- STRIDE: Information disclosure; Tampering; Denial of service
- Scenario: Residual memory/artifacts/cache, unhandled interruption or insufficient total resource limits disclose data, confuse later-run state or exhaust the evaluator.
- Preconditions: Later access to retained state, interruption outside handled recovery, or adversarial/accidental excessive work.
- Asset IDs: ASSET-006, ASSET-007, ASSET-008, ASSET-005
- Objective IDs: OBJECTIVE-005, OBJECTIVE-007
- Actor IDs: ACTOR-003, ACTOR-004, ACTOR-005, ACTOR-006
- Surface IDs: ENTRY-007, ENTRY-010, ENTRY-012, BOUNDARY-009, FLOW-014
- Existing control IDs: CONTROL-007, CONTROL-008, CONTROL-009
- Mitigation IDs: MITIGATION-003, MITIGATION-009, MITIGATION-011
- Inherent likelihood: 3
- Inherent impact: 3
- Inherent risk: Moderate
- Inherent rationale: 3 x 3 = 9; realistic retention/interruption/workload prerequisites can degrade a bounded confidentiality/integrity/availability objective.
- Residual likelihood: 3
- Residual impact: 3
- Residual risk: Moderate
- Residual rationale: 3 x 3 = 9; owned cleanup, limited tmpfs and handled rollback do not establish erasure, crash durability or a complete work budget.
- Risk uncertainty: Retention requirements, actual data sensitivity, platform reset semantics and workload ceilings are open.
- Confidence: Medium
- Evidence IDs: TM-20260911-001-E0017, TM-20260911-001-E0024, TM-20260911-001-E0027, TM-20260911-001-E0029
- Status: Unresolved
- Alternatives and counter-evidence: Failed cleanup is surfaced and prior output is retained for recovery; keeping records can be intentional rather than a defect.
- Limitations: No particular disclosure, power-loss failure or resource-exhaustion exploit was observed.

### THREAT-019: Permitted outputs disclose readable private inputs
- Fact label: Inferred
- STRIDE: Information disclosure
- Scenario: Evaluated behavior carries readable input information through otherwise permitted artifact or log contents to a recipient not authorized for that input, even while namespace and integrity checks succeed.
- Preconditions: All three are required: sensitive input is readable by the evaluated behavior; information can be placed in an output accepted by the actual content checks; that output reaches an unauthorized recipient. None of sensitivity, content freedom or recipient mismatch is assumed established.
- Asset IDs: ASSET-006, ASSET-007, ASSET-008
- Objective IDs: OBJECTIVE-005, OBJECTIVE-006
- Actor IDs: ACTOR-004, ACTOR-005, ACTOR-006, ACTOR-007
- Surface IDs: ENTRY-007, ENTRY-008, ENTRY-010, ENTRY-011, BOUNDARY-005, BOUNDARY-006, BOUNDARY-007, BOUNDARY-008, FLOW-010, FLOW-011, FLOW-012, FLOW-013
- Existing control IDs: CONTROL-008, CONTROL-009, CONTROL-010, CONTROL-012, CONTROL-014
- Mitigation IDs: MITIGATION-005, MITIGATION-008, MITIGATION-010, MITIGATION-011, MITIGATION-013
- Inherent likelihood: 3
- Inherent impact: 3
- Inherent risk: Moderate
- Inherent rationale: 3 x 3 = 9 for the explicit conjunction; readable private data, permitted output content and later distribution form a plausible bounded confidentiality scenario.
- Residual likelihood: 3
- Residual impact: 3
- Residual risk: Moderate
- Residual rationale: 3 x 3 = 9; read-only, namespace and matching-hash controls do not establish authorized semantic disclosure. Private handling and the publication gate constrain dissemination but receive no credit for an already unauthorized-recipient branch.
- Risk uncertainty: OPEN-010 asks which input classes, output content freedoms/checks and recipient rights actually apply. Their answers could remove this branch or change likelihood/impact.
- Confidence: Medium
- Evidence IDs: TM-20260911-001-E0023, TM-20260911-001-E0024, TM-20260911-001-E0025, TM-20260911-001-E0027, TM-20260911-001-E0028, TM-20260911-001-E0045
- Status: Unresolved
- Alternatives and counter-evidence: Reads may be intentional, all recipients may already be entitled, and exact content comparisons may block a proposed carrier. If any prerequisite is false this branch does not succeed. No particular log/artifact was demonstrated to carry a secret.
- Limitations: Conditional flow analysis only, not an observed leak, free-form export guarantee, container escape or authorization to distribute private data.

## Attack trees and abuse cases

Inferred: these are conditional attack structures, not executed exploit
recipes. OR means any branch can satisfy the intermediate goal; AND means
all stated prerequisites are required. Markdown is normative; corresponding
DOT carries the same goal/branch IDs.

### ATTACK-001: Violate fixed subject isolation

Inferred: goal is unauthorized private/HS memory or context influence,
affecting OBJECTIVE-001/002. ACTOR-001/002 exploit a bad exposed mapping or
transition; ACTOR-003 supplies a privileged prerequisite where specified.
OR branches are policy/storage mutation (THREAT-001), mapping/composition
error (THREAT-002), event/transition confusion (THREAT-003/004), or privileged
trap/platform failure (THREAT-005/007). The stale-init branch is AND:
previous valid tree + failed reinit + unchecked reuse (THREAT-017); the fixed
caller blocks its last condition. Crossings are BOUNDARY-002/003/004/009.
Success requires actual forbidden influence, not an isolated diagnostic.
CONTROL-001/002/003/004/013 constrain separate branches; proof of all branches
is absent. TM-20260911-001-E0013, TM-20260911-001-E0014,
TM-20260911-001-E0015, TM-20260911-001-E0016,
TM-20260911-001-E0018.

### ATTACK-002: Obtain misleading positive evidence

Inferred: ACTOR-004/005 targets OBJECTIVE-004 by OR of artifact substitution
(THREAT-008), ignored contradictory trace classes (THREAT-012), or
self-consistent dishonest production (THREAT-013). Trace branch is AND:
required marker grammar remains satisfied + contradictory line is outside
rejection predicates + consumer overinterprets acceptance. Crossing is
BOUNDARY-006; CONTROL-007/009/010 detect narrower changes. Final success is
consumer reliance on an unsupported result, not a demonstrated target PASS.
Independent producer/exact-run provenance remains unknown.
TM-20260911-001-E0020, TM-20260911-001-E0025,
TM-20260911-001-E0026.

### ATTACK-003: Influence the host through evaluation

Inferred: ACTOR-004 requires malicious/untrusted source/dependency plus
ACTOR-005 invoking native evaluation under an incorrect sandbox expectation
(AND, THREAT-009). Other OR branches are malicious dependency construction
(THREAT-011), an ordinary retained-container crossing (THREAT-010), or
inappropriate documentation exposure/exception (THREAT-014). Another OR
branch is THREAT-019, with AND prerequisites of sensitive readable input,
information carried in output accepted by content checks, and delivery to
an unauthorized recipient. ACTOR-006/007 represent potential recipient or
decision roles for that branch, not presumed misconduct. Failed host
kernel/OCI enforcement remains THREAT-007; total budgets remain THREAT-018.
Boundaries are BOUNDARY-001/005/006/007/008, objectives
OBJECTIVE-004/005/006. Success is
unauthorized host/data effect; CONTROL-008 is downstream of native preflight
and cannot satisfy that branch's missing protection. No payload or escape
was executed. TM-20260911-001-E0021, TM-20260911-001-E0022,
TM-20260911-001-E0023, TM-20260911-001-E0027,
TM-20260911-001-E0025, TM-20260911-001-E0045.

### ATTACK-004: Misuse a decision or later lifecycle

Inferred: OR goals are false human attribution (THREAT-015), accidental
assurance inflation (THREAT-016), denied experiment progress (THREAT-006),
or inappropriate retained-state reuse/disposal (THREAT-018). False approval
requires AND of supplied plausible metadata and downstream belief in
unestablished human identity/authority. Actors ACTOR-001/002 supply the VS
non-progress branch; ACTOR-004/005/006/007 and conditional ACTOR-003 supply
the other stated branches across BOUNDARY-008/009; objectives are
OBJECTIVE-003/006/007. CONTROL-012/014 preserve recorded distinctions but
do not authenticate a deceiver. Retention and availability requirements
remain unknown. TM-20260911-001-E0017, TM-20260911-001-E0028,
TM-20260911-001-E0029.

## Existing controls

| Control ID | Label | Control | Threat IDs | Evidence IDs | Effectiveness | Confidence | Limitations |
| --- | --- | --- | --- | --- | --- | --- | --- |
| CONTROL-001 | Established | Bounded label initialization, seal and exact whole-rule default denial | THREAT-001, THREAT-002 | TM-20260911-001-E0013 | Rejects invalid ordinary API states | High | No hardware immutability or protection from privileged storage mutation |
| CONTROL-002 | Established | Policy/open/access checks, bounded mapping, aliases/private absence and shared asymmetry | THREAT-001, THREAT-002 | TM-20260911-001-E0014 | Narrows construction/permission errors | High | Trusted backing identity and platform semantics remain |
| CONTROL-003 | Established | Exact event/fault sequence, terminal failure and checked initialization returns | THREAT-003, THREAT-005, THREAT-006, THREAT-017 | TM-20260911-001-E0015, TM-20260911-001-E0018 | Rejects unexpected finite transitions | High | C origin check follows trap stores; no progress guarantee |
| CONTROL-004 | Established | GPR/frame/VS-state reset, VT policy, fences and root readback | THREAT-004, THREAT-005, THREAT-007 | TM-20260911-001-E0016 | Covers named architectural state in source | High | No optional-state, binary or microarchitectural proof |
| CONTROL-005 | Established | Volatile first-word observations and final phase/PC/sentinel checks | THREAT-003, THREAT-012 | TM-20260911-001-E0015, TM-20260911-001-E0014 | Final result has independent HS predicates | High | Selected words and finite fixture only; progress markers are weaker |
| CONTROL-006 | Established | Protected maintained graph, canonical forced outputs and constrained recursive inputs | THREAT-008, THREAT-009, THREAT-011 | TM-20260911-001-E0020 | Narrows ordinary caller/stale-output mistakes | High | No sandbox for replacement rules, malicious tools or host races |
| CONTROL-007 | Established | Process-status/run-count checks, timeout invocation and finite trace validation | THREAT-006, THREAT-007, THREAT-012, THREAT-013, THREAT-018 | TM-20260911-001-E0026 | Rejects explicit defined error classes | High | Not complete diagnostics, authenticity or total deadline |
| CONTROL-008 | Established | Requested retained-container mounts/network/proxy/capability/tmpfs restrictions | THREAT-009, THREAT-010, THREAT-018, THREAT-019 | TM-20260911-001-E0023 | Constrains ordinary paths under correct enforcement | High | Does not mediate native preflight, failed kernel/OCI, total budgets or semantic disclosure in allowed outputs |
| CONTROL-009 | Established | Private storage lock, captured image/provenance, fingerprints and transactional export | THREAT-008, THREAT-010, THREAT-011, THREAT-013, THREAT-018, THREAT-019 | TM-20260911-001-E0024 | Detects observed drift and supports handled rollback | High | No producer trust, source atomicity, power-loss or authorized-disclosure guarantee |
| CONTROL-010 | Established | Exact source/blob/type/hash, report/trace and selected local tool correspondence checks | THREAT-007, THREAT-008, THREAT-011, THREAT-012, THREAT-013, THREAT-016, THREAT-019 | TM-20260911-001-E0025 | Detects many accidental/unauthorized mismatches | High | No source-to-binary or disclosure proof; core/export namespaces differ |
| CONTROL-011 | Established | Confined static serving, loopback/default browser sandbox and child-bound readiness | THREAT-009, THREAT-014 | TM-20260911-001-E0027 | Narrows default exposure and wrong-listener acceptance | High | No semantic disclosure review, authenticated exception or host sandbox |
| CONTROL-012 | Established | Blocked gate plus exact byte/calendar/commit/index/topology checks | THREAT-015, THREAT-016, THREAT-019 | TM-20260911-001-E0028 | Rejects stale/invalid structural approval records | High | No authentication of human identity, approval or semantic disclosure entitlement |
| CONTROL-013 | Established | Static layout/linker/assertion guards and maintained entry-assurance integration | THREAT-002, THREAT-004, THREAT-005, THREAT-008 | TM-20260911-001-E0014, TM-20260911-001-E0019 | Constrains declared fixed image shape | High | Test source is not a successful run; no whole-C/binary proof |
| CONTROL-014 | Established | Explicit PoC/non-attestation/claim limits and non-retroactive review-provenance contract | THREAT-013, THREAT-014, THREAT-015, THREAT-016, THREAT-019 | TM-20260911-001-E0005, TM-20260911-001-E0011, TM-20260911-001-E0028 | Reduces accidental interpretation errors | Medium | Documentary control cannot prevent deliberate misrepresentation or establish recipient entitlement |

## Mitigation and verification plan

| Mitigation ID | Label | Mitigation | Threat IDs | Verification approach | Owner | Status | Evidence IDs |
| --- | --- | --- | --- | --- | --- | --- | --- |
| MITIGATION-001 | Proposed | Obtain an owner-produced exact-target evidence package with every attempted command/exit/tool/image and retained failures | THREAT-002, THREAT-003, THREAT-004, THREAT-005, THREAT-007, THREAT-008, THREAT-010, THREAT-011, THREAT-013, THREAT-016 | Independently compare exact source, binaries, disassembly, logs and environment; distinguish tests defined from run | Unknown; suggested target/evaluation owner | Open | TM-20260911-001-E0011, TM-20260911-001-E0019, TM-20260911-001-E0025 |
| MITIGATION-002 | Proposed | Strengthen compositional and negative coverage of labels, mapping identity, split-rule combinations and event/fault sequences | THREAT-001, THREAT-002, THREAT-003, THREAT-017 | Owner-reviewed properties plus bounded adversarial fixtures tied to exact source and results | Unknown; suggested runtime owner | Open | TM-20260911-001-E0013, TM-20260911-001-E0014, TM-20260911-001-E0018 |
| MITIGATION-003 | Proposed | Establish boot/trap/stack/platform assumptions and an explicit lifecycle boundary before broader deployment | THREAT-001, THREAT-004, THREAT-005, THREAT-007, THREAT-018 | Exact-image stack bounds, privileged-transition evidence and assumption-violation checks; new scope for extra harts/state | Unknown; suggested platform/runtime owner | Open | TM-20260911-001-E0016, TM-20260911-001-E0017 |
| MITIGATION-004 | Proposed | State direct-access versus information-flow/progress claims and check additional state only under an approved profile | THREAT-004, THREAT-006, THREAT-016 | Trace every claimed state/channel and liveness condition to evidence; do not infer erasure or noninterference | Unknown; suggested architecture owner | Open | TM-20260911-001-E0012, TM-20260911-001-E0019 |
| MITIGATION-005 | Proposed | If arbitrary untrusted evaluation is needed, establish a trusted external launcher boundary before any repository-owned native command | THREAT-009, THREAT-010, THREAT-014, THREAT-019 | Adversarial source/dependency tests from outside the evaluated tree; account for native preflight, readable inputs, permitted outputs and browser work | Unknown; suggested evaluator owner | Open; depends on explicit use-case decision | TM-20260911-001-E0021, TM-20260911-001-E0023 |
| MITIGATION-006 | Proposed | Pin and independently inspect the actual dependency/install closure and trusted build environment | THREAT-007, THREAT-008, THREAT-009, THREAT-011 | Record installed bytes/patches/configuration and reproducible correspondence where feasible; do not equate inventory with authenticity | Unknown; suggested build/dependency owner | Open | TM-20260911-001-E0022 |
| MITIGATION-007 | Proposed | Specify and test canonical positive/negative trace grammars, including conflicting metadata/diagnostics and terminal placement | THREAT-012, THREAT-013 | Mutation tests preserving required markers while adding every contradictory prefix; exact expected rejection results | Unknown; suggested evidence-tool owner | Open | TM-20260911-001-E0026 |
| MITIGATION-008 | Proposed | Define independent producer/source-to-image provenance and make verifier namespace/claim limits explicit | THREAT-007, THREAT-008, THREAT-011, THREAT-012, THREAT-013, THREAT-015, THREAT-019 | Trusted independent capture or comparison; distinguish confidentiality from integrity and never self-issue assurance | Unknown; suggested assurance owner | Open; depends on provenance requirements | TM-20260911-001-E0025, TM-20260911-001-E0028 |
| MITIGATION-009 | Proposed | Clarify non-loopback disclosure, browser exception and resource limits without claiming content approval | THREAT-014, THREAT-018 | Test default/opt-in behavior, current-source delivery boundaries and defined request/output budgets | Unknown; suggested documentation/evaluator owner | Open | TM-20260911-001-E0027 |
| MITIGATION-010 | Proposed | Keep authenticated human decisions and exact-output disclosure review separate from structural validation | THREAT-014, THREAT-015, THREAT-016, THREAT-019 | Responsible-human records and downstream recipient rights evaluated by their owners; agent leaves promotion fields blank | Unknown; responsible human required | Open | TM-20260911-001-E0028 |
| MITIGATION-011 | Proposed | Define retention, cleanup, interruption, concurrency and total workload budgets | THREAT-006, THREAT-008, THREAT-010, THREAT-014, THREAT-018, THREAT-019 | Owner-supplied requirements, recipient/retention controls, fault/recovery and resource evidence; no target execution by this engagement | Unknown; suggested operations owner | Open | TM-20260911-001-E0024, TM-20260911-001-E0029 |
| MITIGATION-012 | Proposed | Align API/fixture/diagram/historical-state wording with its actual supported call path and evidence | THREAT-016, THREAT-017 | Review failed-init postcondition, standalone versus maintained entry test, and stale state/provenance claims at exact revision | Unknown; suggested target documentation owner | Open | TM-20260911-001-E0005, TM-20260911-001-E0018, TM-20260911-001-E0019 |
| MITIGATION-013 | Proposed | Define readable-input classes, accepted output carriers, recipient entitlements and content/disclosure checks separately from hashes and namespace checks | THREAT-019 | Owner-reviewed flow matrix and benign canary tests through permitted logs/artifacts; verify actual content checks and recipient controls without using real private secrets | Unknown; suggested evaluator/disclosure owner | Open; depends on OPEN-010 | TM-20260911-001-E0023, TM-20260911-001-E0024, TM-20260911-001-E0025, TM-20260911-001-E0045 |

## Assumptions and non-goals

### ASSUMPTION-001: Fixed profile, not a general hypervisor
Established: source scope is one hart, two sequential VS subjects, fixed
resources/policy and no dynamic devices/DMA/interrupt/multicore service.
If this changes, mapping, lifecycle, state and availability arguments need a
new scope. Check source/configuration and actual invocation, not a product
analogy. TM-20260911-001-E0012, TM-20260911-001-E0017.

### ASSUMPTION-002: Required platform/tool trust is not correctness evidence
Unknown: exact firmware/emulator/ISA/tool implementation and initial state
correctly realize the intended transition and memory behavior. If false,
readbacks/logs may be self-consistent but wrong. Check primary semantics and
independent exact-platform evidence. TM-20260911-001-E0011,
TM-20260911-001-E0016, TM-20260911-001-E0025.

### ASSUMPTION-003: Trusted storage and valid caller composition
Established: HS owns pointers, state and backing identities; software seal
and map checks do not constrain arbitrary privileged writes. The fixed caller
honors initialization failure. If storage/caller trust fails, policy/root
claims fail. Check dataflow, exact callers and bounded corruption properties.
TM-20260911-001-E0013, TM-20260911-001-E0014,
TM-20260911-001-E0018.

### ASSUMPTION-004: Exact fixture and instruction representation
Established: recovery assumes four-byte labeled instructions; image layout
and first-word observations are deliberate fixed-fixture constraints.
Unknown: exact generated binary and compiler behavior at this commit.
Check image/disassembly/source correspondence without treating a test script
as a run. TM-20260911-001-E0015, TM-20260911-001-E0019.

### ASSUMPTION-005: Untrusted VS role is not an unrecorded replacement payload
Inferred: adversarial capability cases describe the intended mediation
boundary. They do not prove reachability in the unchanged cooperative fixture
or authorize a different payload snapshot. Check every case against actual
entries and report counterfactual prerequisites. TM-20260911-001-E0012,
TM-20260911-001-E0015.

### ASSUMPTION-006: Host native trust precedes retained-container confinement
Established: complete evaluation starts in repository-owned host code.
Unknown: whether a caller expects arbitrary-source isolation. If that
expectation is false, use remains a trusted developer workflow; if it is
required, current retained-container controls are insufficient for the whole
command. TM-20260911-001-E0021, TM-20260911-001-E0023.

### ASSUMPTION-007: Correspondence is not authenticity
Established: checked hashes/records bind specified bytes and fields.
Inferred: a producer controlling matching artifacts can still misrepresent
execution. Exact run provenance remains OPEN-005; tool/environment identity
remains OPEN-006. TM-20260911-001-E0025, TM-20260911-001-E0028.

### ASSUMPTION-008: Human gates and private distribution are not delegated
Established: this package and the frozen target gate grant no human decision.
If consumers treat an agent, metadata match or low score as acceptance,
OBJECTIVE-006 fails. Check separate authenticated human records; do not
synthesize them from chat. TM-20260911-001-E0001,
TM-20260911-001-E0028.

### ASSUMPTION-009: Retention, erasure and crash recovery are unresolved
Unknown: disposal/retention policy and future access to residual state.
No secure wipe, power-loss durability or total evaluator resource bound is
assumed. OPEN-007 answers could change THREAT-018 impact and required
controls. TM-20260911-001-E0017, TM-20260911-001-E0029.

### ASSUMPTION-010: Availability and information flow remain bounded
Established: allowed shared access is not an isolation violation.
Unknown: stronger noninterference or service-availability requirements.
No such guarantee is inferred from selected memory checks, a timeout call or
fail-closed abort. TM-20260911-001-E0012, TM-20260911-001-E0017,
TM-20260911-001-E0026.

### ASSUMPTION-011: Permitted-output disclosure requires separate authority
Unknown: readable sensitive-input classes, accepted content freedom and
recipient rights. A read-only mount or valid artifact hash does not answer
that authorization question. THREAT-019 requires all three missing
conditions; it is inapplicable if content checks prevent the carrier or all
recipients are entitled. OPEN-010 and MITIGATION-013 define how to check.
TM-20260911-001-E0023, TM-20260911-001-E0024,
TM-20260911-001-E0025, TM-20260911-001-E0045.

## Risk method

Likelihood and impact use integer values from 1 through 5. The risk band is:

- `Low`: product 1-4.
- `Moderate`: product 5-9.
- `High`: product 10-16.
- `Critical`: product 17-25.

Inherent risk is assessed before credited controls. Residual risk is assessed
after only evidence-supported controls. Risk acceptance is a responsible-human
decision and is never inferred from this model.

Proposed: likelihood meanings are 1 rare, 2 unlikely with substantial
prerequisites, 3 plausible, 4 likely for the stated capable actor, and 5
readily repeatable. Impact meanings are 1 negligible/local, 2 minor/bounded,
3 material/bounded, 4 major cross-boundary/persistent, and 5 critical/systemic.
These are ordinal analyst judgments for this PoC and host-support scope, not
measured frequencies, production criticality or verified absence of defects.
No mitigation proposed here reduces the current residual score.

| Threat | Inherent L x I = score / band | Residual L x I = score / band | Confidence |
| --- | --- | --- | --- |
| THREAT-001 | 2 x 4 = 8 / Moderate | 2 x 4 = 8 / Moderate | Medium |
| THREAT-002 | 3 x 4 = 12 / High | 2 x 4 = 8 / Moderate | Medium |
| THREAT-003 | 4 x 4 = 16 / High | 2 x 4 = 8 / Moderate | Medium |
| THREAT-004 | 4 x 4 = 16 / High | 2 x 4 = 8 / Moderate | Medium |
| THREAT-005 | 2 x 4 = 8 / Moderate | 2 x 4 = 8 / Moderate | Low |
| THREAT-006 | 4 x 2 = 8 / Moderate | 4 x 2 = 8 / Moderate | High |
| THREAT-007 | 3 x 4 = 12 / High | 3 x 4 = 12 / High | Low |
| THREAT-008 | 3 x 4 = 12 / High | 3 x 4 = 12 / High | Medium |
| THREAT-009 | 3 x 4 = 12 / High | 3 x 4 = 12 / High | High |
| THREAT-010 | 4 x 4 = 16 / High | 2 x 4 = 8 / Moderate | Medium |
| THREAT-011 | 3 x 4 = 12 / High | 3 x 4 = 12 / High | Medium |
| THREAT-012 | 4 x 3 = 12 / High | 3 x 3 = 9 / Moderate | Medium |
| THREAT-013 | 3 x 4 = 12 / High | 3 x 4 = 12 / High | High |
| THREAT-014 | 3 x 3 = 9 / Moderate | 3 x 3 = 9 / Moderate | Medium |
| THREAT-015 | 3 x 4 = 12 / High | 3 x 4 = 12 / High | Medium |
| THREAT-016 | 3 x 4 = 12 / High | 2 x 4 = 8 / Moderate | Medium |
| THREAT-017 | 3 x 4 = 12 / High | 1 x 4 = 4 / Low | High |
| THREAT-018 | 3 x 3 = 9 / Moderate | 3 x 3 = 9 / Moderate | Medium |
| THREAT-019 | 3 x 3 = 9 / Moderate | 3 x 3 = 9 / Moderate | Medium |

## Coverage matrix

Inferred: the matrix records consideration, not proven security. S/T/R/I/D/E
mean Spoofing, Tampering, Repudiation, Information disclosure, Denial of
service and Elevation of privilege. Where an inert memory/transition surface
has no separate identity or accountability protocol, S/R are traced to its
subject-binding or emitted-evidence surface rather than inventing one.

| Surface IDs | Surface type | STRIDE threat trace or explicit disposition | Evidence IDs | Limitation |
| --- | --- | --- | --- | --- |
| BOUNDARY-001, FLOW-001, ENTRY-001, ENTRY-002 | Source/build/dependency | S/T/E: THREAT-008/011; I: THREAT-009; R: THREAT-013; D: THREAT-018 | TM-20260911-001-E0020, TM-20260911-001-E0022 | Exact installed closure unknown |
| BOUNDARY-002, FLOW-002, ENTRY-003 | Platform/boot | S/T/I/D/E: THREAT-007; D also THREAT-006; R attributed through FLOW-009 and THREAT-013 | TM-20260911-001-E0017, TM-20260911-001-E0026 | Required privileged trust is explicit |
| BOUNDARY-004, FLOW-003 | Policy-to-mapping | T/I/E: THREAT-001/002/017; S through subject binding THREAT-003; D THREAT-006; R through report provenance THREAT-013 | TM-20260911-001-E0013, TM-20260911-001-E0014 | No runtime guest policy-input interface |
| FLOW-004, ENTRY-006 | Initial entry | S/T/E: THREAT-003/005; I: THREAT-004; D: THREAT-006; R via FLOW-009, THREAT-013 | TM-20260911-001-E0016 | Named reset state only |
| FLOW-005, FLOW-008, ENTRY-004 | Subject/private/shared access | T/I/E: THREAT-002; S subject-binding THREAT-003; D THREAT-006; R via evidence THREAT-012/013. Writer-to-reader shared flow explicitly permitted. | TM-20260911-001-E0012, TM-20260911-001-E0015 | No arbitrary noninterference |
| BOUNDARY-003, FLOW-006, ENTRY-005 | Trap inputs | S/T/E: THREAT-003/005; I THREAT-004; D THREAT-006; R evidence of events THREAT-012/013 | TM-20260911-001-E0015, TM-20260911-001-E0016 | No proved arbitrary-sequence coverage |
| FLOW-007 | Writer-to-reader switch | S/T/E: THREAT-003; I/T: THREAT-004; D THREAT-006; R via emitted switch/evidence THREAT-012/013 | TM-20260911-001-E0016 | No implicit extra state/service |
| BOUNDARY-006, FLOW-009, ENTRY-009 | Serial evidence | S/T/R: THREAT-012/013; D THREAT-006/018; I retained-output sensitivity THREAT-018; E only through misleading reliance, THREAT-016, not direct parser privilege | TM-20260911-001-E0015, TM-20260911-001-E0026 | Diagnostics are bounded source emissions, not a private-memory dump interface |
| BOUNDARY-005, FLOW-010, ENTRY-007 | Evaluator crossing | S/T/R THREAT-011/013; I/E THREAT-009/010; failed enforcement THREAT-007; D THREAT-018; I via permitted output THREAT-019 | TM-20260911-001-E0021, TM-20260911-001-E0023, TM-20260911-001-E0024 | THREAT-010's reduction applies only to ordinary correctly enforced paths; other branches keep separate ratings |
| FLOW-011, ENTRY-008 | Bundle/checker | S/T/R THREAT-013; D THREAT-018; I through permitted content THREAT-019; direct I/E path abuse constrained, additional trusted-source/tool failure THREAT-008/009/011 | TM-20260911-001-E0025, TM-20260911-001-E0045 | Namespace/integrity acceptance is not disclosure authorization |
| BOUNDARY-007, FLOW-012, ENTRY-010 | Docs/browser/HTTP | S/I/D THREAT-014; I permitted-input disclosure THREAT-019; T/R THREAT-013/016; E requires extra native/dependency failure THREAT-009/011 | TM-20260911-001-E0027, TM-20260911-001-E0045 | Explicit exposure/exception branches receive no default-derived reduction |
| BOUNDARY-008, FLOW-013, ENTRY-011 | Human decision | S/T/R/E THREAT-015/016; I THREAT-014/018/019; D THREAT-018. Waiting for real approval is intended gating. | TM-20260911-001-E0028, TM-20260911-001-E0045 | No approval, authentication or recipient entitlement inferred |
| BOUNDARY-009, FLOW-014, ENTRY-012 | Lifecycle | T/I/D THREAT-017/018; S/R stale provenance THREAT-013/015; E stale authority THREAT-017; D progress THREAT-006 | TM-20260911-001-E0018, TM-20260911-001-E0029 | Disposal/recovery requirements unknown |

| Entity ID | Threat trace or disposition | Evidence IDs |
| --- | --- | --- |
| OBJECTIVE-001 | THREAT-001/002/003/004/005/007/017 | TM-20260911-001-E0013, TM-20260911-001-E0016 |
| OBJECTIVE-002 | THREAT-001/002/004/007/017; intentional shared flow is allowed | TM-20260911-001-E0012, TM-20260911-001-E0014 |
| OBJECTIVE-003 | THREAT-003/005/006/012 | TM-20260911-001-E0015, TM-20260911-001-E0026 |
| OBJECTIVE-004 | THREAT-003/007/008/009/011/012/013/016 | TM-20260911-001-E0020, TM-20260911-001-E0025 |
| OBJECTIVE-005 | THREAT-007/008/009/010/011/014/018/019 | TM-20260911-001-E0021, TM-20260911-001-E0023, TM-20260911-001-E0045 |
| OBJECTIVE-006 | THREAT-013/014/015/016/019 | TM-20260911-001-E0028, TM-20260911-001-E0045 |
| OBJECTIVE-007 | THREAT-006/017/018 | TM-20260911-001-E0017, TM-20260911-001-E0029 |
| ASSET-001 | THREAT-001/002/005/007/017 | TM-20260911-001-E0013, TM-20260911-001-E0014 |
| ASSET-002 | THREAT-001/002/004/007/017 | TM-20260911-001-E0012 |
| ASSET-003 | THREAT-001/002/004/007/017 | TM-20260911-001-E0012 |
| ASSET-004 | THREAT-001/002; shared RW/R is intended, not a covert-flow proof | TM-20260911-001-E0012 |
| ASSET-005 | THREAT-003/004/005/006/007/018 | TM-20260911-001-E0015, TM-20260911-001-E0016 |
| ASSET-006 | THREAT-007/008/009/010/011/014/018/019 | TM-20260911-001-E0021, TM-20260911-001-E0023, TM-20260911-001-E0045 |
| ASSET-007 | THREAT-003/006/007/008/009/010/011/012/013/016/018/019 | TM-20260911-001-E0025, TM-20260911-001-E0026, TM-20260911-001-E0045 |
| ASSET-008 | THREAT-011/013/014/015/016/018/019 | TM-20260911-001-E0027, TM-20260911-001-E0028, TM-20260911-001-E0045 |
| ASSET-009 | THREAT-015/016 | TM-20260911-001-E0028 |
| ACTOR-001 | THREAT-002/003/004/006; no direct runtime policy API | TM-20260911-001-E0012, TM-20260911-001-E0015 |
| ACTOR-002 | THREAT-002/003/004/006; shared write remains denied by source | TM-20260911-001-E0012, TM-20260911-001-E0015 |
| ACTOR-003 | THREAT-001/002/004/005/006/007/017/018; privileged prerequisites explicit | TM-20260911-001-E0016, TM-20260911-001-E0017 |
| ACTOR-004 | THREAT-007/008/009/010/011/012/013/014/015/016/018/019 | TM-20260911-001-E0021, TM-20260911-001-E0022, TM-20260911-001-E0045 |
| ACTOR-005 | THREAT-008/009/010/012/013/014/015/018/019 | TM-20260911-001-E0020, TM-20260911-001-E0024, TM-20260911-001-E0045 |
| ACTOR-006 | THREAT-014/016/018/019; remote exposure and unauthorized-recipient conditions are explicit | TM-20260911-001-E0027, TM-20260911-001-E0045 |
| ACTOR-007 | THREAT-013/015/016/019; legitimate authority and recipient rights are not presumed | TM-20260911-001-E0028, TM-20260911-001-E0045 |

Established: local evidence spans all target implementation surfaces through
the two bounded specialist passes and admitted exact-object checks.
Selected large host fixture ranges and generated output were not exhaustively
read; no assertion of exhaustive line, input or runtime coverage follows.
Absent PRV/formal research, unadmitted AWB, unavailable PM queue and public
gaps are recorded rather than hidden. TM-20260911-001-E0010,
TM-20260911-001-E0011; `RUN-MANIFEST.md`, `open-questions.md`.

## Residual risk and unknowns

Inferred: current residual ratings remain conditional analysis, never
accepted risk. Native preflight (THREAT-009), required dependency trust
(THREAT-007/011), host substitution (THREAT-008), producer authenticity
(THREAT-013) and human attribution (THREAT-015) remain High at 12/25 for their
specified scenarios. None establishes that those prerequisites occurred.

Unknown: OPEN-005 exact-target execution, OPEN-006 deployed host/closure,
OPEN-007 lifecycle requirements and OPEN-010 disclosure classes/recipients
limit stronger claims. OPEN-002/008 constrain
contextual evidence, not the ability to describe fixed source. This model
makes no claim requiring those missing facts to be silently true.
Established: OPEN-003/004 are resolved at public-semantic depth, and OPEN-009
is resolved for the original specialist route. The initial review is complete
and its three corrections are closed by bounded independent review.
No earlier-run comparison informed this blind analysis; later comparison is
separate and non-normative. The newly explicit permitted-output
scenario is conditional Moderate 9/25, not a demonstrated leak.
TM-20260911-001-E0030, TM-20260911-001-E0031,
TM-20260911-001-E0033, TM-20260911-001-E0044,
TM-20260911-001-E0045, TM-20260911-001-E0046.

Established: Beryllium is accepted through R7; R8-H0 is a committed candidate,
not accepted; K3 hardware is `NOT RUN`. Those boundaries do not transfer
acceptance to Helium. Helium remains a review-and-test PoC, not formally
verified or hardware validated. This exact configuration has no CBMC harness;
selected properties in other revisions are not imported.
TM-20260911-001-E0004, TM-20260911-001-E0009,
TM-20260911-001-E0011.
