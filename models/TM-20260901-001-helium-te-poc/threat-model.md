# Formal threat model

Package ID: `TM-20260901-001`
Title: Helium TE PoC Initial Threat Model
Created: 2026-09-01
Status: `Complete`
Distribution: `private`
Latest model iteration: `MODEL-ITERATION-001`

## Executive summary

At the frozen clean `for-review` revision, Helium is a deliberately fixed,
single-hart Type Enforcement proof of concept. Direct source evidence
establishes a coherent path from sealed default-deny policy through derived
G-stage permissions, distinct writer and reader roots, exact subject-state
reset, a VMID-zero fenced root switch, and fail-closed event handling. These
controls materially reduce the modeled cross-private, shared-write,
translation-residue, and trap-confusion threats.

The strongest residual risks are outside or at the edge of that finite
mechanism: compromise or defect in trusted firmware, emulator, toolchain, or
hardware remains `Critical`; core mapping, translation-freshness, and
trap-confusion failures retain `High` impact because preventive checks do not
contain consequences after a bypass; evidence forgery, build substitution,
evaluator compromise, and the unresolved nested-HS-trap assumption also
remain `High`. Availability and unmodeled architectural or
microarchitectural channels remain `High` but are explicit non-goals. No
current exact-commit execution bundle, formal proof, CBMC result,
source-to-binary proof, or hardware validation is admitted. This is analysis,
not risk acceptance, review approval, release approval, or publication
approval.

## Fact labels

- `Established`: directly supported by admitted evidence.
- `Inferred`: reasoned from evidence with alternatives and limitations.
- `Proposed`: a candidate design, control, or mitigation.
- `Unknown`: evidence is missing or conflicting.

## System boundary and lifecycle

The modeled runtime boundary begins when OpenSBI transfers control to the
Helium image in HS-mode and ends when Helium requests SBI reset or shutdown.
Inside are the fixed configuration, TE mechanism and policy, G-stage
construction, runtime state machine, reset/entry/trap/payload assembly,
privileged platform boundary, and linker layout. The two synthetic VS
subjects are untrusted even though their payload is linked into the image.
OpenSBI, QEMU or future hardware, the compiler/linker output, and underlying
architectural behavior are trusted dependencies outside the target source
boundary.

The host assurance boundary includes the physical Makefile and CLI, compilers,
QEMU runner and trace validation, authority report, evidence
generator/verifier, rootless evaluator, dependency records, documentation
pipeline, retained review artifacts, and publication gate. These surfaces can
support or misrepresent the runtime claim but do not execute inside the target
TCB.

Lifecycle coverage is:

1. build and configuration selection;
2. image, report, documentation, and evidence generation;
3. OpenSBI handoff and HS initialization;
4. policy labeling, sealing, root construction, and pre-entry reconciliation;
5. writer entry, permitted operations, expected denial, and completion;
6. architectural-state reset and fenced writer-to-reader root transition;
7. reader entry, permitted operations, expected denials, and completion;
8. terminal PASS or fail-closed shutdown/reset request;
9. optional rootless evaluation, evidence verification, review, and
   publication preparation; and
10. scoped evaluator cleanup. Target-state zeroization at shutdown is
    `Unknown`.

Evidence: TM-20260901-001-E0001 through TM-20260901-001-E0022.

## Security objectives

| Objective ID | Label | Objective | Evidence IDs | Confidence | Limitations |
| --- | --- | --- | --- | --- | --- |
| OBJECTIVE-001 | Established | Preserve integrity of HS code, trusted stack, runtime state, TE labels/rules, and fixed policy. | TM-20260901-001-E0005, TM-20260901-001-E0006, TM-20260901-001-E0013 | High | Trusted HS code can write its own state; no memory-safety proof exists. |
| OBJECTIVE-002 | Established | Prevent each VS subject from reading or modifying the other subject's private stack or data. | TM-20260901-001-E0006 through TM-20260901-001-E0013 | High | Applies to fixed mapped memory accesses, not all architectural or side-channel state. |
| OBJECTIVE-003 | Established | Preserve the intended shared-page flow: writer read/write, reader read-only, and unchanged data after the denied reader store. | TM-20260901-001-E0006 through TM-20260901-001-E0012 | High | The writer-to-reader flow is intentional and is not noninterference. |
| OBJECTIVE-004 | Established | Ensure realized G-stage permissions never exceed the sealed TE decision and required exposure authority. | TM-20260901-001-E0005 through TM-20260901-001-E0008, TM-20260901-001-E0037 | High | Current source and tests are not a formal refinement or hardware observation. |
| OBJECTIVE-005 | Established | Enter each subject with the fixed GPR, stack, VS-CSR, and translation state and prevent stale writer authority at reader entry. | TM-20260901-001-E0009 through TM-20260901-001-E0011 | High | Optional extension CSRs and microarchitectural state are excluded. |
| OBJECTIVE-006 | Established | Accept only the exact finite event/fault sequence and preserve an unambiguous terminal PASS or FAIL result. | TM-20260901-001-E0010 through TM-20260901-001-E0013, TM-20260901-001-E0019 | High | Availability and alternate-emulator portability are not guaranteed. |
| OBJECTIVE-007 | Inferred | Preserve traceability and integrity from maintained source and tools to images, execution records, evidence bundles, evaluator exports, and generated documentation. | TM-20260901-001-E0015, TM-20260901-001-E0016, TM-20260901-001-E0018 through TM-20260901-001-E0021 | Medium | Correspondence does not establish authenticity against a malicious producer or host. |
| OBJECTIVE-008 | Established | Keep assurance claims and distribution within evidence and responsible-human authority boundaries. | TM-20260901-001-E0002, TM-20260901-001-E0017, TM-20260901-001-E0035, TM-20260901-001-E0045 | High | Structural gates do not authenticate review quality or grant promotion. |

## Protected assets

| Asset ID | Label | Asset | Required property | Owner or authority | Evidence IDs | Confidence |
| --- | --- | --- | --- | --- | --- | --- |
| ASSET-001 | Established | HS code, trusted stack, runtime state, and trap control | Integrity, control-flow integrity, isolation | ACTOR-003 | TM-20260901-001-E0003, TM-20260901-001-E0009, TM-20260901-001-E0013 | High |
| ASSET-002 | Established | TE labels, rules, seal state, and fixed policy | Integrity, authenticity, completeness | ACTOR-003 | TM-20260901-001-E0005 through TM-20260901-001-E0007 | High |
| ASSET-003 | Established | Writer private stack and data | Confidentiality and integrity from ACTOR-002 | ACTOR-003 mediates for ACTOR-001 | TM-20260901-001-E0004, TM-20260901-001-E0006, TM-20260901-001-E0010 | High |
| ASSET-004 | Established | Reader private stack and data | Confidentiality and integrity from ACTOR-001 | ACTOR-003 mediates for ACTOR-002 | TM-20260901-001-E0004, TM-20260901-001-E0006, TM-20260901-001-E0012 | High |
| ASSET-005 | Established | Common shared page | Writer R/W, reader R, reader write denial, freshness across switch | ACTOR-003 policy; ACTOR-001 may write | TM-20260901-001-E0006 through TM-20260901-001-E0012 | High |
| ASSET-006 | Established | G-stage roots, tables, PTEs, `HGATP`, and translation-cache state | Integrity, freshness, policy correspondence | ACTOR-003 | TM-20260901-001-E0007, TM-20260901-001-E0008, TM-20260901-001-E0011 | High |
| ASSET-007 | Established | GPRs, listed VS CSRs, trap frame, active subject, and phase | Confidentiality, integrity, freshness | ACTOR-003 | TM-20260901-001-E0010 through TM-20260901-001-E0012 | High |
| ASSET-008 | Established | Terminal serial result and ordered execution trace | Integrity, authenticity, uniqueness | ACTOR-003; checked by host tooling | TM-20260901-001-E0012, TM-20260901-001-E0019 | Medium |
| ASSET-009 | Inferred | Canonical build graph, tool identities, images, and derived artifacts | Integrity, provenance, reproducibility | ACTOR-006 with ACTOR-007 dependencies | TM-20260901-001-E0015, TM-20260901-001-E0018 through TM-20260901-001-E0020 | Medium |
| ASSET-010 | Inferred | Evidence bundles, evaluator provenance/exports, reviews, and generated documentation | Integrity, traceability, confidentiality where private | ACTOR-006, ACTOR-008, ACTOR-009 | TM-20260901-001-E0016, TM-20260901-001-E0020, TM-20260901-001-E0021 | Medium |
| ASSET-011 | Established | Publication gate and responsible-human decision record | Integrity, authenticity, non-repudiation | ACTOR-010 | TM-20260901-001-E0017, TM-20260901-001-E0045 | High |

## Actors and capabilities

