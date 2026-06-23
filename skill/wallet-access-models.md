# Wallet Access Models

Use this file when deciding how a Solana AI agent can interact with wallet authority.

## Principle

The agent expresses intent. A separate transaction service builds, evaluates, simulates, approves, signs, and broadcasts. Keep the signer outside the agent runtime.

## Decision matrix

| Model | Key location | Best for | Risk posture |
|---|---|---|---|
| No signer | Nowhere | Research, quotes, draft-only agents | Safest |
| Browser/mobile wallet | User wallet | Consumer dApps and user funds | Strong user control |
| Multisig / DAO | Multisig or governance | Treasury and admin ops | Strong approval trail |
| Managed/MPC wallet | Provider infrastructure | Embedded wallets and bounded automation | Good if policy is strong |
| Cloud KMS/HSM | Dedicated key service | Backend services and institutional ops | Good if isolated and monitored |
| Local keypair | File/env var | Localnet, devnet, tests, CI | Not mainnet default |

## Recommended architecture

```text
Agent runtime -> intent JSON -> policy service -> unsigned tx -> simulation -> approval -> signer -> broadcaster -> audit log
```

## Patterns

### Draft-only agent

Use for prototypes, untrusted tasks, large funds, and no approval UX. The agent can build or explain unsigned transactions but cannot sign.

### Human-in-the-loop agent

Use when user funds are involved. The agent prepares the transaction; a user signs through a browser/mobile wallet or an operator console.

### Policy-controlled service wallet

Use for bounded autonomous execution: small recurring payments, reward claims, low-value swaps, or agent-owned funds. Minimum controls: program allowlist, amount limits, daily limits, new-recipient thresholds, simulation, audit logs, emergency pause.

### Multisig treasury agent

Use for DAO/company treasuries, admin operations, and upgrades. The agent drafts proposals only.

## Anti-patterns

Do not implement: mainnet key in prompts, frontend bundle, git, logs, broad `signAndSend(anyTransaction)`, auto-signing raw user text, or unlimited trading/treasury wallets.
