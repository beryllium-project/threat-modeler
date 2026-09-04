# Threat-model review

Package ID: `TM-20260904-001`
Title: Helium TE PoC Independent Threat Model (Fable 5.1 replay)
Created: 2026-09-04
Status: `Complete`
Distribution: `private`
Latest review iteration: `REVIEW-ITERATION-001`

## Review target

- Mode: `create-from-evidence`
- Source model: None (first projection synthesised from evidence in this package).
- Source revision: `component://helium-te-poc` at `1ab289c066b69acdd8b55c9f77055b0145be1316` (`for-review`, clean); `component://beryllium-repo` at `65f6d895a2007e8e093582cc48726375fd23b563` (clean). See `scope.md`.
- Reviewed projection: `threat-model.md` as frozen after MODEL-ITERATION-001 synthesis and before correction; the corrected projection is the current `threat-model.md`.
- Method: Beryllium hybrid systems-security method; independent write-disabled `threat-model-review` specialist (TM-20260904-001-E0067), findings assigned and dispositioned by the orchestrator.

## Review conclusion

The frozen draft was architecturally faithful to the admitted evidence and
covered every objective, asset, actor, boundary, flow, entry point and STRIDE
category. The review found one risk-arithmetic error (FINDING-002), one class
of over-claiming (test and image results described as observed when nothing
was executed, FINDING-001), three dangling or misdirected evidence
cross-references (FINDING-003), and several completeness and wording items.
All thirteen findings were addressed in the current projection; the
dispositions are recorded per finding. This review does not constitute
approval, acceptance, or sign-off of the target or of the model.

## Strengths retained

- Exact-revision binding with a mid-engagement worktree-switch hazard recorded rather than hidden (TM-20260904-001-E0004).
- Clear separation of the target's assumption from the truth of the assumption after FINDING-009.
- Every threat carries inherent and residual ratings with rationale and uncertainty, and residual risk is repeatedly distinguished from accepted risk.
- Assurance wording (review-and-test PoC; not formally verified; not hardware validated; CBMC only in later lineage; K3 `NOT RUN`) is preserved throughout (TM-20260904-001-E0062, E0053, E0058).
- Counter-evidence and negative results are recorded (stale historical reviews, absent formal artefacts, no divergence test).

## Findings

Each finding must include severity, confidence, fact label, affected stable
IDs, evidence IDs, impact, recommendation, alternatives and counter-evidence,
and limitations.

### FINDING-001: Test and negative-image results were described as observed although nothing was executed

- Severity: High
- Confidence: High
- Fact label: Established
- Affected IDs: THREAT-001, THREAT-003, THREAT-004, THREAT-006, CONTROL-009, CONTROL-010
- Evidence IDs: TM-20260904-001-E0042, TM-20260904-001-E0043, TM-20260904-001-E0044, TM-20260904-001-E0045, TM-20260904-001-E0067
- Impact: Residual rationales used "QEMU runs confirm", "negative images demonstrate", "disassembly tests confirm". No test, image or emulator was executed and no retained result bundle was inspected in this engagement, so the projection over-stated the evidentiary basis of residual `Low` ratings.
- Recommendation: Reword to "the maintained check is designed to detect/require …", add an execution-status statement to the executive summary and residual section, and lower Confidence to `Medium` where the residual rating depends on unobserved test outcomes.
- Alternatives and counter-evidence: The target's own documentation describes the tests as part of its release protocol; that is a design fact, not a result.
- Limitations: None.
- Disposition: Addressed in current projection (THREAT-001/003/004/006 reworded, Confidence `Medium`; executive summary and residual section carry an explicit no-execution statement).

### FINDING-002: THREAT-016 residual 3x3 was labelled `High`

- Severity: High
- Confidence: High
- Fact label: Established
- Affected IDs: THREAT-016
- Evidence IDs: TM-20260904-001-E0067
- Impact: Score 9 is `Moderate` under the package's own bands; the executive summary and residual table repeated the error and ranked THREAT-016 first.
- Recommendation: Correct band to `Moderate`, re-order the highest-risk list, and note that 9 is the upper bound of the band.
- Alternatives and counter-evidence: Re-rating impact to 4 would have produced `High` legitimately; the reviewer judged that the impact of misattribution (bounded objective violation of OBJECTIVE-007) is 3.
- Limitations: None.
- Disposition: Addressed; band corrected to `Moderate`; ordering updated.

### FINDING-003: Dangling or misdirected evidence cross-references

- Severity: Medium
- Confidence: High
- Fact label: Established
- Affected IDs: THREAT-005, THREAT-006, THREAT-016, CONTROL-003, CONTROL-006
- Evidence IDs: TM-20260904-001-E0015, TM-20260904-001-E0022, TM-20260904-001-E0032, TM-20260904-001-E0062, TM-20260904-001-E0063, TM-20260904-001-E0066
- Impact: E0015 cited a never-allocated `E0069`; E0022 and E0032 cited E0054 (a PRV record) for the disassembly test (actually E0045) and E0022 cited E0060 for stale historical findings (actually E0051). Traceability was broken for three records.
- Recommendation: Append superseding records with corrected references; mark originals `superseded`; repoint citations in the projection.
- Alternatives and counter-evidence: None.
- Limitations: Corrections are append-only; the originals remain visible.
- Disposition: Addressed by E0062, E0063, E0066.

