# Threat-model scope

Package ID: `TM-20000101-001`
Title: Synthetic isolation fixture
Created: 2000-01-01
Status: `Complete`
Phase: `Complete`
Mode: `create-from-evidence`
Distribution: `private`
Latest model iteration: `MODEL-ITERATION-001`
Latest review iteration: `REVIEW-ITERATION-001`

## Target snapshot

| Target | Logical locator | Revision | Worktree state | Included dirty paths | Checked |
| --- | --- | --- | --- | --- | --- |
| Fixture target | `component://beryllium-repo` | `1111111111111111111111111111111111111111` | clean | None | 2000-01-01 |

## Effective scope

- System or subsystem boundary: One trusted monitor and one untrusted subject.
- Selected source model: None; the fixture uses design evidence.
- Included surfaces: One request flow across one trust boundary.
- Exclusions: Availability and physical attacks.
- Security objectives: Preserve the fixture secret from the untrusted subject.
- Review depth: Focused.
- Public research: Not required for this synthetic fixture.
- Target commands: None; target execution is prohibited.
- Write boundary: This package and repository only.
- Known limitations: Synthetic evidence does not establish a real system claim.

## Confirmation

- Discovery-mode choice: Create model from available evidence.
- Scope confirmation: Confirmed.
- Responsible human: Synthetic fixture actor.
- Confirmation date: 2000-01-01.

## Activity

| Activity ID | Date | Actor | Action | Evidence IDs | Notes |
| --- | --- | --- | --- | --- | --- |
| ACTIVITY-001 | 2000-01-01 | Threat-modeler | Allocated a private package. | None | Synthetic fixture. |
| ACTIVITY-002 | 2000-01-01 | Threat-modeler | Completed the model and review. | TM-20000101-001-E0001, TM-20000101-001-E0002 | Synthetic fixture. |
