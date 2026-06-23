# Transaction Simulation

Use this file when reviewing a transaction before signing or broadcasting.

## Goal

Simulation helps detect errors, logs, compute usage, fees, account changes, token balance changes, inner instructions, and unexpected side effects before signing. It is evidence, not a guarantee.

## Workflow

```text
transaction -> normalize -> decode static instructions -> simulateTransaction -> collect err/logs/units/balances -> compare with policy -> risk score -> approve/block/escalate
```

## Capture

Input: network, RPC, commitment, transaction version, blockhash, lookup tables, signers, programs, account metas, policy ID/version.

Output: error, logs, units consumed, fee, pre/post SOL balances, pre/post token balances, inner instructions, return data, replacement blockhash.

## Default decisions

- `err = null` and side effects match policy: continue to risk score.
- `err != null`: `BLOCK`.
- RPC unavailable: `NEEDS_MORE_DATA`.
- Unknown CPI/logs: `APPROVE_REQUIRED` or `BLOCK` depending on policy.
- Balance deltas exceed policy: `BLOCK`.

## Caveats

Final execution can differ because state changes, blockhash expiry, oracle/pool changes, priority fee changes, lookup table changes, or nonce changes. Re-simulate if transaction is rebuilt and bind approval to the exact message hash.
