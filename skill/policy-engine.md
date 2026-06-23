# Policy Engine

Use this file when the user needs limits on what an AI agent can do with a wallet.

## Goal

Evaluate both the agent's declared intent and the actual transaction. Do not trust the agent's description alone.

## Evaluation order

1. Network check.
2. Agent identity and role.
3. Emergency pause status.
4. Intent schema validation.
5. Transaction decoding: programs, accounts, signers, instructions.
6. Program allowlist/denylist.
7. Amount and balance-delta checks.
8. Token allowlist/denylist.
9. Recipient relationship.
10. Slippage/route checks.
11. Authority mutation checks.
12. Simulation result.
13. Velocity limits.
14. Human approval rules.
15. Audit-log write before signer call.

## Minimal policy shape

```json
{
  "policy_id": "trading-agent-mainnet-v1",
  "network": "mainnet-beta",
  "agent": { "name": "research-trading-agent", "environment": "production" },
  "limits": { "max_single_tx_sol": 0.05, "max_daily_spend_sol": 0.25, "max_slippage_bps": 50 },
  "programs": { "allow": ["jupiter", "spl-token", "system-program"], "deny_unknown": true },
  "approval_required": { "new_recipient_above_sol": 0.01, "unknown_token": true, "amount_over_sol": 0.02, "simulation_warnings": true },
  "blocked_actions": ["transfer_full_balance", "change_authority", "program_upgrade", "unknown_program_call"],
  "logging": { "store_intent": true, "store_unsigned_transaction": true, "store_simulation_result": true, "store_policy_decision": true }
}
```

Use `../schemas/agent-wallet-policy.schema.json` and `../examples/policies/`.

## Defaults

Deny unknown programs. Block authority changes. Block full-balance transfers. Require approval for new recipients above threshold. Require simulation for production signing when available. Never let the agent modify its own policy.
