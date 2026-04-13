#!/usr/bin/env bash
# create_issues.sh — Bulk create GitHub Issues
# Usage: ./scripts/create_issues.sh OWNER/REPO
# Requires: gh CLI authenticated

set -e
REPO=${1:-""}
if [ -z "$REPO" ]; then
  echo "Usage: $0 OWNER/REPO"
  exit 1
fi

echo "Creating issues in: $REPO"

echo "[1/3] Creating labels..."
declare -A LABELS=(
  ["epic"]="0052cc" ["story"]="0075ca" ["agent-system"]="7057ff"
  ["platform-core"]="008672" ["data-lineage"]="e4e669" ["security"]="d93f0b"
  ["gtm"]="0e8a16" ["metrics"]="1d76db" ["consumer-success"]="f9d0c4"
  ["priority-high"]="b60205" ["priority-medium"]="fbca04"
)
for label in "${!LABELS[@]}"; do
  gh label create "$label" --color "${LABELS[$label]}" --repo "$REPO" 2>/dev/null || true
done
echo "  Labels ready"

echo "[2/3] Creating milestones..."
gh api repos/$REPO/milestones -f title="M1: Foundation" \
  -f description="Consumer discovery, baselines, Agent 1 live" 2>/dev/null || true
gh api repos/$REPO/milestones -f title="M2: Core Platform" \
  -f description="Provisioning portal, schema, security, AI agent" 2>/dev/null || true
gh api repos/$REPO/milestones -f title="M3: GTM & Close" \
  -f description="GA launch, QBR cycle, Q2 plan ratified" 2>/dev/null || true
echo "  Milestones ready"

echo "[3/3] Creating issues..."

gh issue create --repo "$REPO" --title "[EPIC 1] Consumer discovery & metrics foundation" \
  --body "All 9 teams interviewed. CMDB baseline. KPI framework ratified. 2 pilot teams active." \
  --label "epic,priority-high,consumer-success" --milestone "M1: Foundation"

gh issue create --repo "$REPO" --title "[STORY 1.1] Consumer interview programme — all 9 teams" \
  --body "45-min interviews with all 9 teams. Feed corpus to Agent 1.\n\n**AC:**\n- [ ] All 9 interviewed by Week 2\n- [ ] Notes in feedback corpus\n- [ ] Segment A/B/C identified per team\n- [ ] 2 pilot candidates identified" \
  --label "story,priority-high,consumer-success" --milestone "M1: Foundation"

gh issue create --repo "$REPO" --title "[STORY 1.2] CMDB accuracy baseline measurement" \
  --body "Measure CMDB accuracy vs. actual infra state.\n\n**AC:**\n- [ ] Reconciliation script written and run\n- [ ] Score per environment (VMware/OpenStack/AWS)\n- [ ] Escalation plan agreed if baseline <70%" \
  --label "story,priority-high,data-lineage" --milestone "M1: Foundation"

gh issue create --repo "$REPO" --title "[STORY 1.3] KPI framework ratified with leadership" \
  --body "Get sign-off on KPI framework and baselines.\n\n**AC:**\n- [ ] Framework approved\n- [ ] Baselines captured\n- [ ] Reporting cadence agreed" \
  --label "story,priority-high,metrics" --milestone "M1: Foundation"

gh issue create --repo "$REPO" --title "[STORY 1.4] Pilot team selection and kickoff" \
  --body "Select 2 pilot teams (1 migration, 1 DC ops).\n\n**AC:**\n- [ ] 2 teams confirmed by Week 3\n- [ ] Success metric agreed per team\n- [ ] First provision by Week 4" \
  --label "story,priority-high,consumer-success" --milestone "M1: Foundation"

gh issue create --repo "$REPO" --title "[EPIC 2] Agent system deployment — PM workflow automation" \
  --body "All 4 PM agents operational by Week 10: priority synth, arch assessor, security reviewer, marketing builder." \
  --label "epic,agent-system,priority-high" --milestone "M1: Foundation"

gh issue create --repo "$REPO" --title "[STORY 2.1] Agent 1: Priority signal synthesiser — deploy and run" \
  --body "Deploy pm-agent.py on real feedback corpus.\n\n**AC:**\n- [ ] Running on interview corpus\n- [ ] First ranked backlog in Week 3 planning\n- [ ] Conflict report generated\n\n**Depends on:** Story 1.1" \
  --label "story,agent-system,priority-high" --milestone "M1: Foundation"

gh issue create --repo "$REPO" --title "[STORY 2.2] Agent 2: Architecture order assessor" \
  --body "Connect to live lineage graph. Conflict analysis on Agent 1 output.\n\n**AC:**\n- [ ] Reordered backlog with dependency annotations\n- [ ] 1+ conflict escalated to PM\n\n**Depends on:** Story 2.1, Story 3.2" \
  --label "story,agent-system,priority-medium" --milestone "M2: Core Platform"

gh issue create --repo "$REPO" --title "[STORY 2.3] Agent 3: Security & accessibility reviewer" \
  --body "RBAC/OIDC/SOC2/WCAG review before GA launch.\n\n**AC:**\n- [ ] Security checklist complete\n- [ ] WCAG 2.2 AA for all UI surfaces\n- [ ] Go/no-go per feature before Week 9\n\n**Depends on:** Story 2.2" \
  --label "story,agent-system,security,priority-medium" --milestone "M2: Core Platform"

