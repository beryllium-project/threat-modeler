# Evidence ledger

Package ID: `TM-20260901-001`
Title: Helium TE PoC Initial Threat Model
Created: 2026-09-01
Status: `Complete`
Distribution: `private`

Evidence IDs are append-only and unique within the package. A correction adds
a new record and names the superseded record.

Every evidence record contains:

- status: `active`, `superseded`, or `withdrawn`;
- fact label, source class, evidentiary role, and affected stable IDs;
- title or description, portable logical locator, and exact revision or date;
- neutral observation and relationship to the modeled surface;
- confidence, confidence basis, alternatives, and limitations;
- sensitivity and redistribution status;
- a content hash when a retained or user-supplied copy is involved;
- `Supersedes` and `Superseded by` links.

## TM-20260901-001-E0001

- Status: active
- Fact label: Established
- Class: Frozen target metadata
- Role: Direct
- Affected IDs: All target-scoped IDs
- Title or description: Confirmed clean Helium target state and effective scope
- Logical locator: `source://package/scope.md`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`; checked 2026-09-01T18:19:00Z
- Observation: The modeled target is the registered, clean `helium-te-poc` `for-review` revision with no approved dirty paths.
- Relationship: Binds every current-target statement to one exact revision and the user-confirmed Deep scope.
- Confidence: High
- Confidence basis: Maintained read-only state helper and explicit user confirmation.
- Alternatives and counter-evidence: Parent coordination contains older observation snapshots, which do not override this freeze.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: Establishes identity and scope, not implementation correctness.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0002

- Status: active
- Fact label: Established
- Class: Target handoff and status
- Role: Direct
- Affected IDs: OBJECTIVE-008, ACTOR-010, CONTROL-016, CONTROL-017, THREAT-011, THREAT-012
- Title or description: Current claim, review, hardware, and release status
- Logical locator: `component://helium-te-poc/HANDOFF.md`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: The target describes a fixed review-and-test PoC, no hardware validation, incomplete H6 exact-source review and H7 release action, and a blocked publication gate.
- Relationship: Establishes assurance and human-decision boundaries.
- Confidence: High
- Confidence basis: Current maintained target handoff.
- Alternatives and counter-evidence: Technical source corroborates many mechanisms, but the handoff is not approval or execution evidence.
- Sensitivity: internal
- Redistribution: unknown
- Hash: None
- Limitations: Status claims do not prove behavior or authorize promotion.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0003

- Status: active
- Fact label: Established
- Class: Target architecture
- Role: Direct
- Affected IDs: ACTOR-001 through ACTOR-008, BOUNDARY-001 through BOUNDARY-009, FLOW-001 through FLOW-016
- Title or description: Fixed architecture, trust stack, and evaluator boundary
- Logical locator: `component://helium-te-poc/docs/architecture.md`; `component://helium-te-poc/docs/diagrams/architecture.dot`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: The design places OpenSBI in M-mode, the fixed policy/mechanism/runtime in HS-mode, two sequential untrusted VS subjects behind distinct roots, and host evaluation in a separate trust context.
- Relationship: Establishes the primary system context and trust boundaries.
- Confidence: High
- Confidence basis: Maintained architecture and direct code-structure corroboration.
- Alternatives and counter-evidence: Platform, firmware, emulator, and toolchain behavior remain assumed.
- Sensitivity: internal
- Redistribution: unknown
- Hash: None
- Limitations: Architecture documentation is not runtime observation.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0004

- Status: active
- Fact label: Established
- Class: Target implementation
- Role: Direct
- Affected IDs: ASSET-003 through ASSET-006, FLOW-005, FLOW-006, FLOW-008 through FLOW-010
- Title or description: Fixed domains, resources, GPAs, and layout constraints
- Logical locator: `component://helium-te-poc/include/he/config.h`; `component://helium-te-poc/include/he/layout.h`; `component://helium-te-poc/src/config.c`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: Source defines three domain identities, six memory resources, fixed aligned GPAs, private stacks and data, one shared page, fixed sentinels, and compile-time layout constraints.
- Relationship: Establishes the finite asset and identifier set.
- Confidence: High
- Confidence basis: Direct current source inspection.
- Alternatives and counter-evidence: Resource identifiers and GPAs do not themselves confer authority.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: Fixed configuration does not generalize to dynamic resources.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0005

- Status: active
- Fact label: Established
- Class: Target implementation
- Role: Direct
- Affected IDs: ASSET-002, OBJECTIVE-001, OBJECTIVE-004, CONTROL-001, THREAT-001
- Title or description: Sealed default-deny Type Enforcement mechanism
- Logical locator: `component://helium-te-poc/include/he/te.h`; `component://helium-te-poc/src/te.c`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: Labels begin invalid, are assigned once, require complete sealing, and authorize only when one exact valid rule covers the complete nonempty request; malformed or absent input denies.
- Relationship: Establishes the policy decision control and its fail-closed input behavior.
- Confidence: High
- Confidence basis: Direct current source inspection.
- Alternatives and counter-evidence: Trusted HS code can still modify memory outside the API.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: API sealing is not hardware immutability or a general policy lifecycle.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0006

- Status: active
- Fact label: Established
- Class: Target implementation
- Role: Direct
- Affected IDs: OBJECTIVE-002, OBJECTIVE-003, ASSET-002 through ASSET-005, CONTROL-002, THREAT-001, THREAT-002
- Title or description: Sole fixed six-rule policy
- Logical locator: `component://helium-te-poc/src/policy/te.c`; `component://helium-te-poc/docs/policy-models.md`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: The only linked policy assigns monitor, writer, reader, payload, private, and shared types; it grants own-private access, common-code execution, writer shared read/write, and reader shared read, with no cross-private rule.
- Relationship: Establishes intended access and information-flow direction.
- Confidence: High
- Confidence basis: Direct policy source and maintained policy matrix.
- Alternatives and counter-evidence: No second policy, dynamic parser, callback, transition, or policy update exists.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: One finite policy does not establish a general TE system.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0007

