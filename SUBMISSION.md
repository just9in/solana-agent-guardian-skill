# Submission Draft

Use this when filling the Superteam questionnaire and PR description.

## Skill name

Solana Agent Guardian Skill

## Public repo

```text
https://github.com/just9in/solana-agent-guardian-skill
```

## PR to skill-bounty

```text
https://github.com/solanabr/skill-bounty/pull/YOUR_PR_NUMBER
```

## What problem does it solve?

Solana builders are starting to build AI agents that can prepare or execute on-chain transactions. The production risk is not only generating the transaction; it is preventing an autonomous agent from getting unrestricted wallet authority. This skill gives coding agents a conservative workflow for wallet access models, signer isolation, policy limits, transaction simulation, risk scoring, human approval, audit logs, and emergency response.

## Why is it useful?

Every serious Solana AI agent eventually needs wallet interaction: trading, payments, marketplace payouts, DAO operations, treasury workflows, game economies, or recurring protocol operations. Without a reusable safety skill, teams are likely to copy keys into `.env`, skip simulation, miss policy checks, or ship signing flows with no audit trail.

## Why is it novel?

Most skills focus on building programs, integrating protocols, trading, deployment, or audits. This skill focuses on the dangerous boundary between autonomous AI behavior and real wallet authority. It is cross-domain: Solana transactions, backend signer design, AI-agent threat modeling, approval UX, security operations, and incident response.

## What is included?

- Progressive `skill/SKILL.md` hub.
- Focused wallet, policy, simulation, risk, approval, audit, and incident files.
- Optional commands for scaffolding, policy generation, transaction review, threat modeling, and incidents.
- One specialized `agent-wallet-security-engineer` agent.
- Policy schema, example policies, fixtures, validator, installer, CI, and MIT license.

## Install

```bash
git clone https://github.com/just9in/solana-agent-guardian-skill.git
cd solana-agent-guardian-skill
bash install.sh --project /path/to/project
```

## Validate

```bash
bash validate.sh
```