| Actor ID | Label | Actor | Trust | Access and capabilities | Goals | Evidence IDs | Confidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ACTOR-001 | Established | Writer VS subject | Untrusted | Controls its GPRs, events, attempted addresses, private page, and permitted shared writes | Complete the fixed sequence or attempt unauthorized access/state influence | TM-20260901-001-E0003, TM-20260901-001-E0010 | High |
| ACTOR-002 | Established | Reader VS subject | Untrusted | Controls its GPRs, events, attempted addresses, private page, and permitted shared reads | Complete the fixed sequence or attempt private/shared writes | TM-20260901-001-E0003, TM-20260901-001-E0012 | High |
| ACTOR-003 | Established | Helium HS monitor and fixed policy | Trusted target TCB | Assigns/seals labels, builds roots, handles traps, switches state, and requests shutdown | Enforce the fixed policy and emit an exact result | TM-20260901-001-E0003 through TM-20260901-001-E0014 | High |
| ACTOR-004 | Established | OpenSBI and M-mode firmware | Trusted external | Selects HS entry, provides console and reset services, and can bypass HS isolation | Boot and service the fixed image | TM-20260901-001-E0003, TM-20260901-001-E0009, TM-20260901-001-E0014 | High |
| ACTOR-005 | Established | QEMU 10.2.2 or future hardware/ISA implementation | Trusted external | Implements H/G-stage translation, traps, fences, and `HTVAL` behavior | Execute the architecture | TM-20260901-001-E0012, TM-20260901-001-E0014 | High |
| ACTOR-006 | Inferred | Build and evidence operator/producer | Privileged and partially trusted | Selects host environment and invokes build, tests, evidence, docs, and publication tools | Produce reviewable images and evidence, or potentially substitute inputs | TM-20260901-001-E0015 through TM-20260901-001-E0021 | Medium |
| ACTOR-007 | Inferred | Toolchain, registry, repository, and package supplier | Trusted dependency | Supplies compilers, linkers, firmware, emulator, container layers, RPMs, and npm content | Supply expected dependencies; compromise could alter outputs | TM-20260901-001-E0014 through TM-20260901-001-E0016 | Medium |
| ACTOR-008 | Inferred | Host kernel, Podman, OCI runtime, and evaluator wrapper | Trusted external | Controls container isolation, mounts, namespaces, network, files, and export | Isolate untrusted evaluation; compromise can affect host or evidence | TM-20260901-001-E0016 | Medium |
| ACTOR-009 | Established | Automated or AI reviewer and evidence narrator | Untrusted evidence producer | Produces reports, model/run claims, and recommendations | Challenge the design or overstate provenance/assurance | TM-20260901-001-E0021 through TM-20260901-001-E0024 | High |
| ACTOR-010 | Established | Responsible human reviewer/release authority | Human authority outside agent control | May review exact source and complete separate promotion/release records | Decide review, release, or distribution; no decision is inferred | TM-20260901-001-E0002, TM-20260901-001-E0017, TM-20260901-001-E0045 | High |
| ACTOR-011 | Inferred | Compromised privileged host or supply-chain adversary | Adversarial | Can alter tools, runtime, files, outputs, evidence producer, or platform dependencies | Falsify execution, escape evaluation, disclose evidence, or bypass assumed isolation | TM-20260901-001-E0014 through TM-20260901-001-E0021, TM-20260901-001-E0043 | Medium |

## Trusted computing base and dependencies

**Target TCB.** Fixed public headers/configuration, TE mechanism, sole policy,
G-stage implementation, runtime C, entry/trap/payload assembly, privileged
platform boundary, and linker script. A defect or malicious change in this set
can violate OBJECTIVE-001 through OBJECTIVE-006. API sealing constrains normal
calls but does not protect policy memory from trusted C.

**Evidence TCB.** Make and shell, compilers/linkers/binutils, QEMU/OpenSBI,
Git and hashing, Node and documentation tooling, Playwright/Chromium, Podman,
the host kernel and OCI runtime, package repositories/registry, evaluator
wrapper, evidence producer, and responsible-human process. These are not
inside the target runtime but are load-bearing for OBJECTIVE-007 and
OBJECTIVE-008.

**Dependencies not established as correct.** Ratified architecture semantics,
compiler and binary correctness, emulator/firmware behavior, hardware,
package/repository integrity, evidence-producer honesty, and the human identity
behind a structural gate. Evidence: TM-20260901-001-E0014 through
TM-20260901-001-E0022 and TM-20260901-001-E0041 through
TM-20260901-001-E0046.

## Components and interfaces

| Component | Trust and role | Interfaces | Evidence IDs |
| --- | --- | --- | --- |
| Fixed configuration and layout | Target TCB | Domain/resource identifiers, GPAs, sentinels, linker symbols | TM-20260901-001-E0004 |
| TE mechanism and fixed policy | Target TCB | Label assignment/seal and exact authorization requests | TM-20260901-001-E0005, TM-20260901-001-E0006 |
| G-stage mechanism | Target TCB | Validated GPA/HPA/permission inputs and PTE inspection | TM-20260901-001-E0007, TM-20260901-001-E0008 |
| Runtime and platform boundary | Target TCB | Boot, root selection, fences, trap state, SBI calls | TM-20260901-001-E0009 through TM-20260901-001-E0012 |
| Writer and reader payloads | Untrusted | Fixed ECALLs, memory accesses, faults, and deliberate negative operations | TM-20260901-001-E0010, TM-20260901-001-E0012 |
| Build graph and CLI | Evidence TCB | Maintained Make goals, tool/profile controls, output paths | TM-20260901-001-E0015 |
| QEMU runner and trace validation | Evidence TCB | ELF, firmware/emulator selection, serial trace, result records | TM-20260901-001-E0019 |
| Evidence generator and verifier | Evidence TCB | Source/artifact namespaces, hashes, exact commit, selected tools | TM-20260901-001-E0020 |
| Rootless evaluator | Evidence TCB | Protected source/provenance, private image, writable work, exact export | TM-20260901-001-E0016 |
| Review and documentation pipeline | Evidence/process TCB | Review manifests, Markdown/DOT, generated HTML/SVG, loopback preview | TM-20260901-001-E0021 |
| Publication gate | Human/process boundary | Structural gate fields and separate H6/H7 decisions | TM-20260901-001-E0017 |

## Trust boundaries

| Boundary ID | Label | Boundary | Crossing parties | Enforcement | Evidence IDs | Confidence |
| --- | --- | --- | --- | --- | --- | --- |
| BOUNDARY-001 | Established | M-mode firmware to HS monitor | ACTOR-004 and ACTOR-003 | Fixed entry and SBI interface; firmware remains trusted | TM-20260901-001-E0003, TM-20260901-001-E0009 | High |
| BOUNDARY-002 | Established | HS monitor to writer VS subject | ACTOR-003 and ACTOR-001 | Writer root, fixed entry state, trap mediation | TM-20260901-001-E0009, TM-20260901-001-E0010 | High |
| BOUNDARY-003 | Established | HS monitor to reader VS subject | ACTOR-003 and ACTOR-002 | Reader root, fixed entry state, trap mediation | TM-20260901-001-E0011, TM-20260901-001-E0012 | High |
| BOUNDARY-004 | Established | Writer authority/state to reader authority/state | ACTOR-001, ACTOR-003, ACTOR-002 | Frame clear, VS reset, VVMA, root write, GVMA, private stack | TM-20260901-001-E0011 | High |
| BOUNDARY-005 | Inferred | Policy intent to realized G-stage authority | TE/policy and G-stage mechanism inside ACTOR-003 | Exposure gate, per-bit derivation, combined authorization, PTE reconciliation | TM-20260901-001-E0005 through TM-20260901-001-E0008 | High |
| BOUNDARY-006 | Inferred | Maintained source to produced image and run evidence | ACTOR-006, ACTOR-007, ACTOR-005 | Build ownership, tool records, trace validation | TM-20260901-001-E0015, TM-20260901-001-E0018, TM-20260901-001-E0019 | Medium |
| BOUNDARY-007 | Established | Host to rootless evaluator container | ACTOR-006, ACTOR-008, evaluated source | Read-only mounts/rootfs, zero-capability probes, private state, proxy removal | TM-20260901-001-E0016 | High |
| BOUNDARY-008 | Inferred | Evaluator/evidence output to host-retained artifact | ACTOR-008 and ACTOR-006 | Exact allowlist, fingerprints, namespace checks, rollback publication | TM-20260901-001-E0016, TM-20260901-001-E0020 | Medium |
| BOUNDARY-009 | Established | Automation and evidence to responsible-human decision | ACTOR-009, ACTOR-006, ACTOR-010 | Explicit claim limits, blocked structural gate, separate promotion record | TM-20260901-001-E0017, TM-20260901-001-E0021, TM-20260901-001-E0045 | High |

## Data and control flows