- Status: active
- Fact label: Established
- Class: Target implementation
- Role: Direct
- Affected IDs: OBJECTIVE-004, ASSET-002, ASSET-006, BOUNDARY-005, FLOW-002, FLOW-003, CONTROL-003, THREAT-001, THREAT-002
- Title or description: Policy-to-hardware derivation and reconciliation
- Logical locator: `component://helium-te-poc/src/main.c`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: Runtime requires exposure authority, derives R/W/X separately, rechecks the combined request, installs a leaf, compares TE decisions with PTE access, and requires cross-private denial plus leaf absence before VS entry.
- Relationship: Establishes the policy-to-G-stage authority flow and complete-set checks.
- Confidence: High
- Confidence basis: Direct current source inspection and completed PRV corroboration.
- Alternatives and counter-evidence: Correctness remains inside the trusted HS implementation.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: No formal refinement or current execution result is admitted.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0008

- Status: active
- Fact label: Established
- Class: Target implementation
- Role: Direct
- Affected IDs: ASSET-006, OBJECTIVE-002 through OBJECTIVE-005, CONTROL-004, THREAT-002, THREAT-003
- Title or description: Fixed Sv39x4 root and PTE construction
- Logical locator: `component://helium-te-poc/src/memory.c`; `component://helium-te-poc/include/he/memory.h`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: The mechanism validates fixed table paths and backing ranges, rejects overlap and same-root aliases, uses VMID zero, and encodes accessible leaves with required `V`, `U`, and `A` plus policy-derived R/W/X and writable `D`.
- Relationship: Establishes the concrete isolation mechanism and counters historical advice to remove `PTE_U`.
- Confidence: High
- Confidence basis: Direct source plus exact host-test expectations.
- Alternatives and counter-evidence: Hardware page-walker behavior is assumed.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: Fixed roots and one leaf region do not cover arbitrary mappings.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0009

- Status: active
- Fact label: Established
- Class: Target implementation
- Role: Direct
- Affected IDs: ENTRY-001, ENTRY-002, FLOW-001, OBJECTIVE-005, CONTROL-005
- Title or description: Boot, initialization, and subject-entry baseline
- Logical locator: `component://helium-te-poc/src/entry.S`; `component://helium-te-poc/src/platform.c`; `component://helium-te-poc/src/main.c`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: Entry establishes BSS and a trusted stack, rejects nonzero harts, initializes and seals policy, builds and checks roots, resets listed VS state, installs writer translation state, clears non-stack GPRs, and enters VS.
- Relationship: Establishes initialization and the first privilege transition.
- Confidence: High
- Confidence basis: Direct C and assembly inspection.
- Alternatives and counter-evidence: OpenSBI handoff, identity mapping, and loaded-image correspondence remain assumptions.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: Optional extension and microarchitectural state are excluded.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0010

- Status: active
- Fact label: Established
- Class: Target implementation
- Role: Direct
- Affected IDs: ACTOR-001, ENTRY-002, ENTRY-003, FLOW-004 through FLOW-006, THREAT-002, THREAT-005
- Title or description: Writer execution and expected denial path
- Logical locator: `component://helium-te-poc/src/guest.S`; `component://helium-te-poc/src/main.c`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: The writer checks entry state, accesses its private and shared pages, reports exact events, faults on reader-private memory, seeds selected architectural residue, and reports completion.
- Relationship: Establishes attacker-controlled event, address, and state inputs and the first expected denial.
- Confidence: High
- Confidence basis: Direct payload and runtime source.
- Alternatives and counter-evidence: Source structure is not proof of observed execution.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: The linked payload is finite and synthetic.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0011

- Status: active
- Fact label: Established
- Class: Target implementation
- Role: Direct
- Affected IDs: ASSET-006, ASSET-007, BOUNDARY-004, ENTRY-004, FLOW-007, CONTROL-006, THREAT-003, THREAT-004
- Title or description: Writer-to-reader architectural-state and root transition
- Logical locator: `component://helium-te-poc/src/main.c`; `component://helium-te-poc/src/platform.c`; `component://helium-te-poc/src/trap.S`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: After exact writer completion, runtime clears the saved frame, resets listed VS CSRs, performs VVMA, writes the reader VMID-zero root, performs global GVMA, replaces the private stack, restores zero GPRs, and returns to VS.
- Relationship: Establishes the load-bearing transition controls that supersede older register/CSR-residue findings.
- Confidence: High
- Confidence basis: Direct current C and assembly inspection.
- Alternatives and counter-evidence: Fence and CSR architectural effects remain trusted; optional and microarchitectural state is not covered.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: Not a scheduler or arbitrary context-switch facility.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0012

- Status: active
- Fact label: Established
- Class: Target implementation
- Role: Direct
- Affected IDs: ACTOR-002, ENTRY-003, ENTRY-004, FLOW-008 through FLOW-010, CONTROL-007, THREAT-002, THREAT-005, THREAT-007
- Title or description: Reader execution, exact trap mediation, and terminal failure
- Logical locator: `component://helium-te-poc/src/guest.S`; `component://helium-te-poc/src/main.c`; `component://helium-te-poc/src/platform.c`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: Reader access is limited to its own private page and shared reads; shared writes and writer-private reads are expected faults. Recoverable paths require exact origin, phase, PC, address, policy, PTE, and sentinel state. Other states request SBI shutdown and then wait if firmware returns.
- Relationship: Establishes reader flow, complete event mediation within the finite scenario, and fail-closed behavior.
- Confidence: High
- Confidence basis: Direct current source.
- Alternatives and counter-evidence: Strict nonzero `HTVAL` behavior is profile-dependent; terminal failure preserves security but not availability.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: No general recovery, timer, scheduler, or data-zeroization behavior is established.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0013

