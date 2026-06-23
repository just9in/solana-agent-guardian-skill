# Audit Logs

Use this file when designing evidence trails.

## Required events

Task received, intent normalized, transaction built, policy evaluated, simulation run, risk decision, approval requested, approval granted/denied, signer called, transaction broadcast, confirmation observed, emergency action taken.

## Minimal schema

```json
{
  "event_id": "evt_123",
  "timestamp": "2026-01-01T00:00:00Z",
  "network": "mainnet-beta",
  "agent_id": "agent_abc",
  "task_id": "task_123",
  "policy_id": "trading-agent-v1",
  "policy_version": "1.2.0",
  "decision": "APPROVE_REQUIRED",
  "decision_reasons": ["amount_over_autonomous_threshold"],
  "transaction_message_hash": "...",
  "simulation_hash": "...",
  "approver": "operator@example.com",
  "signature": "...",
  "final_status": "confirmed"
}
```

Never log private keys, seed phrases, bearer tokens, API secrets, provider credentials, or unnecessary sensitive PII.

For high-risk systems, use append-only storage, hash-chained entries, separate logging credentials, and daily exported digests.
