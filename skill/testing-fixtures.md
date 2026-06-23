# Testing Fixtures

Use this file when adding tests.

## Categories

Allowed: small approved swap/transfer within limits, read-only preparation, devnet transaction using throwaway key.

Approval required: new recipient above threshold, amount above autonomous threshold, unknown token with low amount, simulation warning.

Blocked: full-balance transfer, unknown program call, authority change, program upgrade, failed simulation, undecodable transaction, policy update by agent, prompt injection requesting private key export, account closure to unknown recipient.

Operational: approval expired, transaction mutated after approval, policy version changed after approval, emergency pause active, daily spend exceeded, duplicate payout replay.

## Included fixtures

- `examples/fixtures/allowed-small-swap.json`
- `examples/fixtures/blocked-large-transfer.json`
- `examples/fixtures/blocked-unknown-program-call.json`
- `examples/fixtures/blocked-authority-change.json`
- `examples/fixtures/malicious-task-prompt.md`

Every test asserts decision, triggered rules, human explanation, simulation handling, audit log emitted, and signer not called for blocked cases.
