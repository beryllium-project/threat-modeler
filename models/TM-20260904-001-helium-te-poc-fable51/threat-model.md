# Formal threat model

Package ID: `TM-20260904-001`
Title: Helium TE PoC Independent Threat Model (Fable 5.1 replay)
Created: 2026-09-04
Status: `Complete`
Distribution: `private`
Latest model iteration: `MODEL-ITERATION-002`

## Executive summary

Target: `component://helium-te-poc` at exact clean commit
`1ab289c066b69acdd8b55c9f77055b0145be1316` (TM-20260904-001-E0001), a
single-hart RV64 HS-mode Type-Enforcement (TE) monitor that runs one writer and
then one reader VS-mode subject under separate G-stage roots inside QEMU
`virt`. Mode: `create-from-evidence`; no formal model existed
(TM-20260904-001-E0003). This projection was produced independently of the
prior package `TM-20260901-001`, which was excluded from evidence.

Position (`Inferred`): within its documented fixed profile the runtime is
fail-closed and small. Only three trap causes (10, 21, 23) are recognised, each
further constrained to exact PC, subject and phase (four ECALL events and three
scripted faults); every other trap terminates the experiment
(TM-20260904-001-E0025, E0026, E0027); policy is default-deny with
one-rule complete matching (TM-20260904-001-E0030); subject transition clears
the register frame, resets VS CSRs, switches root and fences globally
(TM-20260904-001-E0066). The dominant residual exposures are not in the guest
boundary but in (a) the HS-mode C itself, which is unprotected trusted code
with no memory-safety proof and no page-level protection of policy state
(TM-20260904-001-E0012, E0035); (b) the evidence and claim chain, where a
self-consistent false bundle is admitted to be possible
(TM-20260904-001-E0017) and later-lineage assurance artefacts can be
misattributed to this commit (TM-20260904-001-E0062, E0004); and (c) human
gates that remain open (H6 source review and H7 release, TM-20260904-001-E0052).

Highest residual risks: THREAT-013 (fabricated self-consistent evidence,
`High`), THREAT-008 (HS-mode C defect corrupting policy or control state,
`High` on impact), THREAT-016 (claim inflation / lineage misattribution,
`Moderate`, upper bound of band), THREAT-010 (policy/PTE divergence undetected
by same-domain readback, `Moderate`), THREAT-014 (supply-chain compromise,
`Moderate`), THREAT-015 (unauthenticated publication-gate approval,
`Moderate`).

Evidence strength: no target code was executed and no retained result bundle
was inspected. Where this model credits a test, validator or negative image,
the admitted evidence is that the maintained check is *designed* to detect the
condition at this revision, not that it was observed to pass
(TM-20260904-001-E0042 to E0047).

Assurance boundary preserved: Helium is a review-and-test PoC, not formally
verified and not hardware validated (TM-20260904-001-E0005, E0053). No CBMC
harness exists at this revision (TM-20260904-001-E0062). Beryllium is accepted
through R7; R8-H0 is a committed candidate and is not accepted; K3 hardware is
`NOT RUN` (TM-20260904-001-E0053). Nothing in this model is acceptance,
approval or sign-off.

## Fact labels

- `Established`: directly supported by admitted evidence.
- `Inferred`: reasoned from evidence with alternatives and limitations.
- `Proposed`: a candidate design, control, or mitigation.
- `Unknown`: evidence is missing or conflicting.

## System boundary and lifecycle

Inside the boundary (`Established`, TM-20260904-001-E0006, E0009, E0028):

- HS-mode monitor: `src/entry.S`, `src/trap.S`, `src/main.c`, `src/te.c`,
  `src/policy/te.c`, `src/memory.c`, `src/platform.c`, headers under
  `include/he/`, and the linker script.
- Two VS-mode synthetic subjects (writer, reader) assembled from `src/guest.S`
  into the same ELF image, with six fixed 4 KiB guest-physical regions.
- The SBI boundary to OpenSBI (console putchar and shutdown only).
- Host tooling that produces and verifies evidence about the image: Makefile,
  `he` wrapper, QEMU runner and trace validators, negative-image tests,
  evidence generator and verifier, rootless evaluator, publication gate,
  documentation build and preview.

Outside the boundary (`Established`, TM-20260904-001-E0011, E0014): production
TE, Linux or arbitrary guests, multicore, interrupts and timers, devices, DMA,
IOMMU, dynamic policy, attestation, side channels, certification and formal
verification. OpenSBI, QEMU and the toolchains are trusted platform (E0010).

Lifecycle (`Established`, TM-20260904-001-E0018, E0020, E0063, E0026, E0066,
E0034):

1. Firmware handoff: OpenSBI enters `_start` in HS-mode with `a0 = hartid`.
2. Initialisation: BSS clear, trusted stack, `he_main` hart check, CSR setup
   (`stvec`, `sscratch`, Bare `satp`, zero `sie`/`hedeleg`/`hideleg`/
   `hcounteren`/`hvip`), TE labelling and seal, policy-derived G-stage
   construction, PTE readback, cross-private absence check.
3. Writer phase: `SRET` into writer VS with `VTVM|VTW|VTSR`; writer performs
   scripted private/shared RW, event 1, scripted cross-private fault, seeds
   residue, event 2.
4. Transition: frame clear, VS CSR reset, `HFENCE.VVMA`, reader `hgatp`,
   `HFENCE.GVMA`, reader stack, `SRET`.
5. Reader phase: entry-state assertions, own private RW, shared read, event 3,
   scripted shared-store fault, scripted cross-private fault, event 4.
6. Terminal: `HE_RESULT: PASS` or `HE_RESULT: FAIL` on the HS console, SBI
   shutdown, `WFI` loop if firmware returns. There is no recovery, update or
   reboot path.
7. Host side: build both toolchain images, run QEMU three times per image,
   validate exact-once ordered markers, generate and verify an evidence bundle
   bound to the exact clean commit; publication remains blocked pending human
   checkpoints H6 and H7.

Security-relevant state changes: seal of TE labels; `hgatp` write; phase
advance on each accepted event; the single writer-to-reader transition; the
terminal marker.

## Security objectives

| Objective ID | Label | Objective | Evidence IDs | Confidence | Limitations |
| --- | --- | --- | --- | --- | --- |
| OBJECTIVE-001 | Established | Integrity of the HS-mode monitor: code, trusted stack, TE state, G-stage tables, `hgatp` values, and subject/phase state are not modified by any VS subject. | TM-20260904-001-E0007, E0009 | High | Integrity against defective or malicious HS code itself is explicitly not claimed (E0012). |
| OBJECTIVE-002 | Established | Confidentiality and integrity of each subject's private page against the other subject. | TM-20260904-001-E0007, E0016 | High | Tested for the two scripted accesses only. |
| OBJECTIVE-003 | Established | Asymmetric mediation of the shared page: writer RW, reader R; a reader store must fault and leave the value unchanged. | TM-20260904-001-E0007, E0016, E0033 | High | Shared page is an intentional channel; no information-flow claim. |
| OBJECTIVE-004 | Established | Correspondence: every G-stage leaf permission equals the sealed TE decision; unmatched requests are denied and unmapped. | TM-20260904-001-E0007, E0031 | High | Correspondence is checked in software memory before activation only (E0055). |
| OBJECTIVE-005 | Established | Transition hygiene: the reader starts from a zero GPR frame and the documented VS-CSR baseline, on its own root, with no stale translations. | TM-20260904-001-E0007, E0066, E0045 | High | Optional CSRs, timing and microarchitectural state excluded (E0014, E0021). |
| OBJECTIVE-006 | Established | Terminal-result integrity: `HE_RESULT: PASS` is emitted only after every scripted event was accepted in order; any deviation fails closed. | TM-20260904-001-E0007, E0025, E0034, E0043 | High | Assumes HS output and host capture are honest (E0017). |
| OBJECTIVE-007 | Established | Claim and evidence discipline: statements about Helium stay within supported wording, evidence corresponds to the exact commit, and release requires the responsible human. | TM-20260904-001-E0005, E0016, E0039, E0053 | High | Documentation and procedural controls only. |

## Protected assets

| Asset ID | Label | Asset | Required property | Owner or authority | Evidence IDs | Confidence |
| --- | --- | --- | --- | --- | --- | --- |
| ASSET-001 | Established | HS monitor code, data and 8 KiB trusted stack | Integrity, availability during the run | Helium maintainers | TM-20260904-001-E0007, E0009, E0018 | High |
| ASSET-002 | Established | TE labels, seal state and the six-rule policy in HS memory | Integrity after seal | Helium maintainers | TM-20260904-001-E0007, E0030 | High |
| ASSET-003 | Established | G-stage tables and the two `hgatp` root values | Integrity; correspondence with ASSET-002 | Helium maintainers | TM-20260904-001-E0029, E0031 | High |
| ASSET-004 | Established | Active-subject and phase state machine, expected PCs | Integrity, ordered progression | Helium maintainers | TM-20260904-001-E0026 | High |
| ASSET-005 | Established | Writer private page (`0x40003000`) | Confidentiality and integrity against reader | Writer subject | TM-20260904-001-E0028 | High |
| ASSET-006 | Established | Reader private page (`0x40004000`) | Confidentiality and integrity against writer | Reader subject | TM-20260904-001-E0028 | High |
| ASSET-007 | Established | Shared page (`0x40005000`) | Integrity against reader writes; availability to reader reads | Writer subject | TM-20260904-001-E0028, E0033 | High |
| ASSET-008 | Established | Saved trap frame, `sscratch`, VS CSR baseline at transition | Zeroed/reset before reader entry | Helium maintainers | TM-20260904-001-E0024, E0066 | High |
| ASSET-009 | Established | Serial stage markers and `HE_RESULT` line | Authenticity (HS-only origin), exact-once ordering | Helium maintainers | TM-20260904-001-E0034, E0043 | High |
| ASSET-010 | Established | Retained evidence bundle, review manifests, `publication-gate.conf` | Integrity, correspondence to exact commit, human-only approval | Responsible human | TM-20260904-001-E0039, E0047, E0049 | High |
| ASSET-011 | Established | Build inputs: Makefile, toolchains, QEMU, OpenSBI, container base, npm lockfile | Integrity, provenance | Build operator; upstream projects | TM-20260904-001-E0036, E0038 | Medium |