| Flow ID | Label | Source | Destination | Data or authority | Boundary IDs | Protection | Evidence IDs |
| --- | --- | --- | --- | --- | --- | --- | --- |
| FLOW-001 | Established | ACTOR-004 | ACTOR-003 | Initial control, hart identity, SBI services | BOUNDARY-001 | Fixed `_start`, hart-zero check, narrow SBI use | TM-20260901-001-E0009 |
| FLOW-002 | Established | Fixed configuration/policy | TE mechanism | Labels, rules, and seal state | BOUNDARY-005 | CONTROL-001 and CONTROL-002 | TM-20260901-001-E0005, TM-20260901-001-E0006 |
| FLOW-003 | Established | TE mechanism | G-stage mechanism | Exposure and R/W/X authority | BOUNDARY-005 | CONTROL-003 and CONTROL-004 | TM-20260901-001-E0007, TM-20260901-001-E0008 |
| FLOW-004 | Established | ACTOR-001 | ACTOR-003 | Writer ECALLs, faults, addresses, GPR/CSR state | BOUNDARY-002 | CONTROL-007 | TM-20260901-001-E0010, TM-20260901-001-E0012 |
| FLOW-005 | Established | ACTOR-001 | ASSET-003 | Writer-private reads/writes | BOUNDARY-002 | Writer root and TE policy | TM-20260901-001-E0006, TM-20260901-001-E0010 |
| FLOW-006 | Established | ACTOR-001 | ASSET-005 | Intended writer shared read/write | BOUNDARY-002 | Writer shared R/W leaf | TM-20260901-001-E0006, TM-20260901-001-E0010 |
| FLOW-007 | Established | ACTOR-003 | ACTOR-002 | Reader PC, stack, zero GPRs/VS CSRs, reader root | BOUNDARY-004, BOUNDARY-003 | CONTROL-005 and CONTROL-006 | TM-20260901-001-E0011 |
| FLOW-008 | Established | ACTOR-002 | ASSET-004 | Reader-private reads/writes | BOUNDARY-003 | Reader root and TE policy | TM-20260901-001-E0006, TM-20260901-001-E0012 |
| FLOW-009 | Established | ASSET-005 | ACTOR-002 | Writer-produced shared value read by reader | BOUNDARY-004, BOUNDARY-003 | Reader shared R-only leaf | TM-20260901-001-E0011, TM-20260901-001-E0012 |
| FLOW-010 | Established | ACTOR-002 | ASSET-005 and ASSET-003 | Denied shared store and cross-private load | BOUNDARY-003 | TE denial, R-only or absent leaf, exact fault validation | TM-20260901-001-E0012 |
| FLOW-011 | Inferred | Maintained source and ACTOR-007 | ASSET-009 | Build inputs, tools, image, map, disassembly | BOUNDARY-006 | CONTROL-008 and CONTROL-011 | TM-20260901-001-E0015, TM-20260901-001-E0018 |
| FLOW-012 | Inferred | ASSET-009 and ACTOR-005 | ASSET-008 | QEMU/OpenSBI execution and serial trace | BOUNDARY-006 | CONTROL-010 | TM-20260901-001-E0019 |
| FLOW-013 | Inferred | Source, images, traces, and tools | ASSET-010 | Manifests, hashes, semantic records, correspondence result | BOUNDARY-006, BOUNDARY-008 | CONTROL-012 | TM-20260901-001-E0020 |
| FLOW-014 | Established | Protected source/provenance | Rootless evaluator and host export | Build/test inputs, work products, exact allowed export | BOUNDARY-007, BOUNDARY-008 | CONTROL-013 | TM-20260901-001-E0016 |
| FLOW-015 | Inferred | Markdown, DOT, and retained reviews | Generated HTML/SVG and review material | Claims and navigable publication artifacts | BOUNDARY-008, BOUNDARY-009 | CONTROL-014 and CONTROL-015 | TM-20260901-001-E0021 |
| FLOW-016 | Established | ASSET-010 and ACTOR-009 | ACTOR-010 and ASSET-011 | Evidence, review claims, gate fields, distribution request | BOUNDARY-009 | CONTROL-016 and CONTROL-017 | TM-20260901-001-E0017, TM-20260901-001-E0045 |

## Entry points and attack surface

| Entry ID | Label | Entry point | Exposed to | Input or operation | Validation or mediation | Evidence IDs |
| --- | --- | --- | --- | --- | --- | --- |
| ENTRY-001 | Established | `_start` and `he_main` | ACTOR-004 | Firmware handoff, hart identity, image/layout state | BSS/stack setup, hart-zero and initialization checks | TM-20260901-001-E0009 |
| ENTRY-002 | Established | Writer VS entry | ACTOR-001 | Initial GPR/CSR/stack/root state and payload execution | CONTROL-005 and writer first-instruction assertions | TM-20260901-001-E0009, TM-20260901-001-E0010 |
| ENTRY-003 | Established | Direct HS trap vector and handler | ACTOR-001, ACTOR-002, ACTOR-005 | ECALL, page fault, virtual instruction, interrupt, trap state | CONTROL-007 exact origin/cause/phase/PC/address/policy/PTE checks | TM-20260901-001-E0010 through TM-20260901-001-E0012 |
| ENTRY-004 | Established | Writer completion and reader entry | ACTOR-001 and ACTOR-002 | Completion event and new subject state | CONTROL-006 then reader entry assertions | TM-20260901-001-E0011 |
| ENTRY-005 | Established | `./he` and maintained Make goals | ACTOR-006 | Build profile, supported tool controls, public targets | CONTROL-008 and CONTROL-011 | TM-20260901-001-E0015 |
| ENTRY-006 | Established | QEMU runner and trace validator | ACTOR-006, ACTOR-005 | ELF, firmware/emulator, run count, serial bytes | CONTROL-010 | TM-20260901-001-E0019 |
| ENTRY-007 | Established | Evidence generation and verification | ACTOR-006 | Commit, bundle, manifests, tools, artifact namespaces | CONTROL-012 | TM-20260901-001-E0020 |
| ENTRY-008 | Established | Rootless evaluator | ACTOR-006, ACTOR-008, untrusted tree | Container engine selection and evaluated source | CONTROL-013 | TM-20260901-001-E0016 |
| ENTRY-009 | Established | Documentation build/preview/server | ACTOR-006 and local consumer | Markdown/DOT, host/port, generated path request | CONTROL-014 and CONTROL-015 | TM-20260901-001-E0021 |
| ENTRY-010 | Established | Publication-gate checker | ACTOR-006, ACTOR-009, ACTOR-010 | Gate fields, reviewed commit, repository state | CONTROL-016 and CONTROL-017 | TM-20260901-001-E0017 |

## Threat catalogue

Each threat record must include its fact label, STRIDE category, concrete
scenario and preconditions, linked assets/objectives/actors/surfaces,
controls, mitigations, inherent and residual likelihood/impact/risk with
rationale, uncertainty, confidence, evidence, status, alternatives, and
limitations.

### THREAT-001: Trusted policy or TE state is altered or malformed

- Fact label: Inferred
- STRIDE: Tampering
- Scenario: Defective or compromised HS code changes labels, rules, seal state, or authorization inputs so unauthorized mapping authority is derived.
- Preconditions: ACTOR-003 or its build inputs are defective or malicious; API-level validation is bypassed or fed a coherent malicious policy.
- Asset IDs: ASSET-001, ASSET-002, ASSET-006
- Objective IDs: OBJECTIVE-001, OBJECTIVE-004
- Actor IDs: ACTOR-003, ACTOR-006, ACTOR-011
- Surface IDs: BOUNDARY-005, FLOW-002, FLOW-003, ENTRY-001
- Existing control IDs: CONTROL-001, CONTROL-002, CONTROL-003, CONTROL-008
- Mitigation IDs: MITIGATION-001, MITIGATION-005, MITIGATION-009
- Inherent likelihood: 3
- Inherent impact: 5
- Inherent risk: High
- Inherent rationale: Trusted policy and mechanism state directly determine every mapping, and an integrity failure can violate all subject isolation.
- Residual likelihood: 2
- Residual impact: 5
- Residual risk: High
- Residual rationale: Sealing, complete-request checks, and one fixed policy reduce malformed-state paths but do not constrain malicious trusted C or a compromised build. Unexecuted verification sources receive no risk-reduction credit.
- Risk uncertainty: No memory-safety proof, formal refinement, or independently authenticated current image exists.
- Confidence: Medium
- Evidence IDs: TM-20260901-001-E0005 through TM-20260901-001-E0008, TM-20260901-001-E0014, TM-20260901-001-E0037
- Status: Partially mitigated
- Alternatives and counter-evidence: The tiny static policy reduces complexity and there is no runtime policy input.
- Limitations: This threat is primarily a trusted-component integrity failure, not a demonstrated VS exploit.

### THREAT-002: Cross-private or overpermissive G-stage mapping

- Fact label: Inferred
- STRIDE: Elevation of privilege and information disclosure
- Scenario: A private page becomes present in the wrong root or a shared/private leaf gains permissions exceeding sealed policy, allowing unauthorized read or write.
- Preconditions: Root construction, backing selection, permission derivation, or PTE encoding diverges from policy.
- Asset IDs: ASSET-003 through ASSET-006
- Objective IDs: OBJECTIVE-002, OBJECTIVE-003, OBJECTIVE-004
- Actor IDs: ACTOR-001, ACTOR-002, ACTOR-003
- Surface IDs: BOUNDARY-002, BOUNDARY-003, BOUNDARY-005, FLOW-003, FLOW-005, FLOW-006, FLOW-008 through FLOW-010
- Existing control IDs: CONTROL-001 through CONTROL-004
- Mitigation IDs: MITIGATION-001, MITIGATION-004, MITIGATION-009
- Inherent likelihood: 4
- Inherent impact: 5
- Inherent risk: Critical
- Inherent rationale: A single wrong leaf can directly defeat the fixed memory-isolation claim.
- Residual likelihood: 2
- Residual impact: 5
- Residual risk: High
- Residual rationale: Fixed resources, default deny, exposure gating, per-bit and combined authorization, root/backing checks, PTE reconciliation, and absent private leaves reduce likelihood. No control limits consequences after an unauthorized leaf succeeds.
- Risk uncertainty: No current exact-commit run, formal proof, binary correspondence proof, or hardware observation is admitted.
- Confidence: High
- Evidence IDs: TM-20260901-001-E0004 through TM-20260901-001-E0008, TM-20260901-001-E0018, TM-20260901-001-E0037
- Status: Partially mitigated
- Alternatives and counter-evidence: A trusted malicious monitor can still intentionally install any mapping.
- Limitations: Risk is for the fixed six-resource profile only.

### THREAT-003: Stale writer translation survives the reader switch

- Fact label: Inferred
- STRIDE: Tampering
- Scenario: Because both roots use VMID zero, a stale writer translation preserves writable shared authority or another writer mapping after the reader root is selected.
- Preconditions: Required root-write and global-fence semantics are absent, reordered, defective, or implemented incorrectly by the platform.
- Asset IDs: ASSET-005, ASSET-006, ASSET-007
- Objective IDs: OBJECTIVE-003, OBJECTIVE-004, OBJECTIVE-005
- Actor IDs: ACTOR-001, ACTOR-002, ACTOR-003, ACTOR-005
- Surface IDs: BOUNDARY-004, BOUNDARY-005, FLOW-007, FLOW-009, ENTRY-004
- Existing control IDs: CONTROL-004, CONTROL-006
- Mitigation IDs: MITIGATION-001, MITIGATION-004, MITIGATION-009
- Inherent likelihood: 4
- Inherent impact: 5
- Inherent risk: Critical
- Inherent rationale: The reader's denied shared write directly distinguishes the two VMID-zero roots.
- Residual likelihood: 2
- Residual impact: 5
- Residual risk: High
- Residual rationale: Current source orders VS reset/VVMA, reader `HGATP`, and global GVMA before reader entry, reducing likelihood. No control contains the consequence if stale writable authority survives.
- Risk uncertainty: Public normative specification research was unavailable and no alternate emulator or hardware result exists.
- Confidence: Medium
- Evidence IDs: TM-20260901-001-E0008, TM-20260901-001-E0011, TM-20260901-001-E0012, TM-20260901-001-E0018, TM-20260901-001-E0019, TM-20260901-001-E0046
- Status: Partially mitigated
- Alternatives and counter-evidence: QEMU observations are reported historically, but no exact current bundle was admitted.
- Limitations: Multicore remote invalidation and reuse are outside the target.

