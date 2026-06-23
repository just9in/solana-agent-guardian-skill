# Wallet Safety Rule

Apply when editing files that create, sign, submit, approve, or store Solana transactions or keys.

## Hard rules

- Do not put real private keys or seed phrases in code, tests, logs, docs, examples, prompts, or CI.
- Do not expose unrestricted `signAndSend(anyTransaction)` to an AI agent.
- Do not let an agent alter its own wallet policy.
- Do not sign before policy evaluation.
- Do not sign before simulation when simulation is available and required by policy.
- Do not display vague approval text for transactions that move funds.
- Do not delete audit logs during normal agent operation.

## Required checks

Identify key location, signer boundary, policy check, simulation/risk check, approval condition, audit log, and emergency pause behavior.
