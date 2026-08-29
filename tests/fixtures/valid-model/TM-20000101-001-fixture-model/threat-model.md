# Formal threat model

Package ID: `TM-20000101-001`
Title: Synthetic isolation fixture
Created: 2000-01-01
Status: `Complete`
Distribution: `private`
Latest model iteration: `MODEL-ITERATION-001`

## Executive summary

The fixture models one untrusted subject attempting to read a secret through a
request flow mediated by a trusted monitor. The direct evidence supports the
boundary and a validation control, but the control is not independently
verified, so residual disclosure risk remains Moderate.

## Fact labels

- `Established`: directly supported by admitted evidence.
- `Inferred`: reasoned from evidence with alternatives and limitations.
- `Proposed`: a candidate design, control, or mitigation.
- `Unknown`: evidence is missing or conflicting.

## System boundary and lifecycle

The trusted monitor receives one request from an untrusted subject, validates
the requested object identifier, and either returns public data or denies
access to the secret. Creation, update, and teardown are outside this fixture.

## Security objectives

| Objective ID | Label | Objective | Evidence IDs | Confidence | Limitations |
| --- | --- | --- | --- | --- | --- |
| OBJECTIVE-001 | Established | Prevent the untrusted subject from reading the fixture secret. | TM-20000101-001-E0001 | High | Synthetic design statement only. |

## Protected assets

| Asset ID | Label | Asset | Required property | Owner or authority | Evidence IDs | Confidence |
| --- | --- | --- | --- | --- | --- | --- |
| ASSET-001 | Established | Fixture secret | Confidentiality | Trusted monitor | TM-20000101-001-E0001 | High |

## Actors and capabilities

| Actor ID | Label | Actor | Trust | Access and capabilities | Goals | Evidence IDs | Confidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ACTOR-001 | Established | Untrusted subject | Untrusted | Submit arbitrary object identifiers through ENTRY-001 | Read ASSET-001 | TM-20000101-001-E0002 | High |

## Trusted computing base and dependencies

The trusted monitor and its object-identifier validation are inside the TCB.
Compiler, runtime, and hardware behavior are assumed by this synthetic model.

## Components and interfaces

The model contains the untrusted subject, the trusted monitor, and the private
secret store. The request interface is the only modeled interface.

## Trust boundaries

| Boundary ID | Label | Boundary | Crossing parties | Enforcement | Evidence IDs | Confidence |
| --- | --- | --- | --- | --- | --- | --- |
| BOUNDARY-001 | Established | Subject-to-monitor request boundary | ACTOR-001 and trusted monitor | CONTROL-001 | TM-20000101-001-E0001, TM-20000101-001-E0002 | High |

## Data and control flows

| Flow ID | Label | Source | Destination | Data or authority | Boundary IDs | Protection | Evidence IDs |
| --- | --- | --- | --- | --- | --- | --- | --- |
| FLOW-001 | Established | ACTOR-001 | Trusted monitor | Object identifier and read request | BOUNDARY-001 | CONTROL-001 validates the identifier | TM-20000101-001-E0001 |

## Entry points and attack surface

| Entry ID | Label | Entry point | Exposed to | Input or operation | Validation or mediation | Evidence IDs |
| --- | --- | --- | --- | --- | --- | --- |
| ENTRY-001 | Established | Read request | ACTOR-001 | Arbitrary object identifier | CONTROL-001 | TM-20000101-001-E0002 |

## Threat catalogue

### THREAT-001: Secret disclosure through identifier confusion

- Fact label: Inferred
- STRIDE: Information disclosure
- Scenario: ACTOR-001 submits an identifier that aliases ASSET-001 and receives secret data.
- Preconditions: ENTRY-001 accepts an attacker-controlled identifier and CONTROL-001 is incomplete or bypassed.
- Asset IDs: ASSET-001
- Objective IDs: OBJECTIVE-001
- Actor IDs: ACTOR-001
- Surface IDs: BOUNDARY-001, FLOW-001, ENTRY-001
- Existing control IDs: CONTROL-001
- Mitigation IDs: MITIGATION-001
- Inherent likelihood: 4
- Inherent impact: 5
- Inherent risk: Critical
- Inherent rationale: An attacker controls the only entry identifier and disclosure would expose the protected secret.
- Residual likelihood: 2
- Residual impact: 4
- Residual risk: Moderate
- Residual rationale: CONTROL-001 reduces direct selection but alias freedom and implementation correctness are unverified.
- Risk uncertainty: No implementation, model-checking, or runtime evidence was admitted.
- Confidence: High
- Evidence IDs: TM-20000101-001-E0001, TM-20000101-001-E0002
- Status: Partially mitigated
- Alternatives and counter-evidence: The identifier space may be non-aliasing, but the fixture does not prove that property.
- Limitations: No implementation or execution evidence was admitted.

## Attack trees and abuse cases

### ATTACK-001: Read the fixture secret

The attacker succeeds if it can cross BOUNDARY-001 through ENTRY-001 with an
identifier accepted as public but resolved as ASSET-001. The maintained DOT
source records the same single-path tree.

## Existing controls

| Control ID | Label | Control | Threat IDs | Evidence IDs | Effectiveness | Confidence | Limitations |
| --- | --- | --- | --- | --- | --- | --- | --- |
| CONTROL-001 | Established | Validate the requested identifier against the public-object allowlist. | THREAT-001 | TM-20000101-001-E0002 | Reduces accidental and direct unauthorized selection | Medium | No proof of alias freedom or implementation correctness. |

## Mitigation and verification plan

| Mitigation ID | Label | Mitigation | Threat IDs | Verification approach | Owner | Status | Evidence IDs |
| --- | --- | --- | --- | --- | --- | --- | --- |
| MITIGATION-001 | Proposed | Prove canonical identifier resolution and test all alias classes. | THREAT-001 | Model check the resolver and add adversarial tests | Responsible human to assign | Open | TM-20000101-001-E0002 |

## Assumptions and non-goals

### ASSUMPTION-001: Trusted monitor integrity

The monitor, compiler, runtime, and hardware are assumed correct. Availability
and physical attacks are explicit non-goals.

## Risk method

Likelihood and impact use integer values from 1 through 5. The risk band is:

- `Low`: product 1-4.
- `Moderate`: product 5-9.
- `High`: product 10-16.
- `Critical`: product 17-25.

Inherent risk is assessed before credited controls. Residual risk is assessed
after only evidence-supported controls. Risk acceptance is a responsible-human
decision and is not recorded by this fixture.

## Coverage matrix

| Surface ID | Surface type | Threat IDs or explicit disposition | Coverage | Evidence IDs | Limitation |
| --- | --- | --- | --- | --- | --- |
| OBJECTIVE-001 | Security objective | THREAT-001 | Complete | TM-20000101-001-E0001 | Synthetic scope |
| ASSET-001 | Asset | THREAT-001 | Complete | TM-20000101-001-E0001 | Synthetic scope |
| ACTOR-001 | Actor | THREAT-001 | Complete | TM-20000101-001-E0002 | Synthetic scope |
| BOUNDARY-001 | Trust boundary | THREAT-001 | Complete | TM-20000101-001-E0001 | Synthetic scope |
| FLOW-001 | Flow | THREAT-001 | Complete | TM-20000101-001-E0001 | Synthetic scope |
| ENTRY-001 | Entry point | THREAT-001 | Complete | TM-20000101-001-E0002 | Synthetic scope |

## Residual risk and unknowns

Residual risk remains Moderate because the fixture states the validation
control but provides no proof or implementation evidence. Risk acceptance is
not recorded.
