# Solana Agent Guardian Skill

A production-oriented Solana AI Kit skill for building **policy-controlled Solana AI agents** that can prepare, review, simulate, approve, sign, submit, and audit transactions without giving an autonomous agent unrestricted wallet power.

This is a skill pack for Claude Code, Codex, and other coding agents. It is not a custody provider, not an audit substitute, and not legal/compliance advice.

## Problem

Solana builders are increasingly building agents that can trade, pay users, manage treasuries, operate marketplaces, claim rewards, mint assets, or run recurring protocol operations. The risky part is not just building a transaction; it is deciding whether an AI agent should be allowed to get a signature.

Recurring production failures this skill prevents:

- Raw private keys in `.env`, frontend bundles, logs, prompts, CI output, or source control.
- Agents signing transactions they cannot explain.
- No per-transaction, daily, recipient, program, slippage, or balance-percent limits.
- No simulation before signing.
- No human approval for high-risk actions.
- No audit trail explaining why a transaction was approved or blocked.
- No emergency pause, revoke, key-rotation, or incident runbook.

## What it includes

```text
solana-agent-guardian-skill/
  skill/
    SKILL.md                         # Progressive routing entry point
    wallet-access-models.md          # Safe authority models
    signer-integrations.md           # Browser wallet, KMS/HSM, MPC, multisig boundaries
    policy-engine.md                 # Policy schema and enforcement order
    transaction-simulation.md        # Simulation evidence workflow
    transaction-risk-scoring.md      # ALLOW / APPROVE_REQUIRED / BLOCK / NEEDS_MORE_DATA
    agent-task-threat-model.md       # Prompt injection and marketplace threats
    approval-ux.md                   # Human-readable transaction approval UX
    audit-logs.md                    # Evidence model and log schema
    emergency-controls.md            # Pause, revoke, rotate, postmortem
    testing-fixtures.md              # Test matrix and fixtures
    references.md                    # Primary references and update checklist
  commands/                          # Optional workflow commands
  agents/                            # Optional specialist agent
  rules/                             # Optional safety rule
  schemas/                           # JSON policy schema
  examples/policies/                 # Example policies
  examples/fixtures/                 # Example review fixtures
  scripts/                           # Dependency-free validation helpers
```

## Install

Project install:

```bash
git clone https://github.com/YOUR_USERNAME/solana-agent-guardian-skill.git
cd solana-agent-guardian-skill
bash install.sh --project /path/to/your/solana/project
```

Personal Claude Code install:

```bash
bash install.sh --user
```

Agent-directory install for tools that use `.agents/`:

```bash
bash install.sh --agents --project /path/to/your/project
```

## Validate

```bash
bash validate.sh
python3 scripts/validate_policy.py
python3 scripts/review_fixture.py examples/fixtures/blocked-large-transfer.json examples/policies/conservative-agent-policy.json
```

The installer only copies local files. It does not call `sudo`, install packages, download code, or run remote shell scripts.

## Example prompts

```text
Use solana-agent-guardian to design a safe wallet architecture for an AI trading agent that can only swap through Jupiter, spends at most 0.2 SOL/day, and requires approval for unknown tokens.
```

```text
Use solana-agent-guardian to review this Solana transaction before signing. Decode it, simulate it, compare it to policy, score risk, and return ALLOW / APPROVE_REQUIRED / BLOCK / NEEDS_MORE_DATA.
```

```text
Use solana-agent-guardian to threat-model an agent marketplace where users post tasks and agents receive stablecoin payouts on completion.
```

## Production stance

Default posture:

1. Agent proposes intent, not raw signatures.
2. Backend builds an unsigned transaction.
3. Policy engine evaluates actual transaction bytes, not just the agent description.
4. Simulation runs before signing when available.
5. High-risk cases require human approval.
6. Signer is isolated from the agent runtime.
7. Audit log records intent, transaction, simulation, policy decision, approval, signature, and final outcome.
8. Emergency pause and recovery controls exist before mainnet use.

## Fit with Solana AI Kit

The skill follows the reference shape: `skill/SKILL.md` as a small router, focused markdown files for progressive loading, optional `commands/`, optional `agents/`, optional `rules/`, installer, validator, examples, and MIT license.

## License

MIT. See [LICENSE](LICENSE).
