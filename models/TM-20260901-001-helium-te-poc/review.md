# Threat-model review

Package ID: `TM-20260901-001`
Title: Helium TE PoC Initial Threat Model
Created: 2026-09-01
Status: `Complete`
Distribution: `private`
Latest review iteration: `REVIEW-ITERATION-001`

## Review target

- Mode: `create-from-evidence`
- Source model: None; this is an independent review of the synthesized initial projection.
- Source revision: `1ab289c066b69acdd8b55c9f77055b0145be1316`
- Reviewed projection: `threat-model.md`
- Method: Beryllium hybrid systems-security method.

## Review conclusion

Independent read-only review found five actionable internal-consistency
issues: unexecuted verification source received risk credit, three core
threats reduced consequence impact without containment, coverage links were
not bidirectionally consistent, two diagrams inverted or bypassed flow
semantics, and current package traceability lagged the model iteration. All
five were corrected. A second review verified findings 2-5 and found a narrow
remaining CONTROL-009/010 credit leak; that was corrected, and a final
read-only check confirmed full reconciliation.

The projection is complete and traceable for its frozen private scope. This
review is not approval, sign-off, risk acceptance, release approval,
publication approval, formal verification, or hardware validation.

## Strengths retained

The model consistently binds current facts to one clean target revision,
keeps historical chats and AI reviews non-authoritative, excludes dirty
overlays, preserves exact assurance boundaries, separates target and evidence
TCBs, maps all STRIDE categories to concrete surfaces, records open questions
without inventing answers, and distinguishes implemented source controls from
unexecuted verification design. All 5x5 products and bands are arithmetically
correct after reconciliation.

## Findings

Each finding must include severity, confidence, fact label, affected stable
IDs, evidence IDs, impact, recommendation, alternatives and counter-evidence,
and limitations.

### FINDING-001: Unexecuted verification design received residual-risk credit

- Severity: High
- Confidence: High
- Fact label: Established
- Affected IDs: CONTROL-009, CONTROL-010, THREAT-001 through THREAT-007, THREAT-009, THREAT-013
- Evidence IDs: TM-20260901-001-E0018, TM-20260901-001-E0019, TM-20260901-001-E0022, TM-20260901-001-E0026
- Impact: Treating test and runner source as exercised controls could understate frozen-revision likelihood.
- Recommendation: Retain source as verification design but give it no residual-risk credit until an exact frozen-revision execution record is admitted.
- Alternatives and counter-evidence: Historical runs and current source establish readiness and intent, not current execution.
- Limitations: The finding does not assess whether the tests would pass.
- Resolution: Resolved. CONTROL-009/010 explicitly receive no current risk-reduction credit, their links are evidence-bounded, and no threat's existing-control list includes them.

### FINDING-002: Core residual impacts lacked consequence containment

- Severity: High
- Confidence: High
- Fact label: Inferred
- Affected IDs: THREAT-002, THREAT-003, THREAT-005
- Evidence IDs: TM-20260901-001-E0004 through TM-20260901-001-E0012, TM-20260901-001-E0037, TM-20260901-001-E0046
- Impact: Preventive checks reduced residual impact from 5 to 4 without identifying a control that limits consequences after bypass.
- Recommendation: Retain impact 5 and adjust only likelihood unless a consequence-containment control is evidenced.
- Alternatives and counter-evidence: The finite PoC bounds system scope, but inherent ratings already used impact 5 under that scope.
- Limitations: Risk judgment remains analytical, not demonstrated exploitability.
- Resolution: Resolved. All three threats retain residual impact 5 and residual risk High.

### FINDING-003: Coverage links were not bidirectionally consistent

- Severity: Medium
- Confidence: High
- Fact label: Established
- Affected IDs: THREAT-001, THREAT-003 through THREAT-005, THREAT-007 through THREAT-009, THREAT-013, THREAT-014 and linked objectives, assets, actors, flows, and entries
- Evidence IDs: TM-20260901-001-E0005 through TM-20260901-001-E0024, TM-20260901-001-E0037, TM-20260901-001-E0040, TM-20260901-001-E0041, TM-20260901-001-E0043, TM-20260901-001-E0044, TM-20260901-001-E0046
- Impact: Rows marked Complete omitted declared threat links or contained matrix-only associations.
- Recommendation: Reconcile both directions from one relationship set before claiming complete coverage.
- Alternatives and counter-evidence: Every threat and STRIDE class was present; this was traceability rather than missing threat-class coverage.
- Limitations: No new target behavior was inferred during correction.
- Resolution: Resolved. Independent re-review confirmed every identified association now agrees.