- Status: active
- Fact label: Established
- Class: Target security record
- Role: Direct
- Affected IDs: OBJECTIVE-001 through OBJECTIVE-006, ASSET-001 through ASSET-008
- Title or description: Stated protected assets and fixed security objectives
- Logical locator: `component://helium-te-poc/docs/security-and-limits.md`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: The target identifies HS code/state, policy and roots, private memory, reader-protected shared integrity, policy/PTE consistency, and terminal-result integrity as protected within the fixed experiment.
- Relationship: Direct basis for target security objectives and assets.
- Confidence: High
- Confidence basis: Maintained target security statement.
- Alternatives and counter-evidence: These are intended properties, not universal theorems.
- Sensitivity: internal
- Redistribution: unknown
- Hash: None
- Limitations: Availability, arbitrary information flow, and broader confidentiality are excluded.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0014

- Status: active
- Fact label: Established
- Class: Target assumptions and limits
- Role: Direct
- Affected IDs: ACTOR-004 through ACTOR-008, ASSUMPTION-001 through ASSUMPTION-008, THREAT-006, THREAT-013, THREAT-014
- Title or description: TCB, platform assumptions, and explicit non-goals
- Logical locator: `component://helium-te-poc/docs/security-and-limits.md`; `component://helium-te-poc/docs/code-tour.md`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: The target trusts HS source, toolchains, OpenSBI, QEMU, architecture behavior, linker layout, one-hart execution, disabled interrupts, no DMA, non-LTO volatile loads, and non-nested traps; it excludes arbitrary guests, availability, devices, multicore, attestation, side-channel resistance, formal proof, and hardware validation.
- Relationship: Defines the load-bearing TCB and limits.
- Confidence: High
- Confidence basis: Explicit maintained assumptions and source map.
- Alternatives and counter-evidence: A compromised trusted dependency can invalidate the result.
- Sensitivity: internal
- Redistribution: unknown
- Hash: None
- Limitations: Assumptions are not controls.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0015

- Status: active
- Fact label: Established
- Class: Target build implementation
- Role: Direct
- Affected IDs: ASSET-009, ENTRY-005, FLOW-011, CONTROL-008, CONTROL-011, THREAT-008
- Title or description: Maintained build-graph ownership and path constraints
- Logical locator: `component://helium-te-poc/Makefile`; `component://helium-te-poc/he`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: The physical Makefile owns canonical production sources, policy, tools, flags, modes, and outputs and rejects selected overrides, unsafe paths, nonexact toolchains, and stale derived files.
- Relationship: Establishes preventive controls against accidental or caller-driven graph substitution.
- Confidence: High
- Confidence basis: Direct build-source inspection.
- Alternatives and counter-evidence: Arbitrary alternate rules and compromised Make, shell, compiler, or filesystem remain outside the boundary.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: Independent processes sharing one output root are unsupported.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0016

- Status: active
- Fact label: Established
- Class: Target evaluator implementation
- Role: Direct
- Affected IDs: ACTOR-006 through ACTOR-008, BOUNDARY-007, BOUNDARY-008, ENTRY-008, FLOW-014, CONTROL-013, THREAT-010
- Title or description: Rootless evaluator isolation, provenance, and transactional export
- Logical locator: `component://helium-te-poc/tests/run-rootless.sh`; `component://helium-te-poc/scripts/evaluator-boundary.sh`; `component://helium-te-poc/scripts/evaluate.sh`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: Source uses private locked Podman state, a captured image ID, read-only source/provenance/rootfs, hidden host trees, proxy scrubbing, exact export allowlists, fingerprints, and rollback-capable publication.
- Relationship: Establishes host/evaluator controls and residual trust in the container stack and producer.
- Confidence: High
- Confidence basis: Direct implementation inspection.
- Alternatives and counter-evidence: Container engine, kernel, runtime, networked image build, wrapper, and host remain trusted.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: Source does not prove current execution or host isolation.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0017

- Status: active
- Fact label: Established
- Class: Target publication process
- Role: Direct
- Affected IDs: ASSET-011, ACTOR-009, ACTOR-010, BOUNDARY-009, ENTRY-010, FLOW-016, CONTROL-016, CONTROL-017, THREAT-011, THREAT-012
- Title or description: Blocked structural publication gate and human authority
- Logical locator: `component://helium-te-poc/publication-gate.conf`; `component://helium-te-poc/scripts/check-publication-gate.sh`; `component://helium-te-poc/docs/policy-and-publication.md`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: The gate is blocked and structurally constrains any future approval record, while H6 source review and H7 release remain separate human actions.
- Relationship: Establishes claim and distribution controls.
- Confidence: High
- Confidence basis: Current gate record, implementation, and policy.
- Alternatives and counter-evidence: Structural identity fields do not cryptographically authenticate a responsible human or review quality.
- Sensitivity: internal
- Redistribution: unknown
- Hash: None
- Limitations: The model cannot grant or infer either human decision.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0018

- Status: active
- Fact label: Established
- Class: Target test source
- Role: Corroborating
- Affected IDs: CONTROL-003 through CONTROL-009, THREAT-001 through THREAT-005
- Title or description: Unit, entry-state, memory, and build-assurance test intent
- Logical locator: `component://helium-te-poc/tests/unit/test_main.c`; `component://helium-te-poc/tests/test-subject-entry-state.sh`; `component://helium-te-poc/tests/test-memory-build-assurance.sh`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: Test source covers sealed/default-deny policy, raw root/PTE structure including required `PTE_U`, absent private leaves, shared asymmetry, GPR/CSR reset, fence ordering, layout, non-LTO volatile reads, and corrupt-sentinel wiring.
- Relationship: Corroborates intended control coverage.
- Confidence: High
- Confidence basis: Direct test-source inspection.
- Alternatives and counter-evidence: Presence and assertions do not establish a passing run at the frozen commit.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: No target command was executed.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0019

