# Approval UX

Use this file for user/operator approval flows.

## Show

Agent name, environment, network, policy ID, rule that triggered approval, programs, assets, amount, recipient, whether recipient is new, simulation status, warnings, expiry, and exact message hash.

## Avoid vague copy

Bad: “Confirm transaction.” “Agent action.” “Sign to continue.”

Good: “Send 25 USDC to wallet ABC...xyz.” “Swap 0.05 SOL to USDC through Jupiter with 0.5% max slippage.”

## Bind approval

Bind approval to transaction message hash, policy decision ID, approver identity, expiry timestamp, and simulation result hash. If transaction changes, approval is invalid.

## States

- Low risk: explain why it is within autonomous policy.
- Approval required: show exact rule and risk.
- Blocked: show exact blocking rule and safe alternative; no one-click bypass.
