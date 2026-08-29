# Evidence ledger

Package ID: `TM-20000101-001`
Title: Synthetic isolation fixture
Created: 2000-01-01
Status: `Complete`
Distribution: `private`

Evidence IDs are append-only and unique within the package. A correction adds
a new record and names the superseded record.

## TM-20000101-001-E0001

- Status: active
- Fact label: Established
- Class: Local implementation
- Role: Direct
- Affected IDs: OBJECTIVE-001, ASSET-001, BOUNDARY-001, FLOW-001
- Title or description: Synthetic mediated-read design
- Logical locator: `component://beryllium-repo/design.md`
- Revision or checked date: `1111111111111111111111111111111111111111`
- Observation: The design places the secret behind a trusted request mediator.
- Relationship: Establishes the modeled system boundary and protected asset.
- Confidence: High
- Confidence basis: Direct synthetic design statement.
- Alternatives and counter-evidence: The design does not establish implementation correctness.
- Sensitivity: private
- Redistribution: not-applicable
- Hash: None
- Limitations: Synthetic design evidence only.
- Supersedes: None
- Superseded by: None

## TM-20000101-001-E0002

- Status: active
- Fact label: Established
- Class: Local assurance
- Role: Direct
- Affected IDs: ACTOR-001, ENTRY-001, THREAT-001, CONTROL-001, MITIGATION-001
- Title or description: Synthetic request-validation statement
- Logical locator: `component://beryllium-repo/security.md`
- Revision or checked date: `1111111111111111111111111111111111111111`
- Observation: The subject controls the requested identifier and the monitor validates it against an allowlist.
- Relationship: Establishes attacker control of the entry and the stated existing control.
- Confidence: High
- Confidence basis: Direct synthetic security statement.
- Alternatives and counter-evidence: No independent evidence establishes alias freedom or complete mediation.
- Sensitivity: private
- Redistribution: not-applicable
- Hash: None
- Limitations: The control is stated but not independently verified.
- Supersedes: None
- Superseded by: None
