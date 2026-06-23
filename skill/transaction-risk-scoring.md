# Transaction Risk Scoring

Use this file when reviewing a transaction or building a review system.

## Decisions

- `ALLOW`: low risk and policy-compliant.
- `APPROVE_REQUIRED`: acceptable only with human approval.
- `BLOCK`: violates policy or contains unacceptable uncertainty.
- `NEEDS_MORE_DATA`: cannot decode, simulate, or evaluate.

## Risk categories

Signer, program, asset, amount, recipient, authority, simulation, CPI complexity, prompt/task influence, and operational state.

## Default blocking conditions

Unknown program with signer authority, full-balance transfer, authority change, program upgrade, failed simulation, undecodable transaction, missing policy, policy update by agent, task prompt asking for key export or hidden transfer.

## Report format

```text
Decision: BLOCK
Confidence: high
Summary: Transaction transfers 92% of SOL balance to a new recipient.
Policy matches: transfer_full_balance, max_single_tx_sol exceeded, new_recipient_above_sol
Programs: System Program transfer
Simulation: pass
Risk categories: amount=critical, recipient=high, program=low
Next action: reject automatically; do not call signer.
```

Always explain in human language, not only account metas.
