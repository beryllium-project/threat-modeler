# Threat-material discovery

Package ID: `TM-20000101-001`
Title: Synthetic isolation fixture
Created: 2000-01-01
Status: `Complete`
Distribution: `private`

## Search boundary

- Registered target set: `component://beryllium-repo`.
- Exact revisions: `1111111111111111111111111111111111111111`.
- Filename families: threat, security, architecture, risk, assumption, attack, review, assurance, design.
- Content families: threat model, threat-model delta, assets, adversary, TCB, trust boundary, attack surface, flow, entry point, security objective, non-goal, fail-closed, mediation, side channel, abuse case, residual risk.
- Restricted exclusion: `component://osr-claude/sources/restricted-microsoft/`.

## Candidate inventory

| Candidate | Class | Logical locator | Revision | Authority | Coverage | Conflicts or limits | Evidence IDs |
| --- | --- | --- | --- | --- | --- | --- | --- |
| CANDIDATE-001 | architecture or design input | `component://beryllium-repo/design.md` | `1111111111111111111111111111111111111111` | Fixture source | Boundary and intended denial | No standalone model | TM-20000101-001-E0001 |
| CANDIDATE-002 | assumptions, limits, or non-goals input | `component://beryllium-repo/security.md` | `1111111111111111111111111111111111111111` | Fixture source | Attacker and control | Synthetic only | TM-20000101-001-E0002 |

## Negative results

| Target or tier | Query family | Result | Evidence IDs | Limitation |
| --- | --- | --- | --- | --- |
| Fixture target | Formal threat-model filename | No result | TM-20000101-001-E0001 | The model had to be synthesized from fragments. |

## Mode recommendation

- Recommended mode: Create model from available evidence.
- Basis: No formal model exists; direct design and security fragments exist.
- User-confirmed mode: Create model from available evidence.
- Authoritative source model: None.