### THREAT-004: Writer architectural or microarchitectural residue reaches reader

- Fact label: Inferred
- STRIDE: Information disclosure
- Scenario: Writer-controlled state survives the transition and becomes visible to the reader despite private-page separation.
- Preconditions: A GPR, listed or optional CSR, stack/trap-frame field, shared state, or microarchitectural channel is not reset or intentionally shared.
- Asset IDs: ASSET-003, ASSET-004, ASSET-007
- Objective IDs: OBJECTIVE-002, OBJECTIVE-005
- Actor IDs: ACTOR-001, ACTOR-002, ACTOR-003
- Surface IDs: BOUNDARY-002 through BOUNDARY-004, FLOW-004, FLOW-007, ENTRY-002 through ENTRY-004
- Existing control IDs: CONTROL-005, CONTROL-006
- Mitigation IDs: MITIGATION-001, MITIGATION-003, MITIGATION-009
- Inherent likelihood: 4
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: Earlier reviewed revisions retained GPR/CSR state, demonstrating a concrete channel class.
- Residual likelihood: 2
- Residual impact: 3
- Residual risk: Moderate
- Residual rationale: Current source clears non-stack GPRs, clears the trap frame, resets listed VS CSRs, and seeds/checks representative state, but optional and microarchitectural state remain excluded.
- Risk uncertainty: No exhaustive state inventory or noninterference proof exists.
- Confidence: Medium
- Evidence IDs: TM-20260901-001-E0009 through TM-20260901-001-E0011, TM-20260901-001-E0018, TM-20260901-001-E0023, TM-20260901-001-E0024
- Status: Partially mitigated
- Alternatives and counter-evidence: The fixed claim concerns tested memory accesses, not complete architectural-state confidentiality.
- Limitations: The intentional shared page is not a violation.

### THREAT-005: Event, fault, or address confusion advances the wrong phase

- Fact label: Inferred
- STRIDE: Spoofing and elevation of privilege
- Scenario: A subject forges an ECALL, cause, PC, address, phase, or result marker so the monitor accepts a denial or completion that did not occur as intended.
- Preconditions: Any identity, origin, phase, PC, GVA/GPA, TE, PTE, backing, or sentinel check is incomplete, stale, or bypassed.
- Asset IDs: ASSET-001, ASSET-006 through ASSET-008
- Objective IDs: OBJECTIVE-001, OBJECTIVE-004 through OBJECTIVE-006
- Actor IDs: ACTOR-001, ACTOR-002, ACTOR-003, ACTOR-005
- Surface IDs: BOUNDARY-001 through BOUNDARY-004, FLOW-004, FLOW-007, FLOW-010, ENTRY-001 through ENTRY-004
- Existing control IDs: CONTROL-005 through CONTROL-008
- Mitigation IDs: MITIGATION-001, MITIGATION-004, MITIGATION-009
- Inherent likelihood: 4
- Inherent impact: 5
- Inherent risk: Critical
- Inherent rationale: The monitor's security result is an exact finite state machine driven by untrusted trap state.
- Residual likelihood: 2
- Residual impact: 5
- Residual risk: High
- Residual rationale: Current source validates a conjunction of origin, active subject, phase, cause, PC, reconstructed address, live TE/PTE state, and sentinels, reducing likelihood; unexpected states terminate. No control contains the consequence after a falsely accepted transition succeeds.
- Risk uncertainty: Strict `HTVAL` behavior and platform trap semantics are assumed.
- Confidence: High
- Evidence IDs: TM-20260901-001-E0010 through TM-20260901-001-E0012, TM-20260901-001-E0018, TM-20260901-001-E0019
- Status: Partially mitigated
- Alternatives and counter-evidence: Terminal failure may reject valid execution on another conforming platform rather than grant authority.
- Limitations: Exact four-byte recovery is limited to known fixed instructions.

### THREAT-006: Nested HS trap corrupts the trusted stack transition

- Fact label: Inferred
- STRIDE: Elevation of privilege
- Scenario: A nested HS trap occurs while the direct trap prologue relies on `SSCRATCH` and guest-associated state, causing trusted stack or control-flow corruption.
- Preconditions: A synchronous HS fault or other nesting source is reachable during the vulnerable prologue or handler despite disabled interrupts and the fixed code path.
- Asset IDs: ASSET-001, ASSET-007
- Objective IDs: OBJECTIVE-001, OBJECTIVE-005
- Actor IDs: ACTOR-001, ACTOR-002, ACTOR-003, ACTOR-005
- Surface IDs: BOUNDARY-002 through BOUNDARY-004, FLOW-004, FLOW-007, ENTRY-003, ENTRY-004
- Existing control IDs: CONTROL-007
- Mitigation IDs: MITIGATION-002, MITIGATION-009
- Inherent likelihood: 2
- Inherent impact: 5
- Inherent risk: High
- Inherent rationale: A reachable privileged nested fault could compromise the monitor, but no trigger is established in the fixed profile.
- Residual likelihood: 2
- Residual impact: 5
- Residual risk: High
- Residual rationale: The current design relies on a documented non-nesting assumption rather than an evidence-supported nested-fault control.
- Risk uncertainty: Reachability and exploitability are `Unknown`.
- Confidence: Low
- Evidence IDs: TM-20260901-001-E0014, TM-20260901-001-E0023 through TM-20260901-001-E0025
- Status: Open
- Alternatives and counter-evidence: One hart, disabled interrupts, validated inputs, and terminal failure may make nesting unreachable.
- Limitations: This is a high-impact uncertainty, not a confirmed vulnerability.

### THREAT-007: Subject or platform causes terminal denial of service

- Fact label: Inferred
- STRIDE: Denial of service
- Scenario: A subject spins, emits an unexpected operation, or relies on portability differences such as zero `HTVAL`, causing terminal failure or indefinite execution without completing the scenario.
- Preconditions: Adversarial payload behavior, alternate platform semantics, or a firmware reset call that returns.
- Asset IDs: ASSET-008
- Objective IDs: OBJECTIVE-006
- Actor IDs: ACTOR-001, ACTOR-002, ACTOR-004, ACTOR-005
- Surface IDs: BOUNDARY-001 through BOUNDARY-003, FLOW-004, FLOW-010, ENTRY-002, ENTRY-003
- Existing control IDs: CONTROL-007, CONTROL-017
- Mitigation IDs: MITIGATION-004
- Inherent likelihood: 5
- Inherent impact: 3
- Inherent risk: High
- Inherent rationale: An adversarial synthetic subject can deliberately avoid the expected sequence and no timer or scheduler forces progress.
- Residual likelihood: 5
- Residual impact: 3
- Residual risk: High
- Residual rationale: Fail-closed termination preserves authorization but intentionally does not provide availability.
- Risk uncertainty: Operational impact outside the PoC is not modeled.
- Confidence: High
- Evidence IDs: TM-20260901-001-E0012, TM-20260901-001-E0014, TM-20260901-001-E0019
- Status: Out of scope
- Alternatives and counter-evidence: Deterministic termination is preferable to ambiguous continuation for the fixed security experiment.
- Limitations: No production availability objective exists.

### THREAT-008: Build or tool substitution produces an unreviewed image

- Fact label: Inferred
- STRIDE: Tampering
- Scenario: Caller inputs, alternate rules, compromised tools, filesystem races, or dependency substitution produce an image or artifact that differs from reviewed source and policy.
- Preconditions: ACTOR-006, ACTOR-007, or ACTOR-011 controls a path outside maintained graph checks or compromises a trusted tool.
- Asset IDs: ASSET-002, ASSET-006, ASSET-009
- Objective IDs: OBJECTIVE-001, OBJECTIVE-004, OBJECTIVE-007
- Actor IDs: ACTOR-006, ACTOR-007, ACTOR-011
- Surface IDs: BOUNDARY-006, FLOW-011, ENTRY-005
- Existing control IDs: CONTROL-008, CONTROL-011, CONTROL-012
- Mitigation IDs: MITIGATION-001, MITIGATION-005, MITIGATION-009
- Inherent likelihood: 4
- Inherent impact: 5
- Inherent risk: Critical
- Inherent rationale: A substituted image can preserve expected source while bypassing every runtime control.
- Residual likelihood: 2
- Residual impact: 5
- Residual risk: High
- Residual rationale: The physical Makefile owns canonical inputs and the verifier binds many exact artifacts, but the toolchain, host, alternate rules, and producer remain trusted.
- Risk uncertainty: No independently acquired exact current image or source-to-binary proof exists.
- Confidence: Medium
- Evidence IDs: TM-20260901-001-E0014, TM-20260901-001-E0015, TM-20260901-001-E0018, TM-20260901-001-E0020
- Status: Partially mitigated
- Alternatives and counter-evidence: The static graph and dual-toolchain strategy reduce accidental divergence.
- Limitations: The model does not claim to sandbox arbitrary GNU Make code.

### THREAT-009: Self-consistent evidence or review provenance is forged