### FINDING-004: Normative diagrams disagreed with Markdown flow mediation

- Severity: Medium
- Confidence: High
- Fact label: Established
- Affected IDs: FLOW-004 through FLOW-006, FLOW-008, FLOW-010, BOUNDARY-004, BOUNDARY-007, BOUNDARY-008
- Evidence IDs: TM-20260901-001-E0003, TM-20260901-001-E0009 through TM-20260901-001-E0012, TM-20260901-001-E0016, TM-20260901-001-E0020
- Impact: Inverted actor-flow arrows and direct writer-to-reader routing could obscure attacker control and monitor mediation.
- Recommendation: Align DOT sources with Markdown source, destination, mediator, and trust-zone semantics.
- Alternatives and counter-evidence: The data-flow DOT and Markdown were already substantially correct.
- Limitations: The issue was diagram semantics, not implementation behavior.
- Resolution: Resolved. Writer/reader flow directions, monitor-mediated BOUNDARY-004, and host/evaluator BOUNDARY-007/008 now correspond; SVGs were regenerated.

### FINDING-005: Current package traceability lagged the model iteration

- Severity: Low
- Confidence: High
- Fact label: Established
- Affected IDs: MODEL-ITERATION-001, TM-20260901-001-E0001 through TM-20260901-001-E0046, OPEN-004 through OPEN-011
- Evidence IDs: TM-20260901-001-E0001 through TM-20260901-001-E0046
- Impact: Stale handoff, discovery, and open-question text could cause consumers to repeat completed work or lose candidate-to-evidence links.
- Recommendation: Update current projections while preserving append-only activity and iteration history.
- Alternatives and counter-evidence: Historical activity rows remain unchanged.
- Limitations: No technical risk rating changed from this correction.
- Resolution: Resolved. Discovery, open questions, handoff, and current iteration identify admitted evidence and current next action.

## Completeness and consistency

| Review dimension | Status | Evidence IDs | Notes |
| --- | --- | --- | --- |
| Scope and revision freshness | Complete | TM-20260901-001-E0001, TM-20260901-001-E0035, TM-20260901-001-E0036 | Exact revisions and dirty exclusions are consistent. |
| Architecture fidelity | Complete | TM-20260901-001-E0003 through TM-20260901-001-E0016 | Fixed runtime and host assurance boundaries correspond to evidence. |
| Assets and objectives | Complete | TM-20260901-001-E0004 through TM-20260901-001-E0014 | All stated relationships are bidirectionally traced. |
| Actors and capabilities | Complete | TM-20260901-001-E0003, TM-20260901-001-E0014 through TM-20260901-001-E0021 | Trusted, untrusted, supply, reviewer, and human roles are separated. |
| Trust boundaries and flows | Complete | TM-20260901-001-E0003 through TM-20260901-001-E0021 | Markdown and normative DOT semantics agree after correction. |
| STRIDE and attack-tree coverage | Complete | TM-20260901-001-E0005 through TM-20260901-001-E0025 | All categories and fourteen threats map to concrete surfaces and three trees. |
| Controls and mitigations | Complete | TM-20260901-001-E0005 through TM-20260901-001-E0026, TM-20260901-001-E0041, TM-20260901-001-E0045, TM-20260901-001-E0046 | Unexecuted verification design receives no current risk credit. |
| Risk rationale | Complete | TM-20260901-001-E0004 through TM-20260901-001-E0025 | Arithmetic and bands are correct; consequence impact is retained where not contained. |
| Assumptions and non-goals | Complete | TM-20260901-001-E0014, TM-20260901-001-E0022, TM-20260901-001-E0025, TM-20260901-001-E0028 through TM-20260901-001-E0046 | Unknowns remain explicit. |
| Evidence and claim limits | Complete | TM-20260901-001-E0002, TM-20260901-001-E0017, TM-20260901-001-E0022, TM-20260901-001-E0035, TM-20260901-001-E0041, TM-20260901-001-E0044 through TM-20260901-001-E0046 | No formal, hardware, acceptance, promotion, or public-research claim is overstated. |

## Residual concerns

OPEN-001 through OPEN-011 remain unresolved but non-blocking for this private
initial projection. They limit portability, nested-trap confidence, exact
current execution assurance, shutdown confidentiality, historical
authentication, evidence authenticity, and any future public-candidate
request. The review does not accept these risks or authorize promotion.
