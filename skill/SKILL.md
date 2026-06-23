---
name: solana-agent-guardian
description: Safe wallet access, transaction policy, simulation, risk scoring, human approval, signer isolation, audit logs, and emergency controls for Solana AI agents. Use when an AI agent prepares, reviews, signs, requests signatures for, submits, or monitors Solana transactions. Does not replace a professional audit, custody review, or legal/compliance advice.
user-invocable: true
---

# Solana Agent Guardian Skill

This skill helps coding agents design and implement safe transaction-authority boundaries for Solana AI agents.

## Use this skill when

- An AI agent can prepare, request, sign, submit, or monitor Solana transactions.
- A builder wants a limited wallet for trading, payments, marketplace payouts, DAO operations, game economies, or treasury workflows.
- A project needs policy-controlled signing, transaction simulation, risk review, human approval, audit logs, or emergency pause controls.
- User-supplied tasks can influence on-chain actions.

## Do not use this skill for

- General Anchor/native program development without agent wallet authority.
- Full security audits or formal verification.
- Legal, compliance, incorporation, tax, or custody advice.
- Bypassing wallet approvals or custody policies.

## Core stance

An AI agent should not receive unrestricted wallet power. The default pipeline is:

```text
user/task input
  -> intent classifier
  -> unsigned transaction builder
  -> static instruction decoder
  -> policy engine
  -> simulation
  -> risk scorer
  -> human approval if required
  -> isolated signer
  -> broadcaster
  -> confirmation monitor
  -> audit log
  -> emergency controls
```

## Task router

| User request | Load this file | Expected output |
|---|---|---|
| “Give my agent wallet access” | [wallet-access-models.md](wallet-access-models.md) | Safe authority model and anti-patterns |
| “Which signer should I use?” | [signer-integrations.md](signer-integrations.md) | Browser/KMS/MPC/multisig decision matrix |
| “Limit what the agent can do” | [policy-engine.md](policy-engine.md) | Policy manifest and enforcement pipeline |
| “Simulate before signing” | [transaction-simulation.md](transaction-simulation.md) | Simulation workflow and evidence checklist |
| “Review this transaction” | [transaction-risk-scoring.md](transaction-risk-scoring.md) | ALLOW / APPROVE_REQUIRED / BLOCK / NEEDS_MORE_DATA |
| “Build an agent marketplace” | [agent-task-threat-model.md](agent-task-threat-model.md) | Threat model and abuse controls |
| “Add approval screen” | [approval-ux.md](approval-ux.md) | Approval UX copy and warning states |
| “Log signer decisions” | [audit-logs.md](audit-logs.md) | Evidence model and log schema |
| “Something went wrong” | [emergency-controls.md](emergency-controls.md) | Pause/revoke/rotate/postmortem runbook |
| “How do I test this?” | [testing-fixtures.md](testing-fixtures.md) | Test matrix and fixtures |
| “Need source links” | [references.md](references.md) | Primary references and update checklist |

## Default authority order

Prefer this order unless the user gives a strong reason otherwise:

1. No signing: agent only drafts intent or unsigned transactions.
2. User wallet: user signs every transaction.
3. Multisig / DAO approval: agent drafts, humans approve.
4. Managed / MPC wallet with provider-side and app-side policy.
5. Cloud KMS / HSM behind a policy service.
6. Local keypair only for localnet, devnet, tests, CI, or throwaway wallets.

Never recommend a raw mainnet private key in frontend code, prompts, source control, logs, CI output, long-lived memory, or a broad `signAndSend(anyTransaction)` tool.

## Decision values

When reviewing or designing a signing flow, use exactly one of:

- `ALLOW`: within policy and low risk.
- `APPROVE_REQUIRED`: may proceed only after human approval.
- `BLOCK`: violates policy, failed simulation, unknown dangerous action, or unacceptable uncertainty.
- `NEEDS_MORE_DATA`: cannot decode, simulate, or match against policy.

## Red-line actions

Block or escalate by default:

- Full or near-full balance transfers.
- Unknown program call.
- Authority changes: mint, freeze, close, delegate, upgrade, IDL, admin/config.
- Program upgrades, buffer writes, or authority transfers initiated by an agent.
- High-slippage swaps or unapproved routes.
- Account closures returning funds to unknown recipients.
- New recipient above threshold.
- Durable nonce, address lookup table, or CPI complexity that cannot be explained.
- Any request to reveal, export, print, encode, persist, or log private keys or seed phrases.

## Optional commands

- [scaffold-agent-guardian.md](../commands/scaffold-agent-guardian.md)
- [generate-wallet-policy.md](../commands/generate-wallet-policy.md)
- [review-agent-transaction.md](../commands/review-agent-transaction.md)
- [agent-threat-model.md](../commands/agent-threat-model.md)
- [incident-runbook.md](../commands/incident-runbook.md)

## Optional agent

- [agent-wallet-security-engineer.md](../agents/agent-wallet-security-engineer.md)

## Required implementation deliverables

When building code, provide:

- File tree and architecture diagram.
- Policy manifest.
- Unsigned transaction flow.
- Signer boundary.
- Simulation and risk-scoring step.
- Human approval conditions.
- Audit-log schema.
- Emergency controls.
- Tests for allowed, approval-required, blocked, and paused cases.
- Explicit limitations and what still needs professional review.