- Fact label: Inferred
- STRIDE: Spoofing, tampering, and repudiation
- Scenario: A malicious producer creates mutually consistent source manifests, artifacts, traces, tool records, review identities, and reports that falsely claim a successful or independent evaluation.
- Preconditions: The producer or host controls acquisition and all evidence-generation inputs.
- Asset IDs: ASSET-008 through ASSET-011
- Objective IDs: OBJECTIVE-006 through OBJECTIVE-008
- Actor IDs: ACTOR-006 through ACTOR-009, ACTOR-011
- Surface IDs: BOUNDARY-006, BOUNDARY-008, BOUNDARY-009, FLOW-012, FLOW-013, FLOW-015, FLOW-016, ENTRY-006, ENTRY-007
- Existing control IDs: CONTROL-012 through CONTROL-017
- Mitigation IDs: MITIGATION-001, MITIGATION-005, MITIGATION-006
- Inherent likelihood: 4
- Inherent impact: 5
- Inherent risk: Critical
- Inherent rationale: Assurance and publication decisions may rely on the resulting evidence even when runtime controls are unchanged.
- Residual likelihood: 3
- Residual impact: 5
- Residual risk: High
- Residual rationale: Exact namespace, hash, tool, trace, review-manifest, and human-gate checks improve consistency and traceability but do not establish independent acquisition or producer honesty.
- Risk uncertainty: No external trust root, signature, or attested acquisition path is established.
- Confidence: High
- Evidence IDs: TM-20260901-001-E0017, TM-20260901-001-E0019 through TM-20260901-001-E0023, TM-20260901-001-E0040, TM-20260901-001-E0045
- Status: Partially mitigated
- Alternatives and counter-evidence: A responsible human may independently reproduce or inspect evidence outside this package, but no such record is admitted.
- Limitations: This model does not allege that existing evidence was forged.

### THREAT-010: Evaluated content or container stack alters host, source, or export

- Fact label: Inferred
- STRIDE: Tampering and elevation of privilege
- Scenario: Untrusted evaluated content writes the checkout or `.git`, reaches hidden host content, inherits credentials/network, escapes the container, mutates provenance, or substitutes exported results.
- Preconditions: A mount, capability, runtime, kernel, proxy, path, or publication control fails or a trusted evaluator component is compromised.
- Asset IDs: ASSET-009, ASSET-010
- Objective IDs: OBJECTIVE-007
- Actor IDs: ACTOR-006 through ACTOR-008, ACTOR-011
- Surface IDs: BOUNDARY-007, BOUNDARY-008, FLOW-014, FLOW-015, ENTRY-008, ENTRY-009
- Existing control IDs: CONTROL-013, CONTROL-015
- Mitigation IDs: MITIGATION-001, MITIGATION-005
- Inherent likelihood: 3
- Inherent impact: 5
- Inherent risk: High
- Inherent rationale: The evaluator intentionally processes an untrusted tree with a high-privilege host substrate.
- Residual likelihood: 2
- Residual impact: 5
- Residual risk: High
- Residual rationale: Read-only source/provenance/rootfs, hidden tmpfs, zero capabilities, proxy removal, captured image ID, exact export, fingerprints, and rollback reduce direct paths but retain host/kernel/runtime trust.
- Risk uncertainty: No current run or independent container-escape assessment is admitted.
- Confidence: Medium
- Evidence IDs: TM-20260901-001-E0016, TM-20260901-001-E0020, TM-20260901-001-E0024
- Status: Partially mitigated
- Alternatives and counter-evidence: The fixed implementation records extensive negative probes and historical passes.
- Limitations: Host compromise remains outside the evaluator's security claim.

### THREAT-011: Historical or automated analysis is presented as stronger assurance

- Fact label: Inferred
- STRIDE: Repudiation
- Scenario: Older AI reviews, historical test claims, successor CBMC results, Beryllium acceptance, or design prompts are represented as current independent verification, responsible-human review, or adopted architecture.
- Preconditions: Revision, provenance, fact labels, and claim limits are omitted or misunderstood.
- Asset IDs: ASSET-010, ASSET-011
- Objective IDs: OBJECTIVE-007, OBJECTIVE-008
- Actor IDs: ACTOR-006, ACTOR-009, ACTOR-010
- Surface IDs: BOUNDARY-009, FLOW-015, FLOW-016, ENTRY-009, ENTRY-010
- Existing control IDs: CONTROL-014, CONTROL-016, CONTROL-017
- Mitigation IDs: MITIGATION-005, MITIGATION-006, MITIGATION-008
- Inherent likelihood: 4
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: The repository contains many detailed reviews, historical PASS claims, and later formal-work records that can appear authoritative without exact boundaries.
- Residual likelihood: 2
- Residual impact: 4
- Residual risk: Moderate
- Residual rationale: Current records label provenance, revisions, stale findings, incomplete H6/H7, no inherited CBMC, and blocked release status.
- Risk uncertainty: Human interpretation and downstream excerpting are not technically controlled.
- Confidence: High
- Evidence IDs: TM-20260901-001-E0002, TM-20260901-001-E0017, TM-20260901-001-E0022 through TM-20260901-001-E0036, TM-20260901-001-E0041, TM-20260901-001-E0044
- Status: Partially mitigated
- Alternatives and counter-evidence: The maintained documentation is unusually explicit about its limits.
- Limitations: No responsible-human review conclusion is inferred.

### THREAT-012: Private evidence is disclosed or promoted without authority

- Fact label: Inferred
- STRIDE: Information disclosure and repudiation
- Scenario: Private target source observations, historical prompts, internal research, or package evidence are included in a public candidate or publication without redistribution clearance and a valid human record.
- Preconditions: The private default, sensitivity metadata, checklist, or promotion gate is bypassed or treated as optional.
- Asset IDs: ASSET-010, ASSET-011
- Objective IDs: OBJECTIVE-008
- Actor IDs: ACTOR-006, ACTOR-009, ACTOR-010, ACTOR-011
- Surface IDs: BOUNDARY-008, BOUNDARY-009, FLOW-015, FLOW-016, ENTRY-009, ENTRY-010
- Existing control IDs: CONTROL-014 through CONTROL-017
- Mitigation IDs: MITIGATION-006, MITIGATION-007
- Inherent likelihood: 3
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: The intended post-analysis distribution is public-candidate while many necessary sources are private or uncleared.
- Residual likelihood: 2
- Residual impact: 4
- Residual risk: Moderate
- Residual rationale: This package remains private, marks redistribution status, and has no human promotion record.
- Risk uncertainty: Future derivative scope and clearance are unknown.
- Confidence: High
- Evidence IDs: TM-20260901-001-E0017, TM-20260901-001-E0027 through TM-20260901-001-E0032, TM-20260901-001-E0035, TM-20260901-001-E0036, TM-20260901-001-E0042, TM-20260901-001-E0045
- Status: Open
- Alternatives and counter-evidence: A traceability-preserving public derivative may omit or abstract private evidence after human review.
- Limitations: `public-candidate` would still not be publication or release approval.

### THREAT-013: Trusted firmware, emulator, toolchain, or hardware subverts the result

- Fact label: Inferred
- STRIDE: Spoofing and elevation of privilege
- Scenario: A compromised or defective dependency changes execution, translation, trap, fence, firmware, compiler, or image behavior while producing plausible results.
- Preconditions: ACTOR-004, ACTOR-005, ACTOR-007, ACTOR-008, or ACTOR-011 violates a load-bearing assumption.
- Asset IDs: ASSET-001 through ASSET-009
- Objective IDs: OBJECTIVE-001 through OBJECTIVE-007
- Actor IDs: ACTOR-004, ACTOR-005, ACTOR-007, ACTOR-008, ACTOR-011
- Surface IDs: BOUNDARY-001, BOUNDARY-006, BOUNDARY-007, FLOW-001, FLOW-011, FLOW-012, ENTRY-001, ENTRY-005, ENTRY-006
- Existing control IDs: CONTROL-008, CONTROL-011, CONTROL-012, CONTROL-013, CONTROL-017
- Mitigation IDs: MITIGATION-001, MITIGATION-004, MITIGATION-005, MITIGATION-009
- Inherent likelihood: 4
- Inherent impact: 5
- Inherent risk: Critical
- Inherent rationale: These dependencies can bypass or falsify all target-source controls and evidence.
- Residual likelihood: 4
- Residual impact: 5
- Residual risk: Critical
- Residual rationale: The current model explicitly trusts these layers; identity and correspondence records do not prove their correctness or integrity.
- Risk uncertainty: No independent hardware, formal ISA-to-source, compiler, or attestation evidence is admitted.
- Confidence: Medium
- Evidence IDs: TM-20260901-001-E0014 through TM-20260901-001-E0022, TM-20260901-001-E0041, TM-20260901-001-E0043, TM-20260901-001-E0044, TM-20260901-001-E0046
- Status: Open
- Alternatives and counter-evidence: Dual toolchains, exact versions, hashes, and retained provenance reduce accidental drift.
- Limitations: This residual rating is not a claim that a dependency is compromised.

### THREAT-014: Unmodeled state or channels defeat broader confidentiality claims

- Fact label: Inferred
- STRIDE: Information disclosure
- Scenario: Intentional shared memory, optional CSRs, microarchitectural/timing state, firmware/emulator state, or uncleared shutdown data carries information outside the tested private-page policy.
- Preconditions: A consumer generalizes fixed memory-access results to noninterference, arbitrary information-flow control, or post-shutdown confidentiality.
- Asset IDs: ASSET-003 through ASSET-005, ASSET-007
- Objective IDs: OBJECTIVE-002, OBJECTIVE-003
- Actor IDs: ACTOR-001, ACTOR-002, ACTOR-005, ACTOR-011
- Surface IDs: BOUNDARY-002 through BOUNDARY-004, FLOW-005, FLOW-006, FLOW-008, FLOW-009, ENTRY-002, ENTRY-004
- Existing control IDs: CONTROL-005, CONTROL-006, CONTROL-017
- Mitigation IDs: MITIGATION-003, MITIGATION-004, MITIGATION-008, MITIGATION-009
- Inherent likelihood: 3
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: The design intentionally permits one channel and explicitly omits complete state and side-channel control.
- Residual likelihood: 3
- Residual impact: 4
- Residual risk: High
- Residual rationale: Explicit claim limits prevent overstatement but do not technically close those channels.
- Risk uncertainty: No complete state inventory, zeroization design, or noninterference analysis exists.
- Confidence: Medium
- Evidence IDs: TM-20260901-001-E0011 through TM-20260901-001-E0014, TM-20260901-001-E0028 through TM-20260901-001-E0032
- Status: Open
- Alternatives and counter-evidence: The fixed claim does not require arbitrary noninterference or side-channel resistance.
- Limitations: The risk applies only if broader confidentiality is expected.