## Actors and capabilities

| Actor ID | Label | Actor | Trust | Access and capabilities | Goals | Evidence IDs | Confidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ACTOR-001 | Established | Writer VS subject (production payload) | Untrusted by policy; cooperative in the shipped image | Executes scripted VS code; RW own private and shared pages; ECALL events 1, 2 | Complete the writer phase | TM-20260904-001-E0006, E0013 | High |
| ACTOR-002 | Established | Reader VS subject (production payload) | Untrusted by policy; cooperative in the shipped image | Executes scripted VS code; RW own private; R shared; ECALL events 3, 4 | Complete the reader phase | TM-20260904-001-E0006, E0013 | High |
| ACTOR-003 | Inferred | Adversarial linked payload | Untrusted | Arbitrary VS-mode instruction stream in the guest code page under either subject identity; controls GPRs, guest addresses, ECALL values, timing; cannot access console or M-mode | Read or write the other subject's private page, alter shared page as reader, corrupt HS state, forge `PASS` | TM-20260904-001-E0008, E0059 | Medium |
| ACTOR-004 | Established | OpenSBI (M-mode firmware) | Trusted | Console output, shutdown, boot handoff | None (trusted dependency) | TM-20260904-001-E0006, E0034 | High |
| ACTOR-005 | Established | QEMU `virt` emulator and its RISC-V H-extension model | Trusted platform | Implements CSRs, G-stage walker, fences, traps | None (trusted dependency) | TM-20260904-001-E0010, E0037 | High |
| ACTOR-006 | Established | Build operator / evaluator | Trusted for private work | Selects toolchain, QEMU, firmware, environment; runs Make, QEMU, Podman | Produce images and evidence | TM-20260904-001-E0037, E0048 | High |
| ACTOR-007 | Inferred | Compromised host or evidence producer (including supply-chain compromise of toolchain, QEMU, firmware, container base or npm packages) | Untrusted | Can alter build inputs, fabricate serial logs and bundles, substitute binaries | Cause a false `PASS` or false assurance record to be accepted | TM-20260904-001-E0017, E0038 | Medium |
| ACTOR-008 | Established | Responsible human reviewer / publisher | Trusted authority | Sole authority for H6 review, H7 release, gate approval | Correct release decisions | TM-20260904-001-E0040, E0052 | High |
| ACTOR-009 | Inferred | Downstream claimant or documentation consumer (including automation) | Untrusted for claims | Reads docs, evidence, later-lineage artefacts; may restate claims | Reuse Helium as assurance evidence | TM-20260904-001-E0016, E0053, E0004 | Medium |
| ACTOR-010 | Inferred | Remote network peer of the documentation host | Untrusted | Network reachability to the host only when the preview server is opted into remote binding; GET/HEAD requests | Read unpublished documentation | TM-20260904-001-E0041 | Medium |

## Trusted computing base and dependencies

Required trust (`Established`, TM-20260904-001-E0009, E0010):

| Element | Required trust | Evidence that it is correct | Gap |
| --- | --- | --- | --- |
| HS-mode C and assembly (ASSET-001, ASSET-002, ASSET-003) | Complete: any defect can violate every objective | Host unit tests (E0042), disassembly tests (E0045), negative images (E0044), historical reviews of earlier commits (E0050) | No memory-safety proof, no formal model, no stack protection (E0012, E0062, E0035) |
| Fixed policy source and initialiser | Complete | Authority report and 48-decision check (E0042) | Policy is writable HS data (E0012) |
| Linker script and image layout | Complete: exact PCs and GPAs are load-bearing (E0026, E0028) | Build-graph and layout tests (E0036, E0046) | No source-to-binary correspondence (E0062) |
| OpenSBI (ACTOR-004) | Console and shutdown honesty; correct handoff | None beyond documented assumption | Trusted without evidence |
| QEMU 10.2.2 H-extension model (ACTOR-005) | Correct CSR, G-stage, fence and trap semantics | Maintained QEMU run protocol and recorded tool versions (E0043); no run observed here | Emulator evidence is not hardware evidence (E0060); K3 `NOT RUN` (E0053) |
| GCC/Clang, binutils/lld | Faithful compilation, volatile preserved | Two-toolchain agreement (E0043), sentinel load checks (E0046) | Compiler trusted |
| Host tools: Make, shell, Podman, Node, Graphviz, Chromium | Evidence and documentation correctness | Fixtures (E0047, E0048) | Host trusted; supply chain not attested (E0038) |
| Responsible human (ACTOR-008) | Correct review and release decisions | Gate checker structure (E0040) | Identity is procedural (E0040); H6/H7 open (E0052) |

## Components and interfaces

| Component | Interfaces | Evidence IDs |
| --- | --- | --- |
| `_start` / `he_main` | OpenSBI handoff (`a0`, `a1`); CSR writes | TM-20260904-001-E0018, E0019, E0020 |
| `he_trap_vector` / `he_handle_trap` | `stvec` direct entry for all VS exceptions and interrupts; `scause`, `sepc`, `stval`, `htval`, `hstatus` | TM-20260904-001-E0024, E0025 |
| `he_handle_ecall` | Event ABI in `a0`; exact PC; phase | TM-20260904-001-E0026 |
| `he_validate_fault_address` / cross-private and shared-store handlers | Causes 21/23; GPA correspondence; TE re-check; PTE inspection; volatile sentinel loads | TM-20260904-001-E0027, E0033 |
| TE mechanism and policy (`te.c`, `policy/te.c`) | Label, seal, authorise API used only by HS | TM-20260904-001-E0030 |
| G-stage builder (`memory.c`) | Table construction, leaf encoding, `hgatp` encoding | TM-20260904-001-E0029 |
| `he_switch_to_reader` / `he_arch_switch_guest` | Frame clear, VS CSR reset, fences, `hgatp`, `sscratch` | TM-20260904-001-E0066 |
| Platform (`platform.c`) | SBI console putchar, SBI shutdown | TM-20260904-001-E0034 |
| Guest payload (`guest.S`) | Scripted VS instructions, ECALLs, deliberate faults | TM-20260904-001-E0023, E0028 |
| Host: Makefile, `he`, `demo.sh` | Environment variables, PATH, Make goals | TM-20260904-001-E0036, E0037 |
| Host: QEMU runner and validators | Serial capture, exact-once protocol | TM-20260904-001-E0043, E0044 |
| Host: evidence generator/verifier, review manifest linter | Bundle paths, hashes, exact commit | TM-20260904-001-E0047, E0049 |
| Host: rootless evaluator | Podman mounts, no network | TM-20260904-001-E0048 |
| Host: publication gate, docs build and preview | `publication-gate.conf`, gate commit, loopback HTTP | TM-20260904-001-E0039, E0040, E0041 |

## Trust boundaries

| Boundary ID | Label | Boundary | Crossing parties | Enforcement | Evidence IDs | Confidence |
| --- | --- | --- | --- | --- | --- | --- |
| BOUNDARY-001 | Established | M-mode firmware to HS monitor | ACTOR-004 to Helium; Helium SBI calls | RISC-V privilege levels; Helium trusts OpenSBI | TM-20260904-001-E0006, E0034 | High |
| BOUNDARY-002 | Established | HS monitor to VS subject | Helium and ACTOR-001/002/003 | `hstatus` (SPV, VTVM, VTW, VTSR), `hedeleg`/`hideleg`=0, G-stage translation, `stvec` direct trap, `sscratch` stack swap | TM-20260904-001-E0020, E0063, E0024, E0025 | High |
| BOUNDARY-003 | Established | Writer subject to reader subject (sequential) | ACTOR-001 and ACTOR-002 (or ACTOR-003) | Separate G-stage roots, frame clear, CSR reset, `HFENCE.VVMA`/`GVMA`; shared page is the only intended channel | TM-20260904-001-E0029, E0066 | High |
| BOUNDARY-004 | Established | Target image and its evidence to host build/evaluation tooling | ACTOR-006, ACTOR-007 and the image/bundle | Makefile confinement, rootless evaluator, evidence verifier, exact-clean-commit binding | TM-20260904-001-E0036, E0047, E0048 | Medium |
| BOUNDARY-005 | Established | Evidence and claims to publication | ACTOR-008, ACTOR-009 | `publication-gate.conf` blocked, structural gate checker, supported-wording list, human checkpoints H6/H7 | TM-20260904-001-E0016, E0039, E0040, E0052 | High |

## Data and control flows