- Status: active
- Fact label: Established
- Class: Target test and runner source
- Role: Corroborating
- Affected IDs: ENTRY-006, FLOW-012, CONTROL-010, THREAT-003 through THREAT-007
- Title or description: Exact trace validation and finite adversarial images
- Logical locator: `component://helium-te-poc/tests/run-qemu.sh`; `component://helium-te-poc/tests/validate-qemu-trace.sh`; `component://helium-te-poc/tests/test-negative-qemu-images.sh`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: Runner and validators bind tool/image identity and exact ordered markers; six negative images cover early completion, skipped denial, SATP, SFENCE.VMA, SRET, and WFI and require terminal failure.
- Relationship: Establishes finite abuse-case verification intent.
- Confidence: High
- Confidence basis: Direct current runner and fixture source.
- Alternatives and counter-evidence: Finite fixtures do not prove arbitrary-guest containment.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: QEMU/OpenSBI and the evidence producer remain trusted; no run occurred.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0020

- Status: active
- Fact label: Established
- Class: Target evidence implementation
- Role: Direct
- Affected IDs: ASSET-009, ASSET-010, ENTRY-007, FLOW-013, CONTROL-012, THREAT-008, THREAT-009
- Title or description: Evidence generation and exact correspondence verification
- Logical locator: `component://helium-te-poc/tests/generate-evidence.sh`; `component://helium-te-poc/tests/verify-evidence.sh`; `component://helium-te-poc/scripts/evidence-contract.sh`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: Source distinguishes clean exact-commit candidates from dirty development, validates complete path/type/mode/hash namespaces, independently selects local executables, and transactionally publishes bundles.
- Relationship: Establishes evidence-integrity controls and the residual malicious-producer problem.
- Confidence: High
- Confidence basis: Direct source and verifier-test inspection.
- Alternatives and counter-evidence: A malicious producer can create internally consistent source, artifacts, and reports.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: Correspondence is not authenticity, attestation, measurement, proof, or a trust root.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0021

- Status: active
- Fact label: Established
- Class: Target review and documentation process
- Role: Direct
- Affected IDs: ASSET-010, ENTRY-009, FLOW-015, CONTROL-014, CONTROL-015, THREAT-009, THREAT-011, THREAT-012
- Title or description: Review provenance contract and generated-document controls
- Logical locator: `component://helium-te-poc/agent-review/REVIEW-PROVENANCE.md`; `component://helium-te-poc/agent-review/review-manifest.schema.json`; `component://helium-te-poc/scripts/serve-docs.mjs`; `component://helium-te-poc/scripts/build-docs.sh`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: Future review manifests bind source state, commands, tools, exits, and evidence hashes; documentation generation and serving constrain inputs, paths, listeners, and output determinism.
- Relationship: Establishes review traceability and generated-publication controls.
- Confidence: High
- Confidence basis: Direct process, schema, and implementation inspection.
- Alternatives and counter-evidence: The manifest remains producer attestation and does not apply retroactively.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: No current generation or browser run is admitted.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0022

- Status: active
- Fact label: Established
- Class: Target verification limits
- Role: Negative
- Affected IDs: ASSUMPTION-009, MITIGATION-001, MITIGATION-004, MITIGATION-009
- Title or description: No formal, CBMC, binary, or hardware result at the frozen target
- Logical locator: `component://helium-te-poc/docs/verification.md`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: The target records no Rocq/Coq model, Sail semantics, refinement, CBMC harness, Frama-C contract, assembly proof, source-to-binary proof, or hardware validation.
- Relationship: Prevents unsupported assurance claims and limits control credit.
- Confidence: High
- Confidence basis: Explicit current verification record and direct candidate inspection.
- Alternatives and counter-evidence: Later successor commits have separate CBMC work, but it does not transfer by revision.
- Sensitivity: internal
- Redistribution: not-applicable
- Hash: None
- Limitations: Does not negate bounded test value.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0023

- Status: active
- Fact label: Established
- Class: Historical security reviews
- Role: Counter
- Affected IDs: THREAT-003 through THREAT-012, CONTROL-014
- Title or description: Five retained AI review packages against older revisions
- Logical locator: `component://helium-te-poc/agent-review/`
- Revision or checked date: Retained at `1ab289c066b69acdd8b55c9f77055b0145be1316`; reviewed baselines vary
- Observation: The packages raised state residue, trap nesting, translation, evaluator, build, evidence, gate, and claim issues with conflicting severities and incomplete or self-attested provenance.
- Relationship: Supplies challenge and counter-evidence for current-source rechecking.
- Confidence: Medium
- Confidence basis: All retained review Markdown and process records were inspected.
- Alternatives and counter-evidence: Current source supersedes many mechanisms; the `PTE_U` removal recommendation is contradicted.
- Sensitivity: internal
- Redistribution: unknown
- Hash: None
- Limitations: None reviews the frozen current implementation and no retroactive manifest is permitted.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0024