### STRIDE surface summary

| STRIDE category | Threat IDs | Principal surfaces |
| --- | --- | --- |
| Spoofing | THREAT-005, THREAT-009, THREAT-013 | Trap identity/state, tool and review identity, platform result |
| Tampering | THREAT-001, THREAT-003, THREAT-008, THREAT-009, THREAT-010 | Policy/PTE state, translation freshness, build/evidence/evaluator |
| Repudiation | THREAT-009, THREAT-011, THREAT-012 | Review provenance, evidence lineage, human gate |
| Information disclosure | THREAT-002, THREAT-004, THREAT-012, THREAT-014 | Private mappings, subject state, private evidence, unmodeled channels |
| Denial of service | THREAT-007 | Subject progress, strict portability behavior, terminal shutdown |
| Elevation of privilege | THREAT-002, THREAT-005, THREAT-006, THREAT-010, THREAT-013 | G-stage rights, trap path, host/evaluator, trusted dependencies |

## Attack trees and abuse cases

### ATTACK-001: Violate fixed subject isolation

The root goal is to read or modify state outside the active subject's fixed
authority. Branches are:

1. alter policy or seal state (THREAT-001);
2. install an absent or overpermissive mapping (THREAT-002);
3. retain a stale writer translation at reader entry (THREAT-003);
4. carry writer architectural state into the reader (THREAT-004);
5. forge an accepted event, fault, PC, or address (THREAT-005);
6. compromise the direct privileged trap path through nesting (THREAT-006);
   or
7. subvert a trusted firmware, emulator, toolchain, or hardware dependency
   (THREAT-013).

### ATTACK-002: Falsify assurance or publication

The root goal is to make an unreviewed or incorrect result appear
evidence-backed. Branches are build substitution (THREAT-008), self-consistent
evidence forgery (THREAT-009), evaluator or export compromise (THREAT-010),
historical/successor claim inflation (THREAT-011), and unauthorized disclosure
or promotion (THREAT-012).

### ATTACK-003: Exceed the fixed claim without a direct mapping bypass

The root goal is denial or disclosure outside the tested memory policy.
Branches are deliberate non-progress or fail-closed termination (THREAT-007)
and intentional/unmodeled architectural, microarchitectural, timing, shared,
or teardown channels (THREAT-014).

`diagrams/attack-tree-001.dot` is the normative structural rendering of these
branches.

## Existing controls

| Control ID | Label | Control | Threat IDs | Evidence IDs | Effectiveness | Confidence | Limitations |
| --- | --- | --- | --- | --- | --- | --- | --- |
| CONTROL-001 | Established | One-time label assignment, complete seal, exact-key complete-request authorization, and default deny | THREAT-001, THREAT-002 | TM-20260901-001-E0005 | Strong against malformed, missing, partial, and ordinary post-seal inputs | High | Trusted C can bypass API invariants. |
| CONTROL-002 | Established | Sole fixed six-rule policy with no parser, plugin, callback, or runtime update | THREAT-001, THREAT-002 | TM-20260901-001-E0006 | Strong complexity and attack-surface reduction | High | Does not protect against malicious compiled policy or build. |
| CONTROL-003 | Established | Exposure gate, per-bit derivation, combined authorization, and TE/PTE reconciliation | THREAT-001, THREAT-002 | TM-20260901-001-E0007, TM-20260901-001-E0037 | Strong source-level policy-to-hardware consistency check | High | Inside the same trusted runtime; no formal refinement. |
| CONTROL-004 | Established | Validated roots/backings, required raw PTE bits, absent cross-private leaves, and asymmetric shared mappings | THREAT-002, THREAT-003 | TM-20260901-001-E0008, TM-20260901-001-E0018 | Strong for the fixed map set | High | Hardware behavior and broader map sets are assumed. |
| CONTROL-005 | Established | Fixed GPR/private-stack/VS-CSR entry reset and VT controls | THREAT-004, THREAT-005, THREAT-014 | TM-20260901-001-E0009, TM-20260901-001-E0011 | Strong for enumerated state | High | Optional and microarchitectural state excluded. |
| CONTROL-006 | Established | Frame clear, VS reset/VVMA, reader root write/GVMA, stack replacement, and zero restore | THREAT-003, THREAT-004, THREAT-005 | TM-20260901-001-E0011 | Strong fixed transition ordering | High | Platform semantics assumed; no multicore. |
| CONTROL-007 | Established | Exact trap origin, cause, subject, phase, PC, address, TE/PTE, backing, and sentinel checks with terminal failure | THREAT-005, THREAT-006, THREAT-007 | TM-20260901-001-E0012 | Strong against malformed finite events | High | Direct path assumes no nesting and gives no availability. |
| CONTROL-008 | Established | Compile/link/layout constraints, non-LTO volatile guest-backing reads, and exact tool profiles | THREAT-001, THREAT-008, THREAT-013 | TM-20260901-001-E0004, TM-20260901-001-E0015, TM-20260901-001-E0018 | Reduces accidental source/build divergence | Medium | Toolchain and host remain trusted. |
| CONTROL-009 | Established | Implemented unit, raw-PTE, entry-state, build, layout, and disassembly verification source | THREAT-001 through THREAT-005 | TM-20260901-001-E0018 | Verification design only; no residual-risk reduction is credited until an exact frozen-revision run is admitted | Medium | No current execution admitted. |
| CONTROL-010 | Established | Implemented ordered QEMU trace validation and six negative-image verification sources | THREAT-003 through THREAT-007 | TM-20260901-001-E0019 | Verification design only; no residual-risk reduction is credited until an exact frozen-revision run is admitted | Medium | QEMU/firmware/producer trusted; finite fixtures only. |
| CONTROL-011 | Established | Makefile-owned canonical graph, protected values, path confinement, and output repair | THREAT-008 | TM-20260901-001-E0015 | Strong against documented caller overrides | Medium | Arbitrary alternate rules and hostile host actors remain outside scope. |
| CONTROL-012 | Established | Clean/dirty separation, exact commit/path/type/mode/hash namespaces, selected-tool verification, and transactional evidence publication | THREAT-008, THREAT-009 | TM-20260901-001-E0020 | Strong correspondence and consistency checks | Medium | Not authenticity, attestation, proof, or independent acquisition. |
| CONTROL-013 | Established | Captured-image rootless evaluation with read-only source/provenance/rootfs, hidden trees, proxy removal, exact export, fingerprints, and rollback | THREAT-009, THREAT-010 | TM-20260901-001-E0016 | Strong defense against direct evaluated-tree writes and export drift | Medium | Podman, kernel, runtime, wrapper, registry, and producer trusted. |
| CONTROL-014 | Established | Future review manifest contract and explicit historical provenance limits | THREAT-009, THREAT-011, THREAT-012 | TM-20260901-001-E0021, TM-20260901-001-E0023 | Improves traceability and prevents retroactive provenance repair | High | Producer attestation, not identity proof. |
| CONTROL-015 | Established | Deterministic documentation generation, confined serving, exact listener ownership, and traversal rejection | THREAT-010, THREAT-011, THREAT-012 | TM-20260901-001-E0021 | Strong for generated-path and local-preview integrity | Medium | Generated content and browser remain trusted; explicit non-loopback serve is possible. |
| CONTROL-016 | Established | Blocked gate, structural review-record constraints, and separate H6/H7 decisions | THREAT-009, THREAT-011, THREAT-012 | TM-20260901-001-E0017, TM-20260901-001-E0045 | Prevents automation from silently changing current release state | High | Does not authenticate a human or approve risk. |
| CONTROL-017 | Established | Explicit claim, assumption, non-goal, assurance, and distribution language | THREAT-007, THREAT-011 through THREAT-014 | TM-20260901-001-E0002, TM-20260901-001-E0013, TM-20260901-001-E0014, TM-20260901-001-E0022 | Strong defense against direct claim inflation | High | Documentation does not close technical channels or control downstream excerpts. |

## Mitigation and verification plan