### FINDING-004: Missing actor and abuse-case branch for publication bypass and remote network access

- Severity: Medium
- Confidence: Medium
- Fact label: Inferred
- Affected IDs: THREAT-015, THREAT-018, ATTACK-002, ACTOR-010
- Evidence IDs: TM-20260904-001-E0040, TM-20260904-001-E0041, TM-20260904-001-E0067
- Impact: THREAT-018 named only the operator; the party who reads the exposed documentation was unmodelled. ATTACK-002 assumed every claim passes through the gate, omitting direct distribution outside the maintained publication path. Per-surface STRIDE dispositions were implicit in the category rows.
- Recommendation: Add ACTOR-010 (remote network peer), a bypass branch to ATTACK-002, and a per-surface STRIDE disposition table.
- Alternatives and counter-evidence: Repository access control is outside the evidence, so the bypass branch cannot be rated precisely.
- Limitations: None.
- Disposition: Addressed (ACTOR-010, ATTACK-002 branch 6, per-surface STRIDE table).

### FINDING-005: ATTACK-002 had no DOT diagram

- Severity: Low
- Confidence: High
- Fact label: Established
- Affected IDs: ATTACK-002
- Evidence IDs: TM-20260904-001-E0067
- Impact: Markdown/DOT correspondence was incomplete for one of two attack trees.
- Recommendation: Add `diagrams/attack-tree-002.dot` and render it.
- Alternatives and counter-evidence: The contract requires only `attack-tree-001.dot`; this is a completeness improvement, not a validation failure.
- Limitations: None.
- Disposition: Addressed.

### FINDING-006: `data-flows.dot` omitted FLOW-009 and truncated FLOW-007

- Severity: Low
- Confidence: High
- Fact label: Established
- Affected IDs: FLOW-007, FLOW-009
- Evidence IDs: TM-20260904-001-E0034, TM-20260904-001-E0036, TM-20260904-001-E0067
- Impact: The diagram disagreed with the normative flow table.
- Recommendation: Add source→image→start edges for FLOW-009 and console→OpenSBI→serial edges for FLOW-007/008.
- Alternatives and counter-evidence: None.
- Limitations: None.
- Disposition: Addressed and re-rendered.

### FINDING-007: THREAT-014 residual impact lowered without rationale

- Severity: Medium
- Confidence: High
- Fact label: Inferred
- Affected IDs: THREAT-014
- Evidence IDs: TM-20260904-001-E0036, TM-20260904-001-E0037, TM-20260904-001-E0038, TM-20260904-001-E0067
- Impact: Residual impact dropped from 5 to 4 although the credited controls (pinning, two toolchains, hashes) affect likelihood and detectability, not the consequence of a successful compromise. The band moved from `High` to `Moderate` without justification.
- Recommendation: Keep residual impact 5 (2x5 = `High`) or provide explicit rationale.
- Alternatives and counter-evidence: Two-toolchain divergence detection could be argued to bound impact if it is exercised on every run; that is not observed.
- Limitations: None.
- Disposition: Addressed; residual impact 5, `High`, rationale added.

### FINDING-008: Executive summary "three scripted events" was inaccurate

- Severity: Low
- Confidence: High
- Fact label: Established
- Affected IDs: THREAT-003, CONTROL-005
- Evidence IDs: TM-20260904-001-E0025, TM-20260904-001-E0026, TM-20260904-001-E0027
- Impact: The protocol accepts three trap causes but seven scripted events (four ECALLs, three faults); the summary under-described the accepted surface.
- Recommendation: Restate as three causes, seven events, each bound to PC/subject/phase.
- Alternatives and counter-evidence: None.
- Limitations: None.
- Disposition: Addressed.

### FINDING-009: ASSUMPTION-002/003 conflated "assumption made" with "assumption true"; residual-unknowns paragraph stale

- Severity: Medium
- Confidence: High
- Fact label: Established
- Affected IDs: ASSUMPTION-002, ASSUMPTION-003, OPEN-005, OPEN-006
- Evidence IDs: TM-20260904-001-E0010, TM-20260904-001-E0034, TM-20260904-001-E0037, TM-20260904-001-E0052, TM-20260904-001-E0067
- Impact: `Established` was attached to firmware honesty and QEMU conformance, which are `Unknown` in truth. The residual section omitted OPEN-006 and listed OPEN-005 as open although it was answered locally.
- Recommendation: Split the label (assumption made: `Established`; truth: `Unknown`); list OPEN-006 and mark OPEN-005 answered.
- Alternatives and counter-evidence: None.
- Limitations: None.
- Disposition: Addressed.