- Status: active
- Fact label: Established
- Class: Target remediation delta
- Role: Counter
- Affected IDs: CONTROL-003 through CONTROL-016, THREAT-003 through THREAT-012
- Title or description: Maintained review disposition and stale state wording
- Logical locator: `component://helium-te-poc/docs/review-remediation.md`
- Revision or checked date: Present at `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: The automation-produced ledger normalizes fifteen actions, records current technical dispositions, rejects technically reversed or out-of-scope proposals, and keeps H6/H7 incomplete; its opening uncommitted-worktree statement is stale.
- Relationship: Establishes historical remediation intent while requiring current-source corroboration.
- Confidence: High
- Confidence basis: Maintained ledger, current source, and handoff comparison.
- Alternatives and counter-evidence: It is not responsible-human review or approval.
- Sensitivity: internal
- Redistribution: unknown
- Hash: None
- Limitations: Current target state from E0001 and E0002 supersedes only the stale worktree wording.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0025

- Status: active
- Fact label: Unknown
- Class: Target implementation gap
- Role: Counter
- Affected IDs: ASSET-001, ASSET-007, ENTRY-003, ASSUMPTION-004, THREAT-006, MITIGATION-002
- Title or description: Nested HS trap reachability and trusted-stack transition
- Logical locator: `component://helium-te-poc/src/trap.S`; `component://helium-te-poc/docs/security-and-limits.md`
- Revision or checked date: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: Trap entry uses a direct `SSCRATCH` stack exchange and the design assumes the HS path does not nest; no current trigger or proof of unreachability was found.
- Relationship: Defines a high-impact uncertainty in the privileged entry path.
- Confidence: Medium
- Confidence basis: Direct mechanism plus explicit assumption; reachability is unestablished.
- Alternatives and counter-evidence: The fixed event profile and disabled interrupts may prevent practical nesting.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: No exploitability or current defect conclusion follows.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0026

- Status: active
- Fact label: Established
- Class: Target assurance history
- Role: Corroborating
- Affected IDs: CONTROL-009 through CONTROL-017, MITIGATION-001, MITIGATION-006
- Title or description: Recorded historical validation and incomplete human gates
- Logical locator: `component://helium-te-poc/HANDOFF.md`; `component://helium-te-poc/docs/review-remediation.md`
- Revision or checked date: Records dated 2026-08-06 through 2026-08-07; present at target revision
- Observation: Maintained records report targeted checks, dirty integration gates, rootless evaluation, document determinism, and a temporary clean-pair verifier run before integration, while H6/H7 remain incomplete.
- Relationship: Corroborates that controls were exercised historically without establishing an exact current-commit run.
- Confidence: Medium
- Confidence basis: Consistent maintained history.
- Alternatives and counter-evidence: Raw package-specific execution evidence for `1ab289c...` was not admitted.
- Sensitivity: internal
- Redistribution: unknown
- Hash: None
- Limitations: Historical passes are not current execution, review approval, or release approval.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0027

- Status: active
- Fact label: Established
- Class: Historical transcript provenance
- Role: Direct
- Affected IDs: ASSUMPTION-009, THREAT-011, OPEN-008, OPEN-009, BLOCKED-001
- Title or description: Three committed verbatim pre-Helium exchanges and their limits
- Logical locator: `component://beryllium-repo/planning/session-analysis-transcripts-2026-07-20.md`
- Revision or checked date: `65f6d895a2007e8e093582cc48726375fd23b563`; transcript content dated 2026-07-20
- Observation: The index identifies three retained prompt/output pages and explicitly denies approved-decision, implementation, or proof status; larger raw reports remain external.
- Relationship: Establishes historical rationale and its non-authoritative boundary.
- Confidence: High
- Confidence basis: Direct committed provenance index.
- Alternatives and counter-evidence: Original session-store authentication was unavailable.
- Sensitivity: private
- Redistribution: unknown
- Hash: None
- Limitations: “Verbatim” is established only as the committed record's assertion.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0028

- Status: active
- Fact label: Established
- Class: Historical design input
- Role: Contextual
- Affected IDs: OBJECTIVE-002, OBJECTIVE-004, THREAT-013, THREAT-014, MITIGATION-009
- Title or description: TE, hypervisor decomposition, VM-flow, and VBS hypotheses
- Logical locator: `component://beryllium-repo/planning/session-analysis-te-vbs-2026-07-20.md`
- Revision or checked date: `65f6d895a2007e8e093582cc48726375fd23b563`; session turn 6, 2026-07-20
- Observation: The exchange proposes finite TE proof obligations, distinguishes TE policy from hardware isolation, limits information-flow claims, and treats VBS-style protection as a future separate-root/service architecture.
- Relationship: Supplies design rationale and abuse cases against same-address-space, flow-control, proof, or VBS overclaims.
- Confidence: High
- Confidence basis: Direct committed transcript text.
- Alternatives and counter-evidence: Proposals are not implementation, feasibility proof, or current target facts.
- Sensitivity: private
- Redistribution: unknown
- Hash: None
- Limitations: Current Helium has only sequential synthetic subjects.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0029

- Status: active
- Fact label: Established
- Class: Historical design input
- Role: Contextual
- Affected IDs: THREAT-003, THREAT-013, ASSUMPTION-001, ASSUMPTION-005
- Title or description: Multi-hart HS isolation-engine proposal
- Logical locator: `component://beryllium-repo/planning/session-analysis-isolation-engine-2026-07-20.md`
- Revision or checked date: `65f6d895a2007e8e093582cc48726375fd23b563`; session turn 7, 2026-07-20
- Observation: The exchange proposes a per-hart HS engine, static two-hart domains, immutable roots and ownership, explicit channels, and later serialized invalidation and frame reuse.
- Relationship: Identifies future multicore, revocation, and availability threats while preventing them from being treated as current features.
- Confidence: High
- Confidence basis: Direct committed transcript text.
- Alternatives and counter-evidence: Helium is single-hart and implements no such protocol.
- Sensitivity: private
- Redistribution: unknown
- Hash: None
- Limitations: Future architecture hypothesis only.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0030

