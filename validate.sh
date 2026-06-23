#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"
fail() { echo "[fail] $*" >&2; exit 1; }
ok() { echo "[ok] $*"; }
required=(README.md LICENSE install.sh validate.sh skill/SKILL.md skill/wallet-access-models.md skill/policy-engine.md skill/transaction-simulation.md skill/transaction-risk-scoring.md skill/agent-task-threat-model.md skill/signer-integrations.md skill/approval-ux.md skill/audit-logs.md skill/emergency-controls.md skill/testing-fixtures.md skill/references.md schemas/agent-wallet-policy.schema.json examples/policies/conservative-agent-policy.json examples/policies/trading-agent-policy.json examples/policies/marketplace-agent-policy.json)
for file in "${required[@]}"; do [[ -f "$file" ]] || fail "missing required file: $file"; done
ok "required files present"
head -n 1 skill/SKILL.md | grep -q '^---$' || fail "SKILL.md must start with YAML front matter"
grep -q '^name: solana-agent-guardian' skill/SKILL.md || fail "SKILL.md missing skill name"
grep -q '^user-invocable: true' skill/SKILL.md || fail "SKILL.md missing user-invocable flag"
ok "SKILL.md front matter valid"
for target in wallet-access-models.md signer-integrations.md policy-engine.md transaction-simulation.md transaction-risk-scoring.md agent-task-threat-model.md approval-ux.md audit-logs.md emergency-controls.md testing-fixtures.md references.md; do
  grep -q "$target" skill/SKILL.md || fail "SKILL.md does not route to $target"
done
ok "progressive routing links present"
python3 - <<'JSONCHECK'
import json
from pathlib import Path
for p in list(Path('examples').rglob('*.json')) + list(Path('schemas').rglob('*.json')):
    json.loads(p.read_text())
print('[ok] json files parse')
JSONCHECK
if find . -type f \( -name '*.exe' -o -name '*.dll' -o -name '*.dylib' -o -name '*.so' -o -name '*.bin' -o -name '*.wasm' \) | grep -q .; then fail "opaque executable/binary payload found"; fi
ok "no disallowed opaque executable payloads"
if grep -RInE 'curl .*\| *bash|wget .*\| *bash|sudo ' install.sh scripts 2>/dev/null; then fail "remote shell execution or sudo usage detected"; fi
ok "installer scripts are local-only"
grep -RIn "private key" skill README.md SECURITY.md | grep -qi "never\|do not\|avoid\|no raw\|not expose" || fail "private key guardrails not obvious"
ok "private key guardrails present"
echo "Validation complete."