### FINDING-010: Emulator-only evidence should be stated as such in every residual rating that depends on it

- Severity: Low
- Confidence: High
- Fact label: Established
- Affected IDs: THREAT-001, THREAT-002, THREAT-005, THREAT-006, THREAT-009, THREAT-011
- Evidence IDs: TM-20260904-001-E0060, TM-20260904-001-E0053
- Impact: Some residual uncertainties said "emulator fidelity" without naming hardware `NOT RUN`; consistent phrasing avoids a reader inferring hardware coverage.
- Recommendation: Keep "hardware `NOT RUN`" in the uncertainty line of each emulator-dependent threat.
- Alternatives and counter-evidence: The TCB table and ASSUMPTION-003 already carry the limit.
- Limitations: Editorial.
- Disposition: Addressed where residual rationales were reworded; remaining threats already carried the wording.

### FINDING-011: No public primary source was read for the fence and `htval` clauses

- Severity: Low
- Confidence: High
- Fact label: Established
- Affected IDs: ASSUMPTION-004, THREAT-005, THREAT-017, OPEN-001, OPEN-006
- Evidence IDs: TM-20260904-001-E0064, TM-20260904-001-E0065
- Impact: Only AI-mediated secondary summaries were obtained; the primary specification pages were inaccessible from this environment (BLOCKED-001, BLOCKED-002).
- Recommendation: Record the secondary evidence as such, keep the primary read as an open item, and do not raise confidence above `Medium` on that basis.
- Alternatives and counter-evidence: Summaries were consistent across independent mirrors.
- Limitations: Network access from this environment failed; see `inaccessible-resources.md`.
- Disposition: Addressed; secondary sources recorded, BLOCKED records allocated.

### FINDING-012: Review depended on one specialist pass

- Severity: Low
- Confidence: High
- Fact label: Established
- Affected IDs: REVIEW-ITERATION-001
- Evidence IDs: TM-20260904-001-E0067
- Impact: A single write-disabled reviewer with the same evidence set cannot detect shared blind spots, in particular anything missed by all three evidence specialists.
- Recommendation: Human review (H6) of both this package and the target remains necessary; comparison with the independently produced prior package `TM-20260901-001` is a user-owned follow-up.
- Alternatives and counter-evidence: None.
- Limitations: Structural.
- Disposition: Recorded as residual concern; not addressable within this package.

### FINDING-013: Two orchestrator execution-boundary deviations occurred during research

- Severity: Low
- Confidence: High
- Fact label: Established
- Affected IDs: SEARCH-002, SEARCH-003, BLOCKED-001
- Evidence IDs: TM-20260904-001-E0067
- Impact: While attempting to reach public specification pages after the web tools failed, the orchestrator invoked a network client and an interpreter once (no data was retrieved; no target or sibling content was touched). Separately, an interpreter was used twice to edit this package's own ledger and open-questions files. Neither affected target content or evidence, but both are outside the maintained-helper allowlist.
- Recommendation: Record in `scope.md` and `HANDOFF.md` activity; no artefact depends on the deviations.
- Alternatives and counter-evidence: None.
- Limitations: Self-reported.
- Disposition: Recorded (ACTIVITY-007).

## Completeness and consistency

| Review dimension | Status | Evidence IDs | Notes |
| --- | --- | --- | --- |
| Scope and revision freshness | Complete | TM-20260904-001-E0001, E0004, E0067 | Both targets clean at frozen commits; guard passed start and end of review. |
| Architecture fidelity | Complete | TM-20260904-001-E0006, E0019, E0025, E0066 | Boot, trap, switch and policy flows match source evidence. |
| Assets and objectives | Complete | TM-20260904-001-E0007, E0009 | Eleven assets, seven objectives, all traced. |
| Actors and capabilities | Complete | TM-20260904-001-E0008, E0017, E0041 | ACTOR-010 added (FINDING-004). |
| Trust boundaries and flows | Complete | TM-20260904-001-E0034, E0036 | Diagram corrected (FINDING-006). |
| STRIDE and attack-tree coverage | Complete | TM-20260904-001-E0044, E0067 | Per-surface table and ATTACK-002 DOT added. |
| Controls and mitigations | Complete | TM-20260904-001-E0042, E0045 | Wording bounded to design intent (FINDING-001). |
| Risk rationale | Complete | TM-20260904-001-E0067 | Bands corrected (FINDING-002, FINDING-007). |
| Assumptions and non-goals | Complete | TM-20260904-001-E0010, E0037 | Labels split (FINDING-009). |
| Evidence and claim limits | Complete | TM-20260904-001-E0062, E0063, E0066 | Cross-references repaired; assurance wording preserved. |

## Residual concerns

- Single-pass review (FINDING-012); human H6 review of the target is still incomplete (TM-20260904-001-E0052).
- Primary specification text remains unread (FINDING-011).
- Residual `High` threats (THREAT-013, THREAT-008, THREAT-014) are not accepted risks and require responsible-human decisions outside this package.
