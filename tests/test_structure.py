from pathlib import Path
import json, subprocess, sys
ROOT = Path(__file__).resolve().parents[1]

def test_required_files_exist():
    for rel in ['README.md','LICENSE','install.sh','validate.sh','skill/SKILL.md','schemas/agent-wallet-policy.schema.json']:
        assert (ROOT/rel).exists(), rel

def test_skill_routes():
    text=(ROOT/'skill/SKILL.md').read_text()
    for name in ['wallet-access-models.md','signer-integrations.md','policy-engine.md','transaction-simulation.md','transaction-risk-scoring.md','agent-task-threat-model.md','approval-ux.md','audit-logs.md','emergency-controls.md','testing-fixtures.md','references.md']:
        assert name in text
        assert (ROOT/'skill'/name).exists()

def test_json_parses():
    for p in list((ROOT/'examples').rglob('*.json')) + list((ROOT/'schemas').rglob('*.json')):
        json.loads(p.read_text())

def test_fixture_smoke():
    for fixture in (ROOT/'examples/fixtures').glob('*.json'):
        f=json.loads(fixture.read_text())
        policy=ROOT/'examples/policies'/f['policy_hint']
        r=subprocess.run([sys.executable,str(ROOT/'scripts/review_fixture.py'),str(fixture),str(policy)], cwd=ROOT, text=True, capture_output=True)
        assert r.returncode == 0, r.stdout + r.stderr
