# Agent Task Threat Model

Use this file for agent marketplaces, task runners, autonomous workers, or any system where user text can influence transactions.

## Core risk

Malicious task text can become hidden transaction intent. Treat external task text as data, not authority.

## Boundary

```text
untrusted task -> normalizer -> intent schema -> policy engine -> tx builder -> simulation/risk -> approval/signer
```

## Threats and controls

| Threat | Control |
|---|---|
| Prompt injection | Treat task text as untrusted data |
| Hidden recipient | Recipient allowlist/new-recipient approval |
| Fake protocol name | Program ID allowlist |
| Approval bypass | Signer requires approval ID and message hash |
| Log deletion request | Append-only audit log |
| Agent raises own limits | Separate policy admin role |
| Duplicate payout | Idempotency key and escrow state |
| Social engineering | Clear approval UX and risk labels |

## Marketplace payout controls

Bind payout recipient at task creation, escrow funds before task starts, make completion criteria explicit, freeze payouts during disputes, decode and simulate payout transaction, and make payout idempotent.