- Status: active
- Fact label: Established
- Class: Historical design input
- Role: Contextual
- Affected IDs: THREAT-001, THREAT-013, ASSUMPTION-005
- Title or description: CAP+TE, FLASK, and CHERI/software-capability proposal
- Logical locator: `component://beryllium-repo/planning/session-analysis-cap-te-cheri-2026-07-20.md`
- Revision or checked date: `65f6d895a2007e8e093582cc48726375fd23b563`; session turn 8, 2026-07-20
- Observation: The exchange proposes capability and TE intersection, monitor-held labels and object identity, software capability tables on non-CHERI hardware, and a future CHERI backend refining an abstract model.
- Relationship: Identifies authority-amplification and confused-deputy threats in future systems.
- Confidence: High
- Confidence basis: Direct committed transcript text.
- Alternatives and counter-evidence: Helium implements no capability possession, delegation, revocation, CHERI, or FLASK runtime.
- Sensitivity: private
- Redistribution: unknown
- Hash: None
- Limitations: Not a selected or implemented control.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0031

- Status: active
- Fact label: Established
- Class: Historical curated design
- Role: Counter
- Affected IDs: ASSUMPTION-005, THREAT-011, THREAT-013, THREAT-014
- Title or description: Trigger-gated disposition of broader architecture
- Logical locator: `component://beryllium-repo/planning/isolation-engine-policy-research.md`
- Revision or checked date: `65f6d895a2007e8e093582cc48726375fd23b563`
- Observation: The maintained synthesis keeps capabilities, TE composition, multicore, VBS-like services, dynamic control, and devices as gated later work rather than fixed Helium features.
- Relationship: Prevents historical prompts from silently widening the current model.
- Confidence: High
- Confidence basis: Explicit maintained disposition.
- Alternatives and counter-evidence: Later Beryllium work may address separate scopes but does not alter this target.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: Historical project decision, not current target behavior.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0032

- Status: active
- Fact label: Established
- Class: Historical architecture alignment
- Role: Counter
- Affected IDs: ASSUMPTION-005, THREAT-013, THREAT-014
- Title or description: CHERI and software-capability distinction
- Logical locator: `component://beryllium-repo/planning/cheri-alignment.md`
- Revision or checked date: `65f6d895a2007e8e093582cc48726375fd23b563`
- Observation: The record distinguishes software object capabilities from CHERI hardware capabilities and states that CHERI compartments do not replace separate roots for isolation from a guest kernel or independent lifecycle.
- Relationship: Prevents capability terminology and in-address-space protection from being treated as current VM isolation.
- Confidence: High
- Confidence basis: Maintained terminology and boundary record.
- Alternatives and counter-evidence: No composed CHERI plus H-extension model is established.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: Alignment intent is not CHERI conformance.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0033

- Status: active
- Fact label: Established
- Class: Historical implementation evidence
- Role: Contextual
- Affected IDs: OBJECTIVE-001 through OBJECTIVE-006, CONTROL-001 through CONTROL-010
- Title or description: Fixed TE pathfinder implementation and evidence record
- Logical locator: `component://beryllium-repo/planning/type-enforcement-pathfinder-evidence.md`
- Revision or checked date: `65f6d895a2007e8e093582cc48726375fd23b563`; historical checkpoint `511187f9d1f44c322e3a4a11347584fd8a20dc72`
- Observation: The record describes one hart, sequential synthetic subjects, fixed labels and rules, two roots, private-page absence, asymmetric shared access, exact event handling, global fencing, host tests, and repeated emulator observations.
- Relationship: Corroborates the design lineage later found directly in current target source.
- Confidence: Medium
- Confidence basis: Maintained historical record and completed PRV lineage analysis.
- Alternatives and counter-evidence: The historical record alone does not prove current correspondence or execution.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: No general VM, hardware, proof, or direct transfer claim follows.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0034

- Status: active
- Fact label: Unknown
- Class: Historical lineage gap
- Role: Counter
- Affected IDs: OPEN-010, THREAT-011
- Title or description: Direct Beryllium-to-standalone transfer remains unresolved
- Logical locator: `component://beryllium-repo/planning/HANDOFF.md`; `component://provenance-review/reviews/PRV-20260828-001-helium-te-security-architecture/HANDOFF.md`
- Revision or checked date: Beryllium `65f6d895a2007e8e093582cc48726375fd23b563`; PRV committed at `d698e7598e44928e4a64d7ebc3de7655cfbefb29`
- Observation: Exact predecessor commits and current implementation behavior are documented, but the former local-history anchor and direct file-transfer bridge are unavailable.
- Relationship: Limits authorship, transfer, and conceptual-origin claims.
- Confidence: High
- Confidence basis: Completed historical and provenance reviews.
- Alternatives and counter-evidence: Snapshot migration, selective port, and independent rewrite remain possible.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: This does not weaken direct current-target source observations.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0035

- Status: active
- Fact label: Established
- Class: Parent coordination
- Role: Direct
- Affected IDs: ACTOR-010, ASSUMPTION-010, OBJECTIVE-008, THREAT-011, THREAT-012
- Title or description: Component ownership and exact assurance boundaries
- Logical locator: `workspace://SOT.md`; `workspace://COMPONENTS.md`; `workspace://HANDOFF.md`
- Revision or checked date: `767752792026622bbb06c3fcd29d240b0871a3e9`
- Observation: Components are independent read-only evidence sources; Helium is a review-and-test PoC, Beryllium is accepted through R7, R8-H0 is committed but not accepted, K3 hardware is `NOT RUN`, and publication remains a human gate.
- Relationship: Establishes project ownership and non-transfer of acceptance.
- Confidence: High
- Confidence basis: Parent source-of-truth and coordination records.
- Alternatives and counter-evidence: Embedded component revisions can lag current helper state.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: Parent coordination is not target technical evidence.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0036