| Mitigation ID | Label | Mitigation | Threat IDs | Verification approach | Owner | Status | Evidence IDs |
| --- | --- | --- | --- | --- | --- | --- | --- |
| MITIGATION-001 | Proposed | Produce a clean exact-commit evidence bundle for `1ab289c...`, verify it with independently selected tools, and preserve acquisition limitations. | THREAT-002, THREAT-003, THREAT-005, THREAT-008, THREAT-009, THREAT-010 | Run the maintained target workflow outside this threat-modeling boundary and admit exact immutable records in a successor iteration. | Responsible human to assign | Open | TM-20260901-001-E0020, TM-20260901-001-E0022, TM-20260901-001-E0026 |
| MITIGATION-002 | Proposed | Establish nested-HS-trap reachability or redesign the prologue/stack path to remain safe under nesting. | THREAT-006 | Focused source and architecture review followed by a bounded negative fixture or proof over exact assembly. | Responsible human to assign | Open | TM-20260901-001-E0025 |
| MITIGATION-003 | Proposed | Define the complete cross-subject architectural-state and shutdown-disposal contract, then reset or explicitly exclude every item. | THREAT-004, THREAT-014 | State inventory, source checks, dual-toolchain disassembly, adversarial transition fixtures, and documented zeroization decision. | Responsible human to assign | Open | TM-20260901-001-E0011, TM-20260901-001-E0014 |
| MITIGATION-004 | Proposed | Validate PTE, fence, trap, `HTVAL`, and shutdown behavior on an independently selected alternate emulator and, if the scope advances, K3 hardware. | THREAT-002, THREAT-003, THREAT-005, THREAT-007, THREAT-013, THREAT-014 | Exact versioned runs with negative cases, retained tool identity, and platform-specific limitations. | Responsible human to assign | Open | TM-20260901-001-E0014, TM-20260901-001-E0022, TM-20260901-001-E0044, TM-20260901-001-E0046 |
| MITIGATION-005 | Proposed | Add an independent acquisition/authentication axis for source, images, evidence, and review identity rather than relying only on producer-consistent records. | THREAT-001, THREAT-008 through THREAT-011, THREAT-013 | Define the trust root and threat model, verify signatures/attestations or independent rebuild/reproduction, and record counter-evidence. | Responsible human to assign | Open | TM-20260901-001-E0017, TM-20260901-001-E0020, TM-20260901-001-E0021 |
| MITIGATION-006 | Proposed | Complete separate responsible-human H6 source review, H7 release action, and any package promotion record only after evidence review. | THREAT-009, THREAT-011, THREAT-012 | Human-owned records must identify exact revision, evidence, decision, UTC time, role, and limitations; maintained validation must then pass. | Responsible human only | Open; agent cannot complete | TM-20260901-001-E0002, TM-20260901-001-E0017, TM-20260901-001-E0045 |
| MITIGATION-007 | Proposed | Prepare a traceability-preserving public derivative or obtain redistribution clearance for every private/internal dependency before any public-candidate promotion. | THREAT-012 | Sensitivity/licensing review, evidence substitution or abstraction, and human promotion checklist. | Responsible human to assign | Blocked on clearance | TM-20260901-001-E0027 through TM-20260901-001-E0032, TM-20260901-001-E0036, TM-20260901-001-E0042, TM-20260901-001-E0045 |
| MITIGATION-008 | Proposed | Rerun the three bounded public-primary-source searches when an approved web research capability is available. | THREAT-003, THREAT-011, THREAT-013, THREAT-014 | Verify exact ratified RISC-V semantics, VBS comparison limits, and TE/mapping primary records; append search and evidence records. | Threat-model owner | Blocked on research capability | TM-20260901-001-E0039, TM-20260901-001-E0040, TM-20260901-001-E0046 |
| MITIGATION-009 | Proposed | Specify and machine-check the fixed policy-to-PTE, transition, and event-state properties against the exact production source revision without inheriting successor claims. | THREAT-001 through THREAT-006, THREAT-008, THREAT-013, THREAT-014 | Independent specification, exact source/property/tool manifest, complete unwinding where applicable, mutation sensitivity, and explicit assembly/compiler/ISA limits. | Responsible human to assign | Open | TM-20260901-001-E0022, TM-20260901-001-E0041, TM-20260901-001-E0044 |

## Assumptions and non-goals

### ASSUMPTION-001: Fixed no-concurrency platform

One hart, disabled interrupts, no devices, no DMA/IOMMU, no scheduler, no
concurrent mutation, and no dynamic mapping lifecycle are assumed. If false,
translation invalidation, ownership, interrupt, and reuse threats require a
new model. Evidence: TM-20260901-001-E0014, TM-20260901-001-E0029,
TM-20260901-001-E0043.

### ASSUMPTION-002: Architecture, firmware, and emulator correctness

The selected RISC-V H/G-stage behavior, OpenSBI handoff/services, QEMU 10.2.2,
fences, traps, and strict `HTVAL` profile are trusted. If false, THREAT-003,
THREAT-005, THREAT-007, and THREAT-013 can invalidate the result. Evidence:
TM-20260901-001-E0012, TM-20260901-001-E0014, TM-20260901-001-E0046.

### ASSUMPTION-003: Toolchain and host correctness

Compilers, assemblers, linkers, Make, shell, Git, hashing, Node, container
engine, kernel, runtime, registry, repositories, and ordinary filesystem
semantics are trusted within their stated boundaries. Evidence:
TM-20260901-001-E0014 through TM-20260901-001-E0021.

### ASSUMPTION-004: No nested HS trap

The direct trap handler assumes it will not nest. Triggerability and safety
outside that assumption are `Unknown` and tracked by THREAT-006 and OPEN-004.
Evidence: TM-20260901-001-E0025.

### ASSUMPTION-005: Fixed synthetic subjects, not arbitrary VMs

The model covers two linked sequential synthetic VS payloads and one fixed
memory policy. Management Linux, protected service VMs, capabilities, CHERI,
FLASK runtime, VBS/VTL compatibility, multicore, devices, and dynamic policy
are non-goals. Evidence: TM-20260901-001-E0028 through
TM-20260901-001-E0032.

### ASSUMPTION-006: Availability and side channels are non-goals

The target does not guarantee progress, timer enforcement, covert/timing
channel resistance, speculative-state clearing, or arbitrary
noninterference. Fail-closed termination can be an intentional denial of
service. Evidence: TM-20260901-001-E0014.

### ASSUMPTION-007: API sealing is not hardware immutability

The policy and TE state remain writable by trusted HS code. The seal constrains
the supported API, not malicious or memory-unsafe TCB behavior. Evidence:
TM-20260901-001-E0005, TM-20260901-001-E0014.

### ASSUMPTION-008: Evidence correspondence is not authenticity

Build, trace, manifest, and verifier controls assume the acquisition path,
producer, host, and selected trust roots are honest enough for their recorded
claims. Evidence: TM-20260901-001-E0015 through TM-20260901-001-E0021.

### ASSUMPTION-009: Historical chats and reviews are non-authoritative

The three transcripts are design provenance only; the five retained reviews
are challenge evidence against older revisions; later CBMC work is
successor-only. Evidence: TM-20260901-001-E0022 through
TM-20260901-001-E0034, TM-20260901-001-E0041.

### ASSUMPTION-010: Public-source revalidation remains unavailable

RISC-V, VBS, and TE/mapping primary-source checks could not run because no
approved web capability was available. Local completed packages remain
bounded secondary evidence. Evidence: TM-20260901-001-E0039,
TM-20260901-001-E0040, TM-20260901-001-E0046.

## Risk method

Likelihood and impact use integer values from 1 through 5. The risk band is:

- `Low`: product 1-4.
- `Moderate`: product 5-9.
- `High`: product 10-16.
- `Critical`: product 17-25.

Inherent risk is assessed before credited controls. Residual risk is assessed
after only evidence-supported controls. Risk acceptance is a responsible-human
decision and is never inferred from this model.

## Coverage matrix

