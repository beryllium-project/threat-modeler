# Source discoveries

Package ID: `TM-20260911-001`
Title: Helium TE PoC Independent Threat Model (GPT-6 Astra)
Created: 2026-09-11
Status: `Complete`
Distribution: `private`

Established: the retained primary-source families were already named in the
target reference document or the supplied local research indexes.
Version-specific cross-index deduplication is incomplete: PM queue provenance
is unavailable, two components are absent, and blind-excluded indexes cannot
be read before freeze. No source is asserted to be new and no `DISC-NNN` or
PM queue entry is allocated. Public accessibility is not redistribution
clearance.

| Candidate source | Version / organization | Stable locator | Evidence IDs | Existing index check and status | Sensitivity / redistribution |
| --- | --- | --- | --- | --- | --- |
| RISC-V H and Supervisor ISA | RISC-V International, edition 20240411 | `https://docs.riscv.org/reference/isa/v20240411/priv/hypervisor.html`; sibling supervisor.html | TM-20260911-001-E0033, TM-20260911-001-E0034, TM-20260911-001-E0035 | Target reference family known; exact-version deduplication unconfirmed | public / unknown |
| SBI reset/legacy specification | Platform Runtime Services TG, v2.0 | `https://github.com/riscv-non-isa/riscv-sbi-doc/tree/v2.0` | TM-20260911-001-E0036 | Target reference family known; release timestamp and cross-index identity incomplete | public / unknown |
| GNU Make manual | GNU/FSF, current section pages | `https://www.gnu.org/software/make/manual/` | TM-20260911-001-E0037 | Target reference family known; unconfirmed cross-index deduplication | public / unknown |
| GCC manual | GNU GCC, 14.2.0 | `https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/` | TM-20260911-001-E0038, TM-20260911-001-E0039 | Target reference family known; unconfirmed version-specific deduplication | public / unknown |
| Clang / LLVM references | LLVM, living compatibility / 20.1.0 IR | `https://clang.llvm.org/compatibility.html`; `https://releases.llvm.org/20.1.0/docs/LangRef.html` | TM-20260911-001-E0040 | Target reference family known; unconfirmed cross-index deduplication | public / unknown |
| Podman run manual | Podman, v5.4.2 | `https://docs.podman.io/en/v5.4.2/markdown/podman-run.1.html` | TM-20260911-001-E0041, TM-20260911-001-E0042 | Target reference family known; unconfirmed version-specific deduplication | public / unknown |
| npm command/lock/lifecycle references | npm, living v10 pages | `https://docs.npmjs.com/cli/v10/` | TM-20260911-001-E0043, TM-20260911-001-E0044 | Target reference family known; unconfirmed cross-index deduplication | public / unknown |

Checked: 2026-09-11. Proposed owner routing is not assigned: architecture
sources could be relevant to `xrv-research-repo`, while compiler/evaluator
ownership needs human or component-owner determination. No sibling index,
source copy, research claim or routing state was modified.