- Status: active
- Fact label: Established
- Class: Completed PRV package
- Role: Corroborating
- Affected IDs: OPEN-009, OPEN-010, THREAT-009, THREAT-011, THREAT-012
- Title or description: Completed private Helium security-architecture provenance review
- Logical locator: `component://provenance-review/reviews/PRV-20260828-001-helium-te-security-architecture/HANDOFF.md`
- Revision or checked date: Committed tree `d698e7598e44928e4a64d7ebc3de7655cfbefb29`; package completed 2026-08-29
- Observation: The package is complete for the same target revision, records validated append-only review output, exact lineage and prior-art limits, unresolved transfer, and promotion blockers.
- Relationship: Supplies provenance and prior-art evidence without importing approval.
- Confidence: High
- Confidence basis: Direct inspection through the revision-selecting maintained helper.
- Alternatives and counter-evidence: The current PRV worktree is dirty, but no overlay content was read.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: Completion does not establish target correctness, novelty, or publication authority.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0037

- Status: active
- Fact label: Established
- Class: Completed PRV direct implementation evidence
- Role: Corroborating
- Affected IDs: OBJECTIVE-004, BOUNDARY-005, CONTROL-003, CONTROL-004, THREAT-001, THREAT-002
- Title or description: PRV records for current policy-to-G-stage implementation
- Logical locator: `component://provenance-review/reviews/PRV-20260828-001-helium-te-security-architecture/evidence-ledger.md`
- Revision or checked date: PRV records E0004 and E0007; target `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Observation: The completed PRV independently records the current runtime exposure gate, complete permission derivation, PTE reconciliation, private denial, hardware exclusion of policy-only exposure, and separate PTE inspection path.
- Relationship: Corroborates E0007 and E0008 at the exact target revision.
- Confidence: High
- Confidence basis: Direct committed PRV ledger inspection.
- Alternatives and counter-evidence: The PRV does not make the implementation formally verified.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: Private provenance evidence.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0038

- Status: active
- Fact label: Established
- Class: Completed PRV lineage evidence
- Role: Contextual
- Affected IDs: CONTROL-001 through CONTROL-004, OPEN-010, THREAT-011
- Title or description: Earliest supported Beryllium TE and G-stage lineage
- Logical locator: `component://provenance-review/reviews/PRV-20260828-001-helium-te-security-architecture/evidence-ledger.md`
- Revision or checked date: PRV records E0105 through E0109; predecessor `511187f9d1f44c322e3a4a11347584fd8a20dc72`
- Observation: The PRV establishes exact inherited generic Sv39x4 lines and the earliest supported fixed TE policy, exposure authority, complete-request authorization, G-stage construction, and reconciliation checkpoint.
- Relationship: Grounds historical rationale without claiming direct standalone transfer or conceptual origin.
- Confidence: High
- Confidence basis: Completed PRV commit, blame, and chronology analysis.
- Alternatives and counter-evidence: Same-commit plan and implementation do not identify idea origin.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: Direct transfer to the sanitized standalone snapshot remains unresolved.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0039

- Status: active
- Fact label: Established
- Class: Completed PRV prior-art synthesis
- Role: Contextual
- Affected IDs: OPEN-003, THREAT-001, THREAT-009, THREAT-011
- Title or description: Mapping authority, policy-derived enforcement, and semantic-monitoring precedent
- Logical locator: `component://provenance-review/reviews/PRV-20260828-001-helium-te-security-architecture/prior-art-summary.md`
- Revision or checked date: Committed PRV at `d698e7598e44928e4a64d7ebc3de7655cfbefb29`; sources through 2026-08-28
- Observation: The review records strong or adjacent precedent in Type Enforcement, Flask, SELinux mapping permission, capability mapping authority, policy-derived MMU rights, and asynchronous policy-versus-live-state monitoring.
- Relationship: Shows established patterns while leaving the exact target combination unresolved.
- Confidence: Medium
- Confidence basis: Completed PRV cites primary records and records alternatives and inaccessible sources.
- Alternatives and counter-evidence: Asynchronous AVC monitoring is not admission-time PTE reconciliation or immediate fail-stop.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: Primary public records were not independently reopened in this engagement.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0040

- Status: active
- Fact label: Established
- Class: Completed AWB package
- Role: Counter
- Affected IDs: ASSET-006, ASSET-010, THREAT-002, THREAT-003, THREAT-009, MITIGATION-001, OPEN-003
- Title or description: Post-install G-stage readback use-case analysis
- Logical locator: `component://analysis-workbook/sessions/AWB-20260829-001-post-g-install-readback-use-case/`
- Revision or checked date: `2261659a88e16992638e6cc8e64410b0ddd91087`; completed 2026-08-29
- Observation: The package distinguishes software PTE inspection, selector readback, effective translation evidence, and retained-file correspondence; its bounded search found no exact independent post-install G-stage readback precedent.
- Relationship: Refines control and evidence claims around policy-to-live-state checking.
- Confidence: Medium
- Confidence basis: Direct complete package with tiered evidence and supersession records.
- Alternatives and counter-evidence: Terminology and unsearched implementations may differ.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: Broader Beryllium analysis is contextual and absence is bounded.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0041

- Status: active
- Fact label: Established
- Class: Formal-verification research
- Role: Counter
- Affected IDs: OBJECTIVE-004 through OBJECTIVE-006, THREAT-009, MITIGATION-009
- Title or description: Verification strategy and successor-only CBMC evidence
- Logical locator: `component://formal-verification-research/workstreams/beryllium/strategy.md`; `component://formal-verification-research/COLLAB.md`; `workspace://formal-verification/helium-te-fv-pathfinder.md`
- Revision or checked date: Research `8b91ebda1d4a5c733596a67ef7c5cc83486212e9`; workspace `767752792026622bbb06c3fcd29d240b0871a3e9`
- Observation: Research identifies finite policy-to-mapping and transition proof targets and records bounded CBMC work only on successor commits after the frozen target, with assembly, compiler, ISA, hardware, noninterference, and side-channel exclusions.
- Relationship: Provides verification priorities and blocks CBMC inheritance.
- Confidence: High
- Confidence basis: Exact research and coordination ledgers.
- Alternatives and counter-evidence: Successor artifacts may be useful for a later delta model.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: No machine-check result applies to the modeled revision.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0042

