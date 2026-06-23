#!/usr/bin/env python3
import json, sys
from pathlib import Path
REQUIRED = ['policy_id','network','agent','limits','programs','approval_required','blocked_actions','logging']
NETWORKS = {'localnet','devnet','testnet','mainnet-beta'}
def validate(path):
    data=json.loads(Path(path).read_text()); errors=[]
    for k in REQUIRED:
        if k not in data: errors.append(f'missing {k}')
    if data.get('network') not in NETWORKS: errors.append('invalid network')
    if not data.get('agent',{}).get('name'): errors.append('agent.name required')
    programs=data.get('programs',{})
    if not isinstance(programs.get('allow'),list) or not programs.get('allow'): errors.append('programs.allow must be non-empty')
    if programs.get('deny_unknown') is not True: errors.append('programs.deny_unknown should be true')
    blocked=set(data.get('blocked_actions',[]))
    for expected in ['change_authority','unknown_program_call','policy_update_by_agent']:
        if expected not in blocked: errors.append(f'blocked_actions should include {expected}')
    return errors
paths = sys.argv[1:] or [str(p) for p in sorted(Path('examples/policies').glob('*.json'))]
failed=False
for p in paths:
    try: errs=validate(p)
    except Exception as e: errs=[str(e)]
    if errs:
        failed=True; print(f'[fail] {p}'); [print(f'  - {e}') for e in errs]
    else: print(f'[ok] {p}')
sys.exit(1 if failed else 0)
