# Evidence ledger

Package ID: `@@PACKAGE_ID@@`
Title: @@TITLE@@
Created: @@CREATED@@
Status: `Draft`
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

No evidence has been admitted.