| Flow ID | Label | Source | Destination | Data or authority | Boundary IDs | Protection | Evidence IDs |
| --- | --- | --- | --- | --- | --- | --- | --- |
| FLOW-001 | Established | OpenSBI | `_start` / `he_main` | HS-mode control, `hartid`, FDT pointer (ignored) | BOUNDARY-001 | Hart check after BSS clear; FDT unused | TM-20260904-001-E0018, E0019, E0020 |
| FLOW-002 | Established | HS | Writer VS | `SRET` with SPV/SPVP/VTVM/VTW/VTSR; writer root active | BOUNDARY-002 | CSR setup; sealed policy; readback complete | TM-20260904-001-E0063, E0031 |
| FLOW-003 | Established | VS subject | HS `he_handle_ecall` | Event value in `a0`; `sepc` | BOUNDARY-002 | Exact PC, phase and subject match; else `he_fail` | TM-20260904-001-E0026 |
| FLOW-004 | Established | VS subject (faulting access) | HS fault handlers | Causes 21/23; `stval`, `htval`, `sepc`, `hstatus.GVA` | BOUNDARY-002 | GPA correspondence, TE re-check, PTE inspection, unchanged value; four-byte advance | TM-20260904-001-E0027, E0033 |
| FLOW-005 | Established | Writer | Shared page, then reader | One 64-bit value | BOUNDARY-003 | Writer RW leaf; reader R-only leaf; HS volatile reads | TM-20260904-001-E0028, E0033 |
| FLOW-006 | Established | HS (writer complete) | Reader VS | Frame, VS CSRs, `hgatp`, fences, `sscratch` | BOUNDARY-002, BOUNDARY-003 | Frame clear, CSR reset, VVMA, GVMA | TM-20260904-001-E0066, E0045 |
| FLOW-007 | Established | HS | OpenSBI console / shutdown | Stage markers, `HE_RESULT`, shutdown request | BOUNDARY-001 | HS-only origin; guest ECALL not proxied | TM-20260904-001-E0034 |
| FLOW-008 | Established | QEMU serial | Trace validator, evidence bundle, verifier | Log bytes, hashes, tool identities | BOUNDARY-004 | Exact-once ordered protocol; exact clean commit; hashes | TM-20260904-001-E0043, E0047 |
| FLOW-009 | Established | Source tree and host inputs | Image ELF | Source, flags, toolchain, linker script | BOUNDARY-004 | Makefile ownership, output confinement, two toolchains | TM-20260904-001-E0036, E0038 |
| FLOW-010 | Established | Responsible human | Public release | Gate commit changing `publication-gate.conf` | BOUNDARY-005 | Structural gate checks; status `blocked` | TM-20260904-001-E0039, E0040 |

## Entry points and attack surface

| Entry ID | Label | Entry point | Exposed to | Input or operation | Validation or mediation | Evidence IDs |
| --- | --- | --- | --- | --- | --- | --- |
| ENTRY-001 | Established | `_start` boot entry | ACTOR-004; any entering hart | `a0` hartid, `a1` FDT | `hartid != 0` fails after shared BSS clear and stack select | TM-20260904-001-E0018, E0019 |
| ENTRY-002 | Established | `stvec` trap vector | ACTOR-001, ACTOR-002, ACTOR-003 | Every VS exception and interrupt; trap CSRs; saved GPRs | SPV required; causes 10/21/23 only; interrupts disabled and terminal; stack swap first | TM-20260904-001-E0024, E0025 |
| ENTRY-003 | Established | G-stage translation of guest accesses | ACTOR-001, ACTOR-002, ACTOR-003 | Any guest-physical address, any access type | Policy-derived leaves; unmapped cross-private; R-only shared for reader | TM-20260904-001-E0028, E0029, E0031 |
| ENTRY-004 | Established | Guest-writable memory read by HS | ACTOR-001, ACTOR-003 | Sentinel and shared values | Volatile loads, value-equality checks only; no pointers or lengths from guest | TM-20260904-001-E0033 |
| ENTRY-005 | Established | Build and run environment | ACTOR-006, ACTOR-007 | `HE_TOOLCHAIN`, `QEMU`, `HE_OPENSBI_FIRMWARE`, `PATH`, Make goals | Version checks, output confinement, pinned container base, lockfile | TM-20260904-001-E0036, E0037, E0038 |
| ENTRY-006 | Established | Serial logs and evidence bundles fed to validators | ACTOR-006, ACTOR-007 | Log bytes, manifests, hashes | Exact-once protocol, exact-commit correspondence, hash checks | TM-20260904-001-E0043, E0047 |
| ENTRY-007 | Established | `publication-gate.conf` and gate commit | ACTOR-008, ACTOR-007 | Status, reviewed commit, time | Structural checker; `blocked` at R1 | TM-20260904-001-E0039, E0040 |
| ENTRY-008 | Established | Documentation and claim surface | ACTOR-009 | Wording reused downstream | Supported and prohibited wording list | TM-20260904-001-E0016 |
| ENTRY-009 | Established | Documentation preview HTTP server | Local processes; remote only by opt-in | GET/HEAD paths | Loopback default, path canonicalisation | TM-20260904-001-E0041 |

## Threat catalogue

Each threat record must include its fact label, STRIDE category, concrete
scenario and preconditions, linked assets/objectives/actors/surfaces,
controls, mitigations, inherent and residual likelihood/impact/risk with
rationale, uncertainty, confidence, evidence, status, alternatives, and
limitations.

### THREAT-001: Cross-subject private-page access through G-stage translation

- Fact label: Inferred
- STRIDE: Elevation of privilege; Information disclosure; Tampering
- Scenario: An adversarial payload running as the writer (or reader) loads or stores the other subject's private page GPA (`0x40004000` / `0x40003000`) expecting the walker to translate it.
- Preconditions: ACTOR-003 controls the VS instruction stream; the active root contains a leaf for the foreign private page, or policy grants it.
- Asset IDs: ASSET-005, ASSET-006
- Objective IDs: OBJECTIVE-002, OBJECTIVE-004
- Actor IDs: ACTOR-003
- Surface IDs: ENTRY-003, BOUNDARY-003, FLOW-004
- Existing control IDs: CONTROL-001, CONTROL-002, CONTROL-003, CONTROL-005
- Mitigation IDs: MITIGATION-002, MITIGATION-003
- Inherent likelihood: 4
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: Without policy-derived roots any VS access would succeed; a capable payload attempts it trivially.
- Residual likelihood: 1
- Residual impact: 4
- Residual risk: Low
- Residual rationale: No rule grants the access, no leaf exists (checked by `he_require_private_denial`), the fault is only accepted at the scripted PC and otherwise terminates the run; the maintained QEMU trace protocol is designed to fail if the scripted denial does not occur.
- Risk uncertainty: Depends on QEMU walker fidelity and HS-mode correctness; hardware `NOT RUN`; no run result was observed in this engagement.
- Confidence: Medium
- Evidence IDs: TM-20260904-001-E0028, TM-20260904-001-E0029, TM-20260904-001-E0030, TM-20260904-001-E0031, TM-20260904-001-E0043
- Status: Mitigated
- Alternatives and counter-evidence: Historical `PTE_U` advice would have broken accessible leaves; rejected (E0052).
- Limitations: Only the two scripted denials are exercised.

### THREAT-002: Reader modifies the shared page

- Fact label: Inferred
- STRIDE: Tampering
- Scenario: An adversarial reader stores to `0x40005000`, or uses an AMO, to alter the writer's published value or to influence what HS reads.
- Preconditions: ACTOR-003 as reader; reader root leaf for shared page has `W` set or policy grants write.
- Asset IDs: ASSET-007
- Objective IDs: OBJECTIVE-003, OBJECTIVE-004
- Actor IDs: ACTOR-003
- Surface IDs: ENTRY-003, FLOW-005, BOUNDARY-003
- Existing control IDs: CONTROL-001, CONTROL-002, CONTROL-005
- Mitigation IDs: MITIGATION-002
- Inherent likelihood: 4
- Inherent impact: 3
- Inherent risk: High
- Inherent rationale: Trivial for a hostile reader without an R-only leaf.
- Residual likelihood: 1
- Residual impact: 3
- Residual risk: Low
- Residual rationale: Reader rule is R-only; leaf lacks `W`; cause 23 is accepted only at the scripted PC when the leaf is readable and non-writable and the value is unchanged; any other store terminates.
- Risk uncertainty: Walker fidelity; HS correctness.
- Confidence: High
- Evidence IDs: TM-20260904-001-E0030, TM-20260904-001-E0031, TM-20260904-001-E0033, TM-20260904-001-E0044
- Status: Mitigated
- Alternatives and counter-evidence: None.
- Limitations: Emulator-only evidence.

### THREAT-003: Forged or out-of-order protocol events

- Fact label: Inferred
- STRIDE: Spoofing; Elevation of privilege
- Scenario: A payload issues ECALL with event `2` or `4` early, from a different PC, or under the wrong subject to skip the scripted denials and reach `HE_RESULT: PASS`.
- Preconditions: ACTOR-003 controls ECALL arguments and PCs.
- Asset IDs: ASSET-004, ASSET-009
- Objective IDs: OBJECTIVE-006
- Actor IDs: ACTOR-003
- Surface IDs: ENTRY-002, FLOW-003
- Existing control IDs: CONTROL-005, CONTROL-009
- Mitigation IDs: MITIGATION-004
- Inherent likelihood: 5
- Inherent impact: 4
- Inherent risk: Critical
- Inherent rationale: A value-only ABI would be forged in one instruction.
- Residual likelihood: 1
- Residual impact: 4
- Residual risk: Low
- Residual rationale: Each event is bound to an exact linked PC, subject and phase; two maintained negative images (early completion, skipped denial) are designed to require terminal failure under both toolchains.
- Risk uncertainty: Relies on linker placement matching the loaded image; no source-to-binary proof; negative-image results were not observed here.
- Confidence: Medium
- Evidence IDs: TM-20260904-001-E0026, TM-20260904-001-E0044
- Status: Mitigated
- Alternatives and counter-evidence: None.
- Limitations: PC binding is not a cryptographic binding; a payload that also controls the code page image is the build-compromise case (THREAT-014).

### THREAT-004: Register or CSR residue leaks writer state to reader

- Fact label: Inferred
- STRIDE: Information disclosure
- Scenario: Writer seeds GPRs and writable VS CSRs before completion; the reader observes them after the switch.
- Preconditions: Switch path fails to zero the frame or reset a VS CSR.
- Asset IDs: ASSET-008, ASSET-005
- Objective IDs: OBJECTIVE-005
- Actor IDs: ACTOR-001, ACTOR-002, ACTOR-003
- Surface IDs: FLOW-006, BOUNDARY-003
- Existing control IDs: CONTROL-004
- Mitigation IDs: MITIGATION-010
- Inherent likelihood: 5
- Inherent impact: 2
- Inherent risk: High
- Inherent rationale: Without clearing, residue is certain; impact is bounded to the writer's own values.
- Residual likelihood: 1
- Residual impact: 2
- Residual risk: Low
- Residual rationale: Frame is zeroed and VS CSRs reset before `SRET` in the source; the reader payload asserts the baseline; the maintained disassembly test is designed to check both toolchain images.
- Risk uncertainty: Optional CSRs (`htimedelta`), FP/vector state and microarchitectural state are outside the reset contract; test results were not observed here.
- Confidence: Medium
- Evidence IDs: TM-20260904-001-E0023, TM-20260904-001-E0066, TM-20260904-001-E0045, TM-20260904-001-E0051
- Status: Mitigated
- Alternatives and counter-evidence: Three historical reviews reported this before the current controls existed.
- Limitations: Timing and cache residue are non-goals (E0014).