gh issue create --repo "$REPO" --title "[STORY 2.4] Agent 4: Marketing builder — GA asset generation" \
  --body "Per-team onboarding assets for GA launch.\n\n**AC:**\n- [ ] Release note per team\n- [ ] Onboarding playbook per segment\n- [ ] Announcement copy ready\n\n**Depends on:** Story 2.3" \
  --label "story,agent-system,gtm,priority-medium" --milestone "M2: Core Platform"

gh issue create --repo "$REPO" --title "[EPIC 3] Core platform delivery — portal + data foundation" \
  --body "Self-service provisioning, schema freeze + lineage, AI agent MVP, security baseline." \
  --label "epic,platform-core,priority-high" --milestone "M2: Core Platform"

gh issue create --repo "$REPO" --title "[STORY 3.1] Self-service provisioning portal v1" \
  --body "VM + container lifecycle. RBAC-gated. Terraform/Ansible backend.\n\n**AC:**\n- [ ] Provision VM in <15 min\n- [ ] RBAC enforced\n- [ ] Audit log on every action\n\n**Depends on:** Story 3.4" \
  --label "story,platform-core,priority-high" --milestone "M2: Core Platform"

gh issue create --repo "$REPO" --title "[STORY 3.2] Data platform schema freeze + OpenLineage" \
  --body "Freeze schemas. OpenLineage on provisioning. OpenMetadata deployed.\n\n**AC:**\n- [ ] Lineage events on every Terraform apply\n- [ ] CMDB auto-reconciliation running\n- [ ] Schema locked\n- [ ] CMDB accuracy SLO live in Grafana\n\n**Depends on:** Story 1.2" \
  --label "story,data-lineage,platform-core,priority-high" --milestone "M2: Core Platform"

gh issue create --repo "$REPO" --title "[STORY 3.3] AI provisioning agent MVP — pilot 2 teams" \
  --body "NL request -> Terraform plan -> approve -> execute. Audit trail.\n\n**AC:**\n- [ ] 5+ agent provisions by pilot teams\n- [ ] Rollback tested\n\n**Depends on:** Story 3.2, Story 3.4" \
  --label "story,platform-core,agent-system,priority-high" --milestone "M2: Core Platform"

gh issue create --repo "$REPO" --title "[STORY 3.4] RBAC policy engine — required before self-service" \
  --body "4 roles + OIDC/SSO. Required before broad rollout.\n\n**AC:**\n- [ ] Roles defined\n- [ ] OIDC complete\n- [ ] Violations blocked and logged\n- [ ] Agent 3 sign-off" \
  --label "story,security,platform-core,priority-high" --milestone "M2: Core Platform"

gh issue create --repo "$REPO" --title "[EPIC 4] GTM & adoption — GA launch + QBR cycle" \
  --body "3-wave rollout to all 9 teams. First QBR cycle. Adoption dashboard live." \
  --label "epic,gtm,priority-high" --milestone "M3: GTM & Close"

gh issue create --repo "$REPO" --title "[STORY 4.1] Wave 1 rollout — 3 DC ops teams (Week 7-8)" \
  --body "**AC:**\n- [ ] Onboarding complete\n- [ ] 3+ provisions per team\n- [ ] NPS pulse at 2 weeks" \
  --label "story,gtm,consumer-success,priority-high" --milestone "M3: GTM & Close"

gh issue create --repo "$REPO" --title "[STORY 4.2] Wave 2 rollout — migration + data/AI teams (Week 9-10)" \
  --body "**AC:**\n- [ ] All 4 teams onboarded\n- [ ] Dependency map for 1+ migration\n- [ ] Lineage view demonstrated\n\n**Depends on:** Story 3.2, Story 4.1" \
  --label "story,gtm,consumer-success,priority-high" --milestone "M3: GTM & Close"

gh issue create --repo "$REPO" --title "[STORY 4.3] Adoption dashboard — real-time metrics for leadership" \
  --body "**AC:**\n- [ ] Live metrics dashboard\n- [ ] Weekly summary email\n- [ ] Used in Week 12 QBR" \
  --label "story,metrics,gtm,priority-high" --milestone "M3: GTM & Close"

gh issue create --repo "$REPO" --title "[STORY 4.4] First QBR cycle — all active consumer teams" \
  --body "**AC:**\n- [ ] QBRs with >=7 teams by Week 13\n- [ ] Outcome vs. baseline documented\n- [ ] Q2 use cases captured\n- [ ] Notes fed to Agent 1 corpus" \
  --label "story,consumer-success,priority-high" --milestone "M3: GTM & Close"

gh issue create --repo "$REPO" --title "[STORY 5.1] Q2 roadmap draft — Agent 1+2 on QBR corpus" \
  --body "Run agents on QBR corpus. Ratify Q2 plan by Week 13.\n\n**AC:**\n- [ ] Ranked Q2 backlog produced\n- [ ] Conflicts reviewed\n- [ ] Plan ratified before Week 13 close" \
  --label "story,priority-medium" --milestone "M3: GTM & Close"

echo "  Issues created"
echo ""
echo "Done! View at: https://github.com/$REPO/issues"
