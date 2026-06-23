# Emergency Controls

Use this file for pause, revoke, rotation, and incident response.

## Required before mainnet

Global pause, per-agent pause, per-wallet pause, policy rollback, signer credential rotation, provider credential rotation, program allowlist freeze, human-approval-only mode, incident notification channel, and postmortem template.

## Runbook

1. Freeze new signing.
2. Preserve logs.
3. Identify affected agent, wallet, policy, and timeframe.
4. List recent signatures.
5. Compare policy decisions with final chain outcomes.
6. Revoke or rotate compromised authority.
7. Patch policy/code.
8. Add regression fixture.
9. Run validation.
10. Restore in reduced-risk mode.

Break-glass should require at least two human approvers, short expiry, explicit reason, log entry, and post-incident review.
