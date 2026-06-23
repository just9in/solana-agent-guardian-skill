#!/usr/bin/env python3
import json, sys
from pathlib import Path

def review(fixture, policy):
    reasons=[]; tx=fixture.get('decoded_transaction',{})
    if policy.get('network') == 'mainnet-beta' and fixture.get('simulation',{}).get('status') != 'pass': return 'BLOCK',['simulation_failed_or_missing']
    allowed=set(policy.get('programs',{}).get('allow',[])); programs=set(tx.get('programs',[])); unknown=set(tx.get('unknown_programs',[])) or (programs-allowed)
    if unknown and policy.get('programs',{}).get('deny_unknown'): reasons.append('unknown_program_call')
    blocked=set(policy.get('blocked_actions',[]))
    for a in tx.get('actions',[]):
        if a in blocked: reasons.append(a)
    if tx.get('authority_changes'): reasons.append('change_authority')
    if tx.get('sol_spend',0) > policy.get('limits',{}).get('max_single_tx_sol',float('inf')): reasons.append('max_single_tx_sol_exceeded')
    if tx.get('balance_percent',0) > policy.get('limits',{}).get('max_balance_percent_per_tx',100): reasons.append('max_balance_percent_per_tx_exceeded')
    if reasons: return 'BLOCK', sorted(set(reasons))
    approval=policy.get('approval_required',{})
    if tx.get('new_recipient') and tx.get('sol_spend',0) > approval.get('new_recipient_above_sol',float('inf')): return 'APPROVE_REQUIRED',['new_recipient_above_sol']
    if tx.get('sol_spend',0) > approval.get('amount_over_sol',float('inf')): return 'APPROVE_REQUIRED',['amount_over_sol']
    if fixture.get('simulation',{}).get('warnings') and approval.get('simulation_warnings'): return 'APPROVE_REQUIRED',['simulation_warnings']
    return 'ALLOW',['within_policy']

if len(sys.argv)!=3:
    print('usage: review_fixture.py FIXTURE_JSON POLICY_JSON', file=sys.stderr); sys.exit(2)
fixture=json.loads(Path(sys.argv[1]).read_text()); policy=json.loads(Path(sys.argv[2]).read_text())
decision,reasons=review(fixture,policy)
print(json.dumps({'decision':decision,'reasons':reasons,'expected':fixture.get('expected_decision')},indent=2))
sys.exit(0 if decision==fixture.get('expected_decision') else 1)