- Status: active
- Fact label: Established
- Class: Registered CHERI research
- Role: Contextual
- Affected IDs: THREAT-013, THREAT-014, ASSUMPTION-005
- Title or description: Capability, TE, and CHERI assurance boundaries
- Logical locator: `component://cheri-riscv-notes-repo/wiki/14-Assurance-Lineage.md`; `component://cheri-riscv-notes-repo/sok/gap-analysis.md`
- Revision or checked date: `655309289ee715cbe40690d41b222e3cba05e6b5`
- Observation: The corpus distinguishes TE policy from capability-bounded authority and records allocation, revocation, semantic-integrity, side-channel, and composition gaps.
- Relationship: Contextualizes historical CAP+TE/CHERI prompts without treating them as current controls.
- Confidence: Medium
- Confidence basis: Internal synthesis with primary citekeys.
- Alternatives and counter-evidence: Public primary sources were not independently reopened.
- Sensitivity: internal
- Redistribution: unknown
- Hash: None
- Limitations: Licensing and public-candidate eligibility remain unresolved.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0043

- Status: active
- Fact label: Established
- Class: Registered hypervisor and OS security research
- Role: Contextual
- Affected IDs: THREAT-003, THREAT-013, THREAT-014, ASSUMPTION-001, ASSUMPTION-002
- Title or description: Broader translation, lifecycle, firmware, DMA, and host threats
- Logical locator: `component://xrv-research-repo/riscv-hypervisors-research-stream.md`; `component://xrv-research-repo/review-done/supervisor-domain-isolation-smmtt.md`; `component://osr-claude/smmtt-supervisor-domains-survey.md`
- Revision or checked date: XRV `ca414903b93cab82697a30ec2a57ed62c357d380`; OSR `f2edd17c6ed70f09a9b3db98eec27e54e185612a`
- Observation: Research distinguishes G-stage from firmware and device enforcement and identifies invalidation, identifier reuse, donation/reclaim, DMA, interrupt, debug, attestation, and recovery surfaces in broader systems.
- Relationship: Supplies adjacent attack branches and explicit reasons not to generalize the fixed no-device PoC.
- Confidence: Medium
- Confidence basis: Pinned local research and source manifests.
- Alternatives and counter-evidence: Most surfaces are absent from the fixed target.
- Sensitivity: private
- Redistribution: unknown
- Hash: None
- Limitations: Moving specifications and public source cutoffs were not refreshed.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0044

- Status: active
- Fact label: Established
- Class: Cross-component assurance limit
- Role: Negative
- Affected IDs: MITIGATION-004, MITIGATION-009, THREAT-009, THREAT-013
- Title or description: No inherited formal, hardware, or successor acceptance
- Logical locator: `workspace://formal-verification/helium-te-fv-pathfinder.md`; `workspace://HANDOFF.md`
- Revision or checked date: `767752792026622bbb06c3fcd29d240b0871a3e9`
- Observation: Later formal-work records use the modeled revision as a base but place every CBMC result on later commits; Beryllium acceptance and K3 status likewise do not transfer to Helium.
- Relationship: Prevents successor proof, R7 acceptance, R8-H0 status, or hardware claims from being attached to the target.
- Confidence: High
- Confidence basis: Exact commit lineage and parent assurance wording.
- Alternatives and counter-evidence: A future model may review a successor revision separately.
- Sensitivity: private
- Redistribution: not-approved
- Hash: None
- Limitations: Coordination evidence, not target behavior.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0045

- Status: active
- Fact label: Established
- Class: Distribution and provenance limit
- Role: Direct
- Affected IDs: OBJECTIVE-008, ASSET-010, ASSET-011, THREAT-011, THREAT-012, MITIGATION-006, MITIGATION-007
- Title or description: Private evidence and unresolved redistribution block promotion
- Logical locator: `publication-checklist.md`; `component://provenance-review/reviews/PRV-20260828-001-helium-te-security-architecture/publication-checklist.md`; `component://analysis-workbook/sessions/AWB-20260829-001-post-g-install-readback-use-case/publication-checklist.md`
- Revision or checked date: Checked 2026-09-01
- Observation: The package depends on private/internal target, transcript, PRV, AWB, and research evidence with unknown or not-approved redistribution and has no responsible-human promotion record.
- Relationship: Establishes a promotion blocker despite the intended `public-candidate` request.
- Confidence: High
- Confidence basis: Evidence sensitivities and explicit package gates.
- Alternatives and counter-evidence: A smaller public derivative could be prepared only after traceability-preserving clearance or abstraction.
- Sensitivity: private
- Redistribution: not-applicable
- Hash: None
- Limitations: The agent cannot complete or impersonate the required human record.
- Supersedes: None
- Superseded by: None

## TM-20260901-001-E0046

- Status: active
- Fact label: Unknown
- Class: Research capability limitation
- Role: Negative
- Affected IDs: OPEN-001, OPEN-002, OPEN-003, BLOCKED-003, BLOCKED-004, BLOCKED-005, ASSUMPTION-010
- Title or description: Public primary-source research could not run
- Logical locator: `source://package/search-log.md`
- Revision or checked date: 2026-09-01
- Observation: Three bounded research tasks for RISC-V semantics, VBS boundaries, and TE-to-mapping precedent executed no query because the specialist environment had no public web/search capability; prohibited network clients were not substituted.
- Relationship: Preserves the external-research gap without unsupported findings or negative claims.
- Confidence: High
- Confidence basis: Three independent specialist returns and empty query logs.
- Alternatives and counter-evidence: Existing completed PRV/AWB and registered research remain local secondary evidence.
- Sensitivity: private
- Redistribution: not-applicable
- Hash: None
- Limitations: Public versions, exact sections, current status, and independently verified primary wording remain unknown.
- Supersedes: None
- Superseded by: None