### THREAT-005: Stale G-stage translation survives the root switch

- Fact label: Inferred
- STRIDE: Elevation of privilege; Information disclosure
- Scenario: Both roots use VMID 0; if translation caches were not invalidated, the reader could use writer translations (including the writer's private page).
- Preconditions: Missing or mis-ordered `HFENCE.GVMA`; or an implementation that ignores the fence.
- Asset IDs: ASSET-003, ASSET-005
- Objective IDs: OBJECTIVE-002, OBJECTIVE-005
- Actor IDs: ACTOR-003, ACTOR-005
- Surface IDs: FLOW-006, ENTRY-003, BOUNDARY-003
- Existing control IDs: CONTROL-003
- Mitigation IDs: MITIGATION-003
- Inherent likelihood: 4
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: Same-VMID reuse without invalidation is a classic stale-TLB failure.
- Residual likelihood: 1
- Residual impact: 4
- Residual risk: Low
- Residual rationale: `HFENCE.VVMA` then `hgatp` then all-address/all-VMID `HFENCE.GVMA` in the source order; AWB analysis identifies the fence, not selector readback, as the effective control; public spec summaries (secondary, E0064) state `HFENCE.GVMA x0,x0` covers all guest-physical addresses and all VMIDs.
- Risk uncertainty: Fence semantics not observed on hardware (`NOT RUN`); primary spec text was inaccessible (BLOCKED-001).
- Confidence: Medium
- Evidence IDs: TM-20260904-001-E0031, TM-20260904-001-E0066, TM-20260904-001-E0045, TM-20260904-001-E0056, TM-20260904-001-E0060, TM-20260904-001-E0064
- Status: Mitigated
- Alternatives and counter-evidence: Distinct VMIDs would add defence in depth; not implemented.
- Limitations: Public confirmation is from secondary summaries only; see `search-log.md` and `inaccessible-resources.md`.

### THREAT-006: Guest privileged or virtual instruction alters translation or escapes

- Fact label: Inferred
- STRIDE: Elevation of privilege
- Scenario: Payload executes `csrw satp`, `sfence.vma`, `sret` or `wfi` to change VS translation, stall, or return into an unexpected mode.
- Preconditions: VTVM/VTSR/VTW clear, or cause 22 handled by emulation.
- Asset IDs: ASSET-001, ASSET-003
- Objective IDs: OBJECTIVE-001, OBJECTIVE-006
- Actor IDs: ACTOR-003
- Surface IDs: ENTRY-002, BOUNDARY-002
- Existing control IDs: CONTROL-006, CONTROL-005, CONTROL-009
- Mitigation IDs: MITIGATION-004
- Inherent likelihood: 4
- Inherent impact: 3
- Inherent risk: High
- Inherent rationale: VS-mode `satp` changes only VS-stage translation, but combined with emulation bugs it is a classic escape path.
- Residual likelihood: 1
- Residual impact: 3
- Residual risk: Low
- Residual rationale: All three VT bits are set in the source, cause 22 is terminal, and four maintained negative images are designed to require exact reporting and failure under both toolchains.
- Risk uncertainty: Emulator fidelity; negative-image results were not observed here.
- Confidence: Medium
- Evidence IDs: TM-20260904-001-E0063, TM-20260904-001-E0025, TM-20260904-001-E0044
- Status: Mitigated
- Alternatives and counter-evidence: Historical reviews found VT bits cleared; stale at R1 (E0051).
- Limitations: Other virtual-instruction sources are also terminal but untested.

### THREAT-007: Guest forces termination (availability)

- Fact label: Established
- STRIDE: Denial of service
- Scenario: Any unexpected trap, illegal instruction or wrong event ends the experiment with `HE_RESULT: FAIL` and shutdown.
- Preconditions: ACTOR-003 issues any non-scripted trap.
- Asset IDs: ASSET-009
- Objective IDs: OBJECTIVE-006
- Actor IDs: ACTOR-003
- Surface IDs: ENTRY-002
- Existing control IDs: CONTROL-005
- Mitigation IDs: MITIGATION-004
- Inherent likelihood: 5
- Inherent impact: 1
- Inherent risk: Moderate
- Inherent rationale: Trivially triggered; availability is an explicit non-goal.
- Residual likelihood: 5
- Residual impact: 1
- Residual risk: Moderate
- Residual rationale: Fail-closed is the intended design; the consequence is a correctly reported failure, not a security violation.
- Risk uncertainty: None material.
- Confidence: High
- Evidence IDs: TM-20260904-001-E0011, TM-20260904-001-E0025, TM-20260904-001-E0034
- Status: Out of scope
- Alternatives and counter-evidence: None.
- Limitations: Recorded for coverage; not a finding.

### THREAT-008: HS-mode C defect corrupts policy or control state

- Fact label: Inferred
- STRIDE: Tampering; Elevation of privilege
- Scenario: A latent bug in trap handling or mapping code (out-of-bounds write, stack overflow, logic error) driven by attacker-controlled trap inputs overwrites sealed labels, rules, tables or phase state, since all are ordinary writable HS memory with no stack protector.
- Preconditions: Exploitable defect reachable from the three accepted trap paths.
- Asset IDs: ASSET-001, ASSET-002, ASSET-003, ASSET-004
- Objective IDs: OBJECTIVE-001, OBJECTIVE-004
- Actor IDs: ACTOR-003
- Surface IDs: ENTRY-002, ENTRY-004, BOUNDARY-002
- Existing control IDs: CONTROL-005, CONTROL-001
- Mitigation IDs: MITIGATION-004, MITIGATION-005, MITIGATION-009
- Inherent likelihood: 3
- Inherent impact: 5
- Inherent risk: High
- Inherent rationale: Any HS write primitive defeats every objective; C without memory-safety proof plausibly contains defects.
- Residual likelihood: 2
- Residual impact: 5
- Residual risk: High
- Residual rationale: The attack surface is narrow (fixed-size frame, no guest pointers or lengths consumed, no dynamic allocation, no recursion, value-equality checks only) and several review rounds exist, but no proof, protection or hardening reduces impact; residual remains `High` on impact alone.
- Risk uncertainty: No memory-safety analysis at R1; later CBMC lineage does not apply.
- Confidence: Medium
- Evidence IDs: TM-20260904-001-E0012, TM-20260904-001-E0062, TM-20260904-001-E0033, TM-20260904-001-E0035, TM-20260904-001-E0051, TM-20260904-001-E0057
- Status: Partially mitigated
- Alternatives and counter-evidence: The maintained ledger rejected stack-protector findings as inapplicable to the freestanding profile; this model treats the absence as a residual, not a defect.
- Limitations: No concrete defect was identified; this is a class threat.

### THREAT-009: Trap from unexpected origin or interrupt reaches HS

- Fact label: Inferred
- STRIDE: Spoofing
- Scenario: An HS-origin trap (SPV clear) or an interrupt is mistaken for a VS event and drives the state machine.
- Preconditions: Interrupt enabled, or HS code faults internally.
- Asset IDs: ASSET-004
- Objective IDs: OBJECTIVE-001, OBJECTIVE-006
- Actor IDs: ACTOR-004, ACTOR-005
- Surface IDs: ENTRY-002
- Existing control IDs: CONTROL-005, CONTROL-006
- Mitigation IDs: MITIGATION-004
- Inherent likelihood: 2
- Inherent impact: 3
- Inherent risk: Moderate
- Inherent rationale: Requires firmware or emulator behaviour outside the documented profile.
- Residual likelihood: 1
- Residual impact: 3
- Residual risk: Low
- Residual rationale: SPV is checked first; `sie`/`hvip` are zero; all interrupts terminate.
- Risk uncertainty: None material.
- Confidence: High
- Evidence IDs: TM-20260904-001-E0020, TM-20260904-001-E0025
- Status: Mitigated
- Alternatives and counter-evidence: None.
- Limitations: Nested traps are unsupported by design.

### THREAT-010: Policy-to-PTE divergence undetected by readback

- Fact label: Inferred
- STRIDE: Tampering
- Scenario: A derivation bug or later HS write makes a PTE grant more than the sealed TE decision; the readback shares the same code, constants and memory and would agree with itself, or the mutation occurs after the check.
- Preconditions: Correlated defect in mapper and checker, or post-check mutation (see THREAT-008).
- Asset IDs: ASSET-002, ASSET-003
- Objective IDs: OBJECTIVE-004
- Actor IDs: ACTOR-003
- Surface IDs: ENTRY-003, FLOW-002
- Existing control IDs: CONTROL-002, CONTROL-001
- Mitigation IDs: MITIGATION-002, MITIGATION-004
- Inherent likelihood: 3
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: Encoding bugs are common; consequence is silent over-permission.
- Residual likelihood: 2
- Residual impact: 4
- Residual risk: Moderate
- Residual rationale: Readback, cross-private absence check, 48-decision authority report and host unit tests catch independent errors, but PRV shows no divergence test and a shared trust domain.
- Risk uncertainty: No maintained test mutates a PTE to prove the check fires.
- Confidence: Medium
- Evidence IDs: TM-20260904-001-E0031, TM-20260904-001-E0042, TM-20260904-001-E0055
- Status: Partially mitigated
- Alternatives and counter-evidence: None.
- Limitations: Software-memory readback is not effective-translation evidence (E0056).

### THREAT-011: Multiple harts race shared boot state

- Fact label: Inferred
- STRIDE: Tampering; Denial of service
- Scenario: If more than one hart enters `_start`, each clears BSS and uses the same trusted stack before `he_main` rejects `hartid != 0`, corrupting HS state or the result.
- Preconditions: Platform launches more than one hart (outside the fixed `-smp 1` profile).
- Asset IDs: ASSET-001
- Objective IDs: OBJECTIVE-001
- Actor IDs: ACTOR-005, ACTOR-006
- Surface IDs: ENTRY-001, FLOW-001
- Existing control IDs: CONTROL-007
- Mitigation IDs: MITIGATION-001
- Inherent likelihood: 3
- Inherent impact: 3
- Inherent risk: Moderate
- Inherent rationale: Plausible on real hardware or a misconfigured launch.
- Residual likelihood: 1
- Residual impact: 3
- Residual risk: Low
- Residual rationale: The supported profile fixes one hart and multicore is a documented non-goal; within scope the race cannot occur.
- Risk uncertainty: Behaviour on hardware unknown; K3 `NOT RUN`.
- Confidence: High
- Evidence IDs: TM-20260904-001-E0010, TM-20260904-001-E0019, TM-20260904-001-E0037
- Status: Partially mitigated
- Alternatives and counter-evidence: None.
- Limitations: Becomes material if the profile is widened.

### THREAT-012: Covert or side-channel flow between subjects

- Fact label: Established
- STRIDE: Information disclosure
- Scenario: Writer conveys information to reader through cache, timing or the shared page beyond the intended value.
- Preconditions: None; the shared page is an intentional channel.
- Asset IDs: ASSET-005, ASSET-007
- Objective IDs: OBJECTIVE-002
- Actor IDs: ACTOR-001, ACTOR-002
- Surface IDs: FLOW-005, BOUNDARY-003
- Existing control IDs: CONTROL-013
- Mitigation IDs: MITIGATION-004
- Inherent likelihood: 5
- Inherent impact: 1
- Inherent risk: Moderate
- Inherent rationale: Certain, but no noninterference objective exists.
- Residual likelihood: 5
- Residual impact: 1
- Residual risk: Moderate
- Residual rationale: Explicit non-goal; documented; prohibited wording forbids a noninterference claim.
- Risk uncertainty: None.
- Confidence: High
- Evidence IDs: TM-20260904-001-E0011, TM-20260904-001-E0014, TM-20260904-001-E0016
- Status: Out of scope
- Alternatives and counter-evidence: None.
- Limitations: Recorded for coverage.

### THREAT-013: Fabricated self-consistent evidence yields a false PASS record

- Fact label: Inferred
- STRIDE: Repudiation; Tampering
- Scenario: A compromised host or producer substitutes QEMU/firmware, edits serial logs, or generates a bundle whose hashes, tool identities and traces are internally consistent, so `verify-evidence.sh` accepts it although the image never behaved as recorded.
- Preconditions: ACTOR-007 controls the producing host or its tools.
- Asset IDs: ASSET-009, ASSET-010
- Objective IDs: OBJECTIVE-006, OBJECTIVE-007
- Actor IDs: ACTOR-007
- Surface IDs: ENTRY-005, ENTRY-006, FLOW-008, BOUNDARY-004
- Existing control IDs: CONTROL-010, CONTROL-011, CONTROL-008
- Mitigation IDs: MITIGATION-007
- Inherent likelihood: 3
- Inherent impact: 4
- Inherent risk: High
- Inherent rationale: Any party with host control can fabricate; consequence is a false assurance record used downstream.
- Residual likelihood: 3
- Residual impact: 4
- Residual risk: High
- Residual rationale: Integrity and correspondence checks stop accidental drift but the target's own documentation admits a self-consistent false bundle is possible; no attestation or independent reproduction exists.
- Risk uncertainty: Likelihood depends on the threat environment of the producing host, which is not recorded.
- Confidence: Medium
- Evidence IDs: TM-20260904-001-E0017, TM-20260904-001-E0043, TM-20260904-001-E0047, TM-20260904-001-E0048, TM-20260904-001-E0049
- Status: Open
- Alternatives and counter-evidence: Independent re-execution by a second evaluator would detect fabrication; not part of the maintained flow.
- Limitations: Committed bundle bytes were not examined in this engagement.

### THREAT-014: Supply-chain compromise of build or platform inputs

- Fact label: Inferred
- STRIDE: Tampering
- Scenario: A malicious toolchain, QEMU, OpenSBI, container base or npm package alters the image, the emulator's behaviour, or documentation output so that the fixed experiment passes while the source no longer describes the binary.
- Preconditions: ACTOR-007 upstream of the digest-pinned base or of `PATH`-resolved tools.
- Asset IDs: ASSET-011, ASSET-001
- Objective IDs: OBJECTIVE-001, OBJECTIVE-007
- Actor IDs: ACTOR-007
- Surface IDs: ENTRY-005, FLOW-009, BOUNDARY-004
- Existing control IDs: CONTROL-014, CONTROL-010
- Mitigation IDs: MITIGATION-007
- Inherent likelihood: 2
- Inherent impact: 5
- Inherent risk: High
- Inherent rationale: Substantial prerequisites; consequence is total.
- Residual likelihood: 2
- Residual impact: 5
- Residual risk: High
- Residual rationale: Digest-pinned base, lockfile integrity, two independent toolchains, recorded tool hashes and version checks raise the bar and make single-tool compromise detectable, but do not authenticate tools and cannot reduce the consequence of a successful compromise, which remains total loss of source-to-binary trust; impact therefore stays at 5.
- Risk uncertainty: Transitive npm closure size unknown; whether two-toolchain divergence detection is exercised on every run is not observed here.
- Confidence: Medium
- Evidence IDs: TM-20260904-001-E0036, TM-20260904-001-E0037, TM-20260904-001-E0038, TM-20260904-001-E0043
- Status: Partially mitigated
- Alternatives and counter-evidence: None.
- Limitations: No source-to-binary correspondence (E0062).

### THREAT-015: Publication approval without the responsible human

- Fact label: Inferred
- STRIDE: Spoofing; Repudiation
- Scenario: Any party with commit access authors a well-formed gate commit setting `status=approved`; the checker validates structure only and cannot distinguish the responsible human from another committer or from automation.
- Preconditions: Write access to the repository; H6/H7 records absent or unverified.
- Asset IDs: ASSET-010
- Objective IDs: OBJECTIVE-007
- Actor IDs: ACTOR-007, ACTOR-008
- Surface IDs: ENTRY-007, FLOW-010, BOUNDARY-005
- Existing control IDs: CONTROL-012
- Mitigation IDs: MITIGATION-006, MITIGATION-008
- Inherent likelihood: 3
- Inherent impact: 3
- Inherent risk: Moderate
- Inherent rationale: Trivial for an insider; consequence is unauthorised public exposure of an unreviewed PoC.
- Residual likelihood: 2
- Residual impact: 3
- Residual risk: Moderate
- Residual rationale: Gate is currently `blocked`, structural checks prevent accidental or sloppy approval, and policy names the human, but identity is procedural.
- Risk uncertainty: Repository access controls are outside the evidence.
- Confidence: Medium
- Evidence IDs: TM-20260904-001-E0039, TM-20260904-001-E0040, TM-20260904-001-E0052
- Status: Partially mitigated
- Alternatives and counter-evidence: Maintainers intentionally chose procedural identity (E0052).
- Limitations: None.

### THREAT-016: Assurance-claim inflation and lineage misattribution

- Fact label: Inferred
- STRIDE: Repudiation; Information disclosure
- Scenario: A downstream consumer or automation attributes to commit `1ab289c…` properties that belong to a later lineage (CBMC-checked properties, eight negative images, trap-snapshot capture) or restates the PoC as "formally verified" or "proven"; historical review packages for other commits are cited as review of this commit.
- Preconditions: Reader does not bind claims to exact revision; worktrees or documents from later lineages are present alongside.
- Asset IDs: ASSET-010
- Objective IDs: OBJECTIVE-007
- Actor IDs: ACTOR-009
- Surface IDs: ENTRY-008, BOUNDARY-005
- Existing control IDs: CONTROL-013, CONTROL-010
- Mitigation IDs: MITIGATION-006, MITIGATION-007
- Inherent likelihood: 4
- Inherent impact: 3
- Inherent risk: High
- Inherent rationale: This engagement itself observed the target worktree switched to a later lineage mid-analysis (E0004); misattribution is likely without discipline.
- Residual likelihood: 3
- Residual impact: 3
- Residual risk: Moderate
- Residual rationale: Supported/prohibited wording and exact-commit evidence binding exist, but nothing prevents a consumer from mixing lineages; the parent HANDOFF already carries CBMC wording that must be bounded carefully. Score 9 is the upper bound of `Moderate`; treated as the most pressing human-factor risk.
- Risk uncertainty: Depends on consumer behaviour.
- Confidence: Medium
- Evidence IDs: TM-20260904-001-E0004, TM-20260904-001-E0005, TM-20260904-001-E0062, TM-20260904-001-E0016, TM-20260904-001-E0050, TM-20260904-001-E0053, TM-20260904-001-E0058
- Status: Open
- Alternatives and counter-evidence: None.
- Limitations: Human-factor threat; not addressable by target code.

### THREAT-017: Platform reports `htval = 0` and fault recovery cannot proceed

- Fact label: Inferred
- STRIDE: Denial of service
- Scenario: On an implementation that legitimately leaves `htval` zero, `he_validate_fault_address` rejects the scripted denial and the run fails although isolation held.
- Preconditions: Non-QEMU platform or QEMU configuration without GPA reporting.
- Asset IDs: ASSET-009
- Objective IDs: OBJECTIVE-006
- Actor IDs: ACTOR-005
- Surface IDs: FLOW-004
- Existing control IDs: CONTROL-005
- Mitigation IDs: MITIGATION-003
- Inherent likelihood: 2
- Inherent impact: 1
- Inherent risk: Low
- Inherent rationale: Portability failure that fails closed.
- Residual likelihood: 2
- Residual impact: 1
- Residual risk: Low
- Residual rationale: Fail-closed by design; only the documented QEMU profile is claimed. Public spec summaries (secondary, E0065) state that Priv v1.12 permits `htval` to be written as zero when the GPA is not known, so this is a real portability limit, not a defect in the model.
- Risk uncertainty: Hardware behaviour unknown; primary spec text inaccessible (BLOCKED-001).
- Confidence: High
- Evidence IDs: TM-20260904-001-E0027, TM-20260904-001-E0051, TM-20260904-001-E0065
- Status: Open
- Alternatives and counter-evidence: None.
- Limitations: Documentation limit acknowledged by maintainers.

### THREAT-018: Documentation preview server exposed beyond loopback

- Fact label: Inferred
- STRIDE: Information disclosure
- Scenario: The preview server is started with the remote-bind opt-in on a shared network, and a remote network peer (ACTOR-010) reads unpublished documentation.
- Preconditions: Operator (ACTOR-006) opts in to remote binding; a network-adjacent party can reach the host.
- Asset IDs: ASSET-010
- Objective IDs: OBJECTIVE-007
- Actor IDs: ACTOR-006, ACTOR-010
- Surface IDs: ENTRY-009
- Existing control IDs: CONTROL-014
- Mitigation IDs: MITIGATION-007
- Inherent likelihood: 2
- Inherent impact: 2
- Inherent risk: Low
- Inherent rationale: Requires deliberate opt-in; content is documentation only.
- Residual likelihood: 1
- Residual impact: 2
- Residual risk: Low
- Residual rationale: Loopback default, GET/HEAD only, path canonicalisation.
- Risk uncertainty: None material.
- Confidence: High
- Evidence IDs: TM-20260904-001-E0041
- Status: Mitigated
- Alternatives and counter-evidence: None.
- Limitations: Host-tool surface only.

## Attack trees and abuse cases

### ATTACK-001: Hostile linked payload defeats the fixed experiment

- Goal: As ACTOR-003, read or write the other subject's private page, tamper with the shared page as reader, or obtain `HE_RESULT: PASS` without performing the scripted denials.
- Preconditions: Attacker replaces `src/guest.S` content (or the guest code page) while the monitor is unchanged.
- Branches:
  1. Direct foreign access via G-stage (THREAT-001, THREAT-002) — blocked by CONTROL-001/002/003.
  2. Protocol forgery: early or mis-PC ECALL (THREAT-003) — blocked by CONTROL-005, checked by CONTROL-009.
  3. Privileged/virtual instruction (`satp`, `sfence.vma`, `sret`, `wfi`) (THREAT-006) — blocked by CONTROL-006.
  4. Stale translation after root switch (THREAT-005) — blocked by CONTROL-003.
  5. Residue harvesting as reader (THREAT-004) — blocked by CONTROL-004.
  6. Trigger an HS-mode defect via trap inputs (THREAT-008, THREAT-010) — only partially mitigated; the sole surviving branch.
- Boundary crossings: BOUNDARY-002, BOUNDARY-003.
- Success condition: Any branch yields foreign data, altered shared value, or PASS without denials.
- Affected objectives: OBJECTIVE-001 through OBJECTIVE-006.
- Unknowns: Existence of an exploitable HS defect (no analysis at R1); hardware behaviour.
- Evidence IDs: TM-20260904-001-E0025, TM-20260904-001-E0026, TM-20260904-001-E0030, TM-20260904-001-E0066, TM-20260904-001-E0035, TM-20260904-001-E0044.
- Diagram: `diagrams/attack-tree-001.dot`.

### ATTACK-002: A false or inflated assurance claim about this commit reaches consumers

- Goal: As ACTOR-007 or ACTOR-009, cause a downstream party to treat `1ab289c…` as verified, hardware-validated, or independently reviewed when it is not.
- Preconditions: Access to the producing host, the repository, or only to documents and later-lineage artefacts.
- Branches:
  1. Fabricate a self-consistent evidence bundle (THREAT-013) — CONTROL-010 detects inconsistency only.
  2. Compromise build or platform inputs so the binary diverges from source (THREAT-014) — CONTROL-014 partially.
  3. Author a structurally valid gate approval without the responsible human (THREAT-015) — CONTROL-012 partially; currently `blocked`.
  4. Cite historical review packages (other commits, no provenance) as review of this commit (THREAT-016) — CONTROL-013 partially.
  5. Attribute later CBMC or eight-image lineage to this commit (THREAT-016) — CONTROL-013 partially; observed hazard E0004.
  6. Bypass the publication gate entirely by distributing the repository, rendered docs, or a preview-server URL outside the gated site (THREAT-018, THREAT-015) — no target control; the gate governs only the maintained publication path.
- Boundary crossings: BOUNDARY-004, BOUNDARY-005.
- Success condition: A consumer relies on an unsupported claim.
- Affected objectives: OBJECTIVE-007.
- Unknowns: Producer host threat environment; downstream consumers' revision discipline; repository access controls.
- Evidence IDs: TM-20260904-001-E0004, TM-20260904-001-E0062, TM-20260904-001-E0016, TM-20260904-001-E0017, TM-20260904-001-E0040, TM-20260904-001-E0041, TM-20260904-001-E0050, TM-20260904-001-E0052.
- Diagram: `diagrams/attack-tree-002.dot`.

## Existing controls

| Control ID | Label | Control | Threat IDs | Evidence IDs | Effectiveness | Confidence | Limitations |
| --- | --- | --- | --- | --- | --- | --- | --- |
| CONTROL-001 | Established | Default-deny six-rule TE policy with one-rule complete matching, sealed after labelling; `open` required on every rule | THREAT-001, THREAT-002, THREAT-008, THREAT-010 | TM-20260904-001-E0030, E0042, E0054 | High within the fixed policy | High | Policy is writable HS data (E0012); one-rule semantics have no external precedent (E0054) |
| CONTROL-002 | Established | Policy-derived leaf permissions, PTE readback against TE decisions, cross-private leaf absence check, before activation | THREAT-001, THREAT-002, THREAT-010 | TM-20260904-001-E0029, E0031, E0042 | Medium: detects independent errors, not correlated ones | High | Same trust domain as mapper; one-time; software memory only (E0055) |
| CONTROL-003 | Established | Separate G-stage roots; `HFENCE.VVMA`, `hgatp` write, all-VMID `HFENCE.GVMA` on switch | THREAT-001, THREAT-005 | TM-20260904-001-E0066, E0045, E0056 | High in QEMU | Medium | Both roots VMID 0; emulator evidence only |
| CONTROL-004 | Established | Trap-frame zeroing, VS CSR reset, `sscratch` stack swap, guest entry-state assertions | THREAT-004 | TM-20260904-001-E0023, E0024, E0066, E0045 | High for GPR and listed CSRs | High | Optional CSRs, FP/vector, microarchitectural state excluded |
| CONTROL-005 | Established | Fail-closed trap handling: SPV required; causes 10/21/23 only; exact PC, subject, phase, GPA (`stval == htval<<2`) and unchanged-value checks; four-byte advance; `he_fail` otherwise | THREAT-001, THREAT-002, THREAT-003, THREAT-006, THREAT-007, THREAT-008, THREAT-009, THREAT-017 | TM-20260904-001-E0025, E0026, E0027, E0033 | High | High | Fixed protocol; `htval` population assumed |
| CONTROL-006 | Established | `hedeleg`/`hideleg`/`sie`/`hvip`/`hcounteren` zero; `VTVM`, `VTSR`, `VTW` set | THREAT-006, THREAT-009 | TM-20260904-001-E0020, E0063, E0045 | High | High | `htimedelta` not initialised (E0021) |
| CONTROL-007 | Established | `hartid != 0` rejection in `he_main` | THREAT-011 | TM-20260904-001-E0019 | Low as a multicore gate | High | Executes after shared BSS clear and stack select |
| CONTROL-008 | Established | HS-only serial output; guest ECALL not proxied; exact-once ordered marker validator | THREAT-013 | TM-20260904-001-E0034, E0043 | High against guest forgery; none against host forgery | High | Host capture trusted |
| CONTROL-009 | Established | Six negative payload images under both toolchains with exact failure protocol | THREAT-003, THREAT-006 | TM-20260904-001-E0044 | Medium: six cases | High | Not adversarial fuzzing |
| CONTROL-010 | Established | Evidence generation and read-only verifier bound to exact clean commit with hashes and tool identities; review-manifest linter | THREAT-013, THREAT-014, THREAT-016 | TM-20260904-001-E0047, E0049 | Medium: integrity and correspondence only | High | Producer attestation; no authenticity (E0017) |
| CONTROL-011 | Established | Rootless evaluator: no network, read-only source, copied work, hidden overlays, no capabilities | THREAT-013 | TM-20260904-001-E0048 | Medium | High | Podman/kernel trusted |
| CONTROL-012 | Established | Publication gate `blocked`; structural checker; policy assigns approval to the responsible human | THREAT-015 | TM-20260904-001-E0039, E0040 | Medium | High | Identity procedural; H6/H7 open (E0052) |
| CONTROL-013 | Established | Documented claim boundary with supported and prohibited wording | THREAT-012, THREAT-016 | TM-20260904-001-E0005, E0016 | Low to Medium (documentation) | High | No enforcement |
| CONTROL-014 | Established | Makefile-owned build graph, output confinement, digest-pinned container base, lockfile integrity, two toolchains, loopback-default preview | THREAT-014, THREAT-018 | TM-20260904-001-E0036, E0038, E0041 | Medium | High | Host and upstream trusted |

## Mitigation and verification plan

| Mitigation ID | Label | Mitigation | Threat IDs | Verification approach | Owner | Status | Evidence IDs |
| --- | --- | --- | --- | --- | --- | --- | --- |
| MITIGATION-001 | Proposed | Move the hart gate into `_start` before BSS clear and stack select (park non-zero harts in `WFI`), or document the launch-time single-hart requirement as load-bearing | THREAT-011 | Disassembly test asserting the gate precedes the first store; QEMU run with `-smp 2` expecting `FAIL` or park | Helium maintainers | Open | TM-20260904-001-E0019 |
| MITIGATION-002 | Proposed | Add a direct divergence negative test that mutates one PTE bit after mapping and asserts `he_map_or_fail` terminates | THREAT-001, THREAT-002, THREAT-010 | New negative image or host unit test | Helium maintainers | Open | TM-20260904-001-E0055 |
| MITIGATION-003 | Proposed | Execute the fixed experiment on at least one physical RISC-V H-extension platform; document `htval` behaviour | THREAT-001, THREAT-005, THREAT-011, THREAT-017 | Hardware run record with tool identities | Helium maintainers; hardware owner | Open | TM-20260904-001-E0027, E0053 |
| MITIGATION-004 | Proposed | Bounded machine checking of `he_te_authorize`, `he_mapping_permissions`, `he_handle_ecall` dispatch and fault validation at this exact revision, with unwinding assertions | THREAT-003, THREAT-006, THREAT-007, THREAT-008, THREAT-009, THREAT-010, THREAT-012 | CBMC harness committed at the target revision with recorded bounds | Helium maintainers | Open | TM-20260904-001-E0062, E0058 |
| MITIGATION-005 | Proposed | Trusted-stack guard page or static stack-depth bound analysis for the HS trap path | THREAT-008 | Linker-script guard with negative test, or documented bound | Helium maintainers | Open | TM-20260904-001-E0035 |
| MITIGATION-006 | Proposed | Complete responsible-human H6 source review of `1ab289c…` and record it | THREAT-015, THREAT-016 | Human record referenced by `docs/review-remediation.md` | Responsible human | Open | TM-20260904-001-E0052 |
| MITIGATION-007 | Proposed | Mark historical review packages as non-provenance inputs; require contemporaneous manifests for any future package; consider independent re-execution by a second evaluator | THREAT-013, THREAT-014, THREAT-016, THREAT-018 | Manifest lint on future packages; second-evaluator bundle hash comparison | Helium maintainers | Open | TM-20260904-001-E0049, E0050 |
| MITIGATION-008 | Proposed | Require a signed gate commit (or equivalent out-of-band authentication) for `status=approved` | THREAT-015 | Checker rejects unsigned approval | Responsible human; maintainers | Open | TM-20260904-001-E0040 |
| MITIGATION-009 | Proposed | Place sealed policy and label arrays in a region made read-only after seal, or copy them into a checksummed shadow re-validated in each trap | THREAT-008 | Negative test writing to sealed policy after seal | Helium maintainers | Open | TM-20260904-001-E0012 |
| MITIGATION-010 | Proposed | Initialise `htimedelta` and document the optional-CSR baseline | THREAT-004 | Disassembly test | Helium maintainers | Open | TM-20260904-001-E0021 |

## Assumptions and non-goals

### ASSUMPTION-001: Assurance ceiling is review-and-test

- Kind: Environmental constraint and explicit claim limit.
- Statement (`Established`): Helium is a review-and-test PoC; not formally verified; not hardware validated; no CBMC harness at R1. Beryllium accepted through R7, R8-H0 committed and not accepted, K3 `NOT RUN`.
- If false: nothing in this model changes technically; claim-inflation risk would fall.
- Check: TM-20260904-001-E0003, E0005, E0062, E0053.

### ASSUMPTION-002: Firmware is honest

- Kind: Dependency condition.
- Statement: The target *assumes* (`Established` that the assumption is made, E0010, E0034) that OpenSBI performs the handoff, console and shutdown correctly and does not alter HS state. Whether the assumption is *true* is `Unknown`: no behavioural verification of the firmware was found.
- If false: every objective fails; `HE_RESULT` could be forged at M-mode.
- Check: Firmware hash is recorded in evidence (E0043); no behavioural verification. TM-20260904-001-E0010, E0034.

### ASSUMPTION-003: QEMU 10.2.2 implements the H-extension as ratified

- Kind: Dependency condition.
- Statement: The target *assumes* (`Established` that the assumption is made, E0010, E0037) that CSR effects, G-stage walker, fence semantics and trap routing in QEMU match the ratified specification. Whether it is *true* is `Unknown`: no conformance evidence was admitted and hardware is `NOT RUN`.
- If false: controls may appear to hold in QEMU while failing on hardware.
- Check: Hardware run (MITIGATION-003). TM-20260904-001-E0010, E0037, E0060.

### ASSUMPTION-004: All-VMID `HFENCE.GVMA` invalidates every cached G-stage translation

- Kind: Dependency condition.
- Statement (`Inferred`): The fence sequence in FLOW-006 leaves no writer translation usable by the reader. Secondary public summaries of the Privileged specification agree that `HFENCE.GVMA x0,x0` covers all guest-physical addresses and all VMIDs (E0064); primary text was inaccessible (BLOCKED-001).
- If false: THREAT-005 becomes live.
- Check: Primary specification clause (blocked in this engagement); hardware run. TM-20260904-001-E0066, E0056, E0064.

### ASSUMPTION-005: The fixed-profile non-goals hold

- Kind: Explicit non-goals.
- Statement (`Established`): One hart, no interrupts, no timers, no devices, no DMA, no side-channel or noninterference objective, no arbitrary guests, one one-way switch.
- If false: THREAT-007, THREAT-011, THREAT-012 change status; new surfaces appear.
- Check: TM-20260904-001-E0011, E0013, E0014.

### ASSUMPTION-006: Historical review packages are not evidence about R1

- Kind: Evidentiary constraint.
- Statement (`Established`): The five `agent-review/` packages reviewed other commits without verified provenance; they inform surfaces but establish nothing about this revision.
- If false (a package is later shown to cover R1 with provenance): confidence in several controls could rise.
- Check: TM-20260904-001-E0050, E0052.

### ASSUMPTION-007: HS-mode C is the root of trust, not TE

- Kind: Unresolved premise about assurance strategy.
- Statement (`Inferred`): TE and readback provide structure, but isolation ultimately rests on the correctness of every HS instruction; no mechanism protects policy state from HS defects.
- If false: nothing; this is conservative.
- Check: TM-20260904-001-E0012, E0054, E0057.

### ASSUMPTION-008: Tier 5 planning records are contextual only

- Kind: Evidentiary constraint.
- Statement (`Established`): Beryllium transcripts and research components explain rationale and precedent; they carry `unknown` redistribution and are not target evidence.
- If false: none technically; affects distribution eligibility.
- Check: TM-20260904-001-E0002, E0061.

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
| OBJECTIVE-001 | Objective | THREAT-006, THREAT-008, THREAT-009, THREAT-011, THREAT-014 | Complete | TM-20260904-001-E0007 | HS-defect class threat only partially mitigated |
| OBJECTIVE-002 | Objective | THREAT-001, THREAT-005, THREAT-012 | Complete | TM-20260904-001-E0007 | Side channels out of scope |
| OBJECTIVE-003 | Objective | THREAT-002 | Complete | TM-20260904-001-E0007 | Emulator evidence |
| OBJECTIVE-004 | Objective | THREAT-001, THREAT-002, THREAT-008, THREAT-010 | Complete | TM-20260904-001-E0031 | No divergence test |
| OBJECTIVE-005 | Objective | THREAT-004, THREAT-005 | Complete | TM-20260904-001-E0066 | Optional CSR state |
| OBJECTIVE-006 | Objective | THREAT-003, THREAT-006, THREAT-007, THREAT-009, THREAT-013, THREAT-017 | Complete | TM-20260904-001-E0034 | Host honesty assumed |
| OBJECTIVE-007 | Objective | THREAT-013, THREAT-014, THREAT-015, THREAT-016, THREAT-018 | Complete | TM-20260904-001-E0016 | Procedural controls |
| ASSET-001 | Asset | THREAT-006, THREAT-008, THREAT-011, THREAT-014 | Complete | TM-20260904-001-E0009 | — |
| ASSET-002 | Asset | THREAT-008, THREAT-010 | Complete | TM-20260904-001-E0030 | Writable HS data |
| ASSET-003 | Asset | THREAT-005, THREAT-006, THREAT-008, THREAT-010 | Complete | TM-20260904-001-E0029 | — |
| ASSET-004 | Asset | THREAT-003, THREAT-008, THREAT-009 | Complete | TM-20260904-001-E0026 | — |
| ASSET-005 | Asset | THREAT-001, THREAT-004, THREAT-005, THREAT-012 | Complete | TM-20260904-001-E0028 | — |
| ASSET-006 | Asset | THREAT-001 | Complete | TM-20260904-001-E0028 | — |
| ASSET-007 | Asset | THREAT-002, THREAT-012 | Complete | TM-20260904-001-E0028 | Intentional channel |
| ASSET-008 | Asset | THREAT-004 | Complete | TM-20260904-001-E0024 | — |
| ASSET-009 | Asset | THREAT-003, THREAT-007, THREAT-013, THREAT-017 | Complete | TM-20260904-001-E0034 | — |
| ASSET-010 | Asset | THREAT-013, THREAT-015, THREAT-016, THREAT-018 | Complete | TM-20260904-001-E0039 | — |
| ASSET-011 | Asset | THREAT-014 | Complete | TM-20260904-001-E0038 | Transitive closure unknown |
| ACTOR-001 | Actor | THREAT-004, THREAT-012 (cooperative; adversarial capability modelled as ACTOR-003) | Complete | TM-20260904-001-E0013 | — |
| ACTOR-002 | Actor | THREAT-004, THREAT-012 (as ACTOR-001) | Complete | TM-20260904-001-E0013 | — |
| ACTOR-003 | Actor | THREAT-001, THREAT-002, THREAT-003, THREAT-004, THREAT-005, THREAT-006, THREAT-007, THREAT-008, THREAT-010 | Complete | TM-20260904-001-E0008 | — |
| ACTOR-004 | Actor | THREAT-009; otherwise trusted by ASSUMPTION-002 | Complete | TM-20260904-001-E0034 | Trust not evidenced |
| ACTOR-005 | Actor | THREAT-005, THREAT-009, THREAT-011, THREAT-017; otherwise trusted by ASSUMPTION-003 | Complete | TM-20260904-001-E0010 | Emulator only |
| ACTOR-006 | Actor | THREAT-011, THREAT-018 | Complete | TM-20260904-001-E0037 | — |
| ACTOR-007 | Actor | THREAT-013, THREAT-014, THREAT-015 | Complete | TM-20260904-001-E0017 | Host threat environment unknown |
| ACTOR-008 | Actor | THREAT-015 | Complete | TM-20260904-001-E0040 | — |
| ACTOR-009 | Actor | THREAT-016 | Complete | TM-20260904-001-E0016 | — |
| ACTOR-010 | Actor | THREAT-018 | Complete | TM-20260904-001-E0041 | Reachable only after operator opt-in |
| BOUNDARY-001 | Boundary | THREAT-009; trusted by ASSUMPTION-002 | Complete | TM-20260904-001-E0034 | — |
| BOUNDARY-002 | Boundary | THREAT-003, THREAT-006, THREAT-008, THREAT-009 | Complete | TM-20260904-001-E0025 | — |
| BOUNDARY-003 | Boundary | THREAT-001, THREAT-002, THREAT-004, THREAT-005, THREAT-012 | Complete | TM-20260904-001-E0066 | — |
| BOUNDARY-004 | Boundary | THREAT-013, THREAT-014 | Complete | TM-20260904-001-E0047 | — |
| BOUNDARY-005 | Boundary | THREAT-015, THREAT-016 | Complete | TM-20260904-001-E0040 | — |
| FLOW-001 | Flow | THREAT-011 | Complete | TM-20260904-001-E0019 | — |
| FLOW-002 | Flow | THREAT-010 | Complete | TM-20260904-001-E0063 | — |
| FLOW-003 | Flow | THREAT-003 | Complete | TM-20260904-001-E0026 | — |
| FLOW-004 | Flow | THREAT-001, THREAT-017 | Complete | TM-20260904-001-E0027 | — |
| FLOW-005 | Flow | THREAT-002, THREAT-012 | Complete | TM-20260904-001-E0033 | — |
| FLOW-006 | Flow | THREAT-004, THREAT-005 | Complete | TM-20260904-001-E0066 | — |
| FLOW-007 | Flow | Disposition: HS-only origin; no guest access; covered under ASSET-009 by THREAT-013 | Complete | TM-20260904-001-E0034 | Firmware trusted |
| FLOW-008 | Flow | THREAT-013 | Complete | TM-20260904-001-E0043 | — |
| FLOW-009 | Flow | THREAT-014 | Complete | TM-20260904-001-E0036 | — |
| FLOW-010 | Flow | THREAT-015 | Complete | TM-20260904-001-E0039 | — |
| ENTRY-001 | Entry point | THREAT-011 | Complete | TM-20260904-001-E0019 | — |
| ENTRY-002 | Entry point | THREAT-003, THREAT-006, THREAT-007, THREAT-008, THREAT-009 | Complete | TM-20260904-001-E0025 | — |
| ENTRY-003 | Entry point | THREAT-001, THREAT-002, THREAT-005, THREAT-010 | Complete | TM-20260904-001-E0029 | — |
| ENTRY-004 | Entry point | THREAT-008 | Complete | TM-20260904-001-E0033 | — |
| ENTRY-005 | Entry point | THREAT-013, THREAT-014 | Complete | TM-20260904-001-E0037 | — |
| ENTRY-006 | Entry point | THREAT-013 | Complete | TM-20260904-001-E0047 | — |
| ENTRY-007 | Entry point | THREAT-015 | Complete | TM-20260904-001-E0040 | — |
| ENTRY-008 | Entry point | THREAT-016 | Complete | TM-20260904-001-E0016 | — |
| ENTRY-009 | Entry point | THREAT-018 | Complete | TM-20260904-001-E0041 | — |
| STRIDE-S | Category | THREAT-003, THREAT-009, THREAT-015 | Complete | — | — |
| STRIDE-T | Category | THREAT-001, THREAT-002, THREAT-008, THREAT-010, THREAT-011, THREAT-013, THREAT-014 | Complete | — | — |
| STRIDE-R | Category | THREAT-013, THREAT-015, THREAT-016 | Complete | — | No audit log exists in the target; repudiation applies to evidence and approval records |
| STRIDE-I | Category | THREAT-001, THREAT-004, THREAT-005, THREAT-012, THREAT-016, THREAT-018 | Complete | — | — |
| STRIDE-D | Category | THREAT-007, THREAT-011, THREAT-017 | Complete | — | Availability is a non-goal |
| STRIDE-E | Category | THREAT-001, THREAT-003, THREAT-005, THREAT-006, THREAT-008 | Complete | — | — |

### Per-surface STRIDE dispositions

Each entry point and flow is checked against all six STRIDE categories. A
threat ID denotes coverage; a short reason denotes an evidence-supported
non-applicability (`n/a`).

| Surface | S | T | R | I | D | E |
| --- | --- | --- | --- | --- | --- | --- |
| ENTRY-001 boot handoff | n/a: single M-mode origin (E0034) | THREAT-011 | n/a: no record produced | n/a: no secret at boot | THREAT-011 | n/a: HS is entered by trusted firmware |
| ENTRY-002 VS trap entry | THREAT-003, THREAT-009 | THREAT-008 | n/a: no per-trap log claimed | n/a: HS returns no data to guest except scripted values | THREAT-007 | THREAT-003, THREAT-006, THREAT-008 |
| ENTRY-003 G-stage walk | n/a: hardware-mediated identity (VMID 0 both, E0066) | THREAT-001, THREAT-002, THREAT-010 | n/a | THREAT-001, THREAT-005 | THREAT-007 | THREAT-001, THREAT-005 |
| ENTRY-004 shared page | n/a: intentional two-party channel | THREAT-008 (as trap input), THREAT-002 | n/a | THREAT-012 (accepted channel) | n/a: no blocking wait | n/a: data page, non-executable for guest (E0029) |
| ENTRY-005 build inputs | n/a: no authentication attempted (THREAT-014 covers) | THREAT-014 | n/a | n/a | n/a: build failure is visible | THREAT-014 |
| ENTRY-006 evidence bundle | THREAT-013 | THREAT-013 | THREAT-013 | n/a: bundle is intended output | n/a | n/a |
| ENTRY-007 gate commit | THREAT-015 | THREAT-015 | THREAT-015 | n/a | n/a: gate `blocked` fails closed | THREAT-015 |
| ENTRY-008 documentation | n/a: no identity claim | THREAT-016 | THREAT-016 | THREAT-016 | n/a | n/a |
| ENTRY-009 preview server | n/a: no auth exists; disclosure covered | n/a: GET/HEAD only (E0041) | n/a | THREAT-018 | n/a: local tool | n/a: static file serving only |
| FLOW-001..006 (guest lifecycle) | THREAT-003 | THREAT-001, 002, 010, 011 | n/a: no guest-visible record | THREAT-001, 004, 005, 012 | THREAT-007, 011, 017 | THREAT-001, 003, 005, 006, 008 |
| FLOW-007 console | n/a: HS-only writer | n/a: firmware trusted (ASSUMPTION-002) | THREAT-013 (log as record) | n/a: no secret printed | n/a | n/a |
| FLOW-008 evidence capture | THREAT-013 | THREAT-013 | THREAT-013 | n/a | n/a | n/a |
| FLOW-009 container/toolchain | n/a | THREAT-014 | n/a | n/a | n/a | THREAT-014 |
| FLOW-010 publication | THREAT-015 | THREAT-015 | THREAT-015 | THREAT-018 (bypass) | n/a | THREAT-015 |

## Residual risk and unknowns

Residual position (`Inferred`): all guest-boundary threats (THREAT-001 through
THREAT-006, THREAT-009) reduce to `Low` under evidence-supported controls, with
the qualification that every rating rests on QEMU behaviour and on the
correctness of unverified HS-mode C. The residual profile is dominated by:

| Threat | Residual | Why it remains |
| --- | --- | --- |
| THREAT-013 | High (3x4) | Target admits a self-consistent false bundle is possible; no attestation or second-evaluator reproduction |
| THREAT-008 | High (2x5) | HS C is the whole root of trust; no memory-safety proof, no stack protection, policy writable |
| THREAT-014 | High (2x5) | Supply chain pinned but not authenticated; consequence of compromise remains total |
| THREAT-016 | Moderate (3x3) | Lineage misattribution is a live hazard in this workspace (E0004); only documentation controls exist |
| THREAT-010 | Moderate (2x4) | Readback shares the mapper's trust domain; no divergence test |
| THREAT-015 | Moderate (2x3) | Gate identity procedural; H6/H7 open |
| THREAT-007, THREAT-012 | Moderate, out of scope | Explicit non-goals recorded for coverage |

Residual risk is not accepted risk. Acceptance, exception, review approval,
release, formal verification and hardware validation are outside this model.

Unknowns carried to `open-questions.md`: OPEN-001 (`HFENCE.GVMA` scope on
hardware; specification-level answer from secondary sources recorded, hardware
still unknown), OPEN-002 (optional-CSR baseline incl. `htimedelta`), OPEN-003
(producing-host threat environment), OPEN-004 (transitive npm closure),
OPEN-005 (H6 review status for `1ab289c…`; answered from local evidence: H6
and H7 are incomplete, E0052), OPEN-006 (`htval = 0` permitted by the
specification; answered from secondary sources, E0065). None was blocking for
this projection; each is labelled with the assumption used.

No target code, test, image or emulator was executed by this engagement.
Statements about tests and negative images describe what the maintained checks
are designed to detect at this revision, not observed results.