| Surface ID | Surface type | Threat IDs or explicit disposition | Coverage | Evidence IDs | Limitation |
| --- | --- | --- | --- | --- | --- |
| OBJECTIVE-001 | Security objective | THREAT-001, THREAT-005, THREAT-006, THREAT-008, THREAT-013 | Complete | TM-20260901-001-E0005, TM-20260901-001-E0013 | TCB integrity is assumption-bound. |
| OBJECTIVE-002 | Security objective | THREAT-002, THREAT-004, THREAT-013, THREAT-014 | Complete | TM-20260901-001-E0006, TM-20260901-001-E0013 | Not complete noninterference. |
| OBJECTIVE-003 | Security objective | THREAT-002, THREAT-003, THREAT-013, THREAT-014 | Complete | TM-20260901-001-E0006 through TM-20260901-001-E0012 | Intended shared flow remains. |
| OBJECTIVE-004 | Security objective | THREAT-001, THREAT-002, THREAT-003, THREAT-005, THREAT-008, THREAT-013 | Complete | TM-20260901-001-E0005 through TM-20260901-001-E0008 | No formal refinement. |
| OBJECTIVE-005 | Security objective | THREAT-003 through THREAT-006, THREAT-013 | Complete | TM-20260901-001-E0009 through TM-20260901-001-E0011 | Optional state excluded. |
| OBJECTIVE-006 | Security objective | THREAT-005, THREAT-007, THREAT-009, THREAT-013 | Complete | TM-20260901-001-E0010 through TM-20260901-001-E0012 | Availability excluded. |
| OBJECTIVE-007 | Security objective | THREAT-008 through THREAT-011, THREAT-013 | Complete | TM-20260901-001-E0015 through TM-20260901-001-E0021 | Producer authenticity unresolved. |
| OBJECTIVE-008 | Security objective | THREAT-009, THREAT-011, THREAT-012 | Complete | TM-20260901-001-E0017, TM-20260901-001-E0045 | Human decision pending. |
| ASSET-001 | Asset | THREAT-001, THREAT-005, THREAT-006, THREAT-013 | Complete | TM-20260901-001-E0003, TM-20260901-001-E0013 | Trusted source integrity assumed. |
| ASSET-002 | Asset | THREAT-001, THREAT-008, THREAT-013 | Complete | TM-20260901-001-E0005, TM-20260901-001-E0006 | API seal only. |
| ASSET-003 | Asset | THREAT-002, THREAT-004, THREAT-013, THREAT-014 | Complete | TM-20260901-001-E0004, TM-20260901-001-E0010 | Side channels excluded. |
| ASSET-004 | Asset | THREAT-002, THREAT-004, THREAT-013, THREAT-014 | Complete | TM-20260901-001-E0004, TM-20260901-001-E0012 | Side channels excluded. |
| ASSET-005 | Asset | THREAT-002, THREAT-003, THREAT-013, THREAT-014 | Complete | TM-20260901-001-E0006, TM-20260901-001-E0012 | Shared read flow intentional. |
| ASSET-006 | Asset | THREAT-001, THREAT-002, THREAT-003, THREAT-005, THREAT-008, THREAT-013 | Complete | TM-20260901-001-E0007, TM-20260901-001-E0008 | Hardware state assumed. |
| ASSET-007 | Asset | THREAT-003 through THREAT-006, THREAT-013, THREAT-014 | Complete | TM-20260901-001-E0010 through TM-20260901-001-E0012 | State inventory incomplete. |
| ASSET-008 | Asset | THREAT-005, THREAT-007, THREAT-009, THREAT-013 | Complete | TM-20260901-001-E0012, TM-20260901-001-E0019 | Trace producer trusted. |
| ASSET-009 | Asset | THREAT-008 through THREAT-010, THREAT-013 | Complete | TM-20260901-001-E0015 through TM-20260901-001-E0020 | Toolchain trusted. |
| ASSET-010 | Asset | THREAT-009 through THREAT-012 | Complete | TM-20260901-001-E0016, TM-20260901-001-E0020, TM-20260901-001-E0021 | Private redistribution unresolved. |
| ASSET-011 | Asset | THREAT-009, THREAT-011, THREAT-012 | Complete | TM-20260901-001-E0017, TM-20260901-001-E0045 | Structural identity only. |
| ACTOR-001 | Actor | THREAT-002 through THREAT-007, THREAT-014 | Complete | TM-20260901-001-E0010 | Fixed synthetic capability only. |
| ACTOR-002 | Actor | THREAT-002 through THREAT-007, THREAT-014 | Complete | TM-20260901-001-E0012 | Fixed synthetic capability only. |
| ACTOR-003 | Actor | THREAT-001 through THREAT-006 | Complete | TM-20260901-001-E0003 through TM-20260901-001-E0014 | Trusted monitor is not separately isolated. |
| ACTOR-004 | Actor | THREAT-007, THREAT-013 | Complete | TM-20260901-001-E0009, TM-20260901-001-E0014 | M-mode is trusted. |
| ACTOR-005 | Actor | THREAT-003, THREAT-005 through THREAT-007, THREAT-013, THREAT-014 | Complete | TM-20260901-001-E0014 | Hardware not run. |
| ACTOR-006 | Actor | THREAT-001, THREAT-008 through THREAT-012 | Complete | TM-20260901-001-E0015 through TM-20260901-001-E0021 | Human/operator trust varies. |
| ACTOR-007 | Actor | THREAT-008 through THREAT-010, THREAT-013 | Complete | TM-20260901-001-E0014, TM-20260901-001-E0016 | Supply chain not independently authenticated. |
| ACTOR-008 | Actor | THREAT-009, THREAT-010, THREAT-013 | Complete | TM-20260901-001-E0016 | Host substrate trusted. |
| ACTOR-009 | Actor | THREAT-009, THREAT-011, THREAT-012 | Complete | TM-20260901-001-E0021 through TM-20260901-001-E0024 | Review is evidence, not authority. |
| ACTOR-010 | Actor | THREAT-011, THREAT-012 | Complete | TM-20260901-001-E0017, TM-20260901-001-E0045 | No decision recorded. |
| ACTOR-011 | Actor | THREAT-001, THREAT-008 through THREAT-010, THREAT-012 through THREAT-014 | Complete | TM-20260901-001-E0014, TM-20260901-001-E0043 | Capability depends on compromised layer. |
| BOUNDARY-001 | Trust boundary | THREAT-005, THREAT-007, THREAT-013 | Complete | TM-20260901-001-E0003, TM-20260901-001-E0009 | Firmware trusted. |
| BOUNDARY-002 | Trust boundary | THREAT-002, THREAT-004 through THREAT-007, THREAT-014 | Complete | TM-20260901-001-E0009, TM-20260901-001-E0010 | Writer is synthetic. |
| BOUNDARY-003 | Trust boundary | THREAT-002, THREAT-004 through THREAT-007, THREAT-014 | Complete | TM-20260901-001-E0011, TM-20260901-001-E0012 | Reader is synthetic. |
| BOUNDARY-004 | Trust boundary | THREAT-003 through THREAT-006, THREAT-014 | Complete | TM-20260901-001-E0011 | Optional state not covered. |
| BOUNDARY-005 | Trust boundary | THREAT-001 through THREAT-003 | Complete | TM-20260901-001-E0005 through TM-20260901-001-E0008 | Same trusted C domain. |
| BOUNDARY-006 | Trust boundary | THREAT-008, THREAT-009, THREAT-013 | Complete | TM-20260901-001-E0015, TM-20260901-001-E0019 | No independent acquisition. |
| BOUNDARY-007 | Trust boundary | THREAT-010, THREAT-013 | Complete | TM-20260901-001-E0016 | Container stack trusted. |
| BOUNDARY-008 | Trust boundary | THREAT-009, THREAT-010, THREAT-012 | Complete | TM-20260901-001-E0016, TM-20260901-001-E0020 | Export authenticity unresolved. |
| BOUNDARY-009 | Trust boundary | THREAT-009, THREAT-011, THREAT-012 | Complete | TM-20260901-001-E0017, TM-20260901-001-E0045 | Human identity structural only. |
| FLOW-001 | Flow | THREAT-005, THREAT-013 | Complete | TM-20260901-001-E0009 | Firmware handoff assumed. |
| FLOW-002 | Flow | THREAT-001 | Complete | TM-20260901-001-E0005, TM-20260901-001-E0006 | Fixed policy only. |
| FLOW-003 | Flow | THREAT-001, THREAT-002 | Complete | TM-20260901-001-E0007 | Same TCB. |
| FLOW-004 | Flow | THREAT-004 through THREAT-007 | Complete | TM-20260901-001-E0010, TM-20260901-001-E0012 | Finite events only. |
| FLOW-005 | Flow | THREAT-002, THREAT-014 | Complete | TM-20260901-001-E0010 | Memory accesses only. |
| FLOW-006 | Flow | THREAT-002, THREAT-014 | Complete | TM-20260901-001-E0010 | Intentional shared flow. |
| FLOW-007 | Flow | THREAT-003 through THREAT-006 | Complete | TM-20260901-001-E0011 | Platform semantics assumed. |
| FLOW-008 | Flow | THREAT-002, THREAT-014 | Complete | TM-20260901-001-E0012 | Memory accesses only. |
| FLOW-009 | Flow | THREAT-002, THREAT-003, THREAT-014 | Complete | TM-20260901-001-E0012 | Intentional direction. |
| FLOW-010 | Flow | THREAT-002, THREAT-005, THREAT-007 | Complete | TM-20260901-001-E0012 | Strict `HTVAL` profile. |
| FLOW-011 | Flow | THREAT-008, THREAT-013 | Complete | TM-20260901-001-E0015 | Toolchain trusted. |
| FLOW-012 | Flow | THREAT-009, THREAT-013 | Complete | TM-20260901-001-E0019 | Emulator/producer trusted. |
| FLOW-013 | Flow | THREAT-009 | Complete | TM-20260901-001-E0020 | Correspondence, not authenticity. |
| FLOW-014 | Flow | THREAT-010 | Complete | TM-20260901-001-E0016 | Host/container trusted. |
| FLOW-015 | Flow | THREAT-010 through THREAT-012 | Complete | TM-20260901-001-E0021 | Generated claims can be excerpted. |
| FLOW-016 | Flow | THREAT-009, THREAT-011, THREAT-012 | Complete | TM-20260901-001-E0017, TM-20260901-001-E0045 | No human decision recorded. |
| ENTRY-001 | Entry point | THREAT-001, THREAT-005, THREAT-013 | Complete | TM-20260901-001-E0009 | Firmware trusted. |
| ENTRY-002 | Entry point | THREAT-004, THREAT-005, THREAT-007, THREAT-014 | Complete | TM-20260901-001-E0009, TM-20260901-001-E0010 | Fixed payload only. |
| ENTRY-003 | Entry point | THREAT-004 through THREAT-007 | Complete | TM-20260901-001-E0012, TM-20260901-001-E0025 | Nested path unknown. |
| ENTRY-004 | Entry point | THREAT-003 through THREAT-006, THREAT-014 | Complete | TM-20260901-001-E0011 | No arbitrary context switch. |
| ENTRY-005 | Entry point | THREAT-008 | Complete | TM-20260901-001-E0015 | Alternate rules out of scope. |
| ENTRY-006 | Entry point | THREAT-009, THREAT-013 | Complete | TM-20260901-001-E0019 | No current run. |
| ENTRY-007 | Entry point | THREAT-009 | Complete | TM-20260901-001-E0020 | Producer trust remains. |
| ENTRY-008 | Entry point | THREAT-010 | Complete | TM-20260901-001-E0016 | Container stack trust remains. |
| ENTRY-009 | Entry point | THREAT-010 through THREAT-012 | Complete | TM-20260901-001-E0021 | Public serving is explicit opt-in. |
| ENTRY-010 | Entry point | THREAT-011, THREAT-012 | Complete | TM-20260901-001-E0017 | Structural gate only. |

## Residual risk and unknowns

The highest residual rating is `Critical` for THREAT-013 because trusted
firmware, emulator, toolchain, host, and hardware can invalidate both
execution and evidence, and no independent trust root or hardware result is
admitted. THREAT-002, THREAT-003, THREAT-005 through THREAT-010, and
THREAT-014 remain `High`: preventive mapping, fence, and trap checks do not
contain consequences after a bypass; nested-trap safety is assumption-bound;
availability and broader information-flow control are non-goals; and build,
evidence, and evaluator controls do not remove trusted-producer or host
compromise.

OPEN-001 through OPEN-011 remain non-blocking for this private initial
projection but materially limit portability, current execution-backed
assurance, historical authentication, public-candidate eligibility, and
broader confidentiality claims. No residual risk is accepted by this model.
