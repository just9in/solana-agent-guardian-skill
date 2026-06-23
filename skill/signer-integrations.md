# Signer Integrations

Use this file when choosing or implementing a signing backend.

## Rule

The signer accepts approved transaction messages, not arbitrary agent instructions.

## Browser/mobile wallet

Best for user-owned funds. Show decoded transaction, simulation status, warnings, and exact amount before prompting the wallet. If the transaction is rebuilt, re-run policy, simulation, and approval.

## Multisig / DAO

Best for treasuries, upgrades, and admin actions. Agent drafts proposals; humans approve. Store proposal ID and final signatures in the audit log.

## Managed/MPC wallet

Best for embedded wallets or bounded autonomous low-value operations. Use both provider-side policy and app-side policy. Capture provider webhook/audit events.

## Cloud KMS/HSM

Best for backend services. The signer service must be separated from the app server, require an approval ID, reject expired approvals, and never export raw key material.

## Local keypair

Only for local validator, devnet throwaway wallets, tests, and CI. Do not use as production default.

## Preferred signer request

```json
{
  "approval_id": "approval_abc123",
  "policy_id": "trading-agent-v1",
  "message_hash": "hash_of_approved_message",
  "transaction_base64": "...",
  "expires_at": "2026-01-01T00:05:00Z"
}
```

Signer controls: validate approval ID, validate message hash, check expiry, refuse mutation after approval, write independent logs, and never return private key material.
