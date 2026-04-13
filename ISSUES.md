# GitHub Issues Backlog

> Import using `scripts/create_issues.sh` or create manually.

---

## Milestones

| Milestone | Due | Description |
|---|---|---|
| `M1: Foundation` | End Week 3 | Discovery, baselines, Agent 1 live |
| `M2: Core Platform` | End Week 8 | Portal, schema, security, AI agent pilot |
| `M3: GTM & Close` | End Week 13 | GA launch, QBR cycle, Q2 plan |

---

## EPIC 1 — Consumer discovery & metrics foundation
**Labels:** `epic` `priority-high` | **Milestone:** M1

### Story 1.1 — Consumer interview programme
**Labels:** `story` `consumer-success` `priority-high`
Conduct 45-min interviews with all 9 teams. Feed corpus to Agent 1.
**AC:** All 9 interviewed by Week 2 · segment identified · 2 pilot candidates found

### Story 1.2 — CMDB accuracy baseline
**Labels:** `story` `data-lineage` `priority-high`
Measure CMDB accuracy vs. actual infra state. Establish baseline.
**AC:** Reconciliation script run · score per environment · escalation plan if <70%

### Story 1.3 — KPI framework ratified
**Labels:** `story` `metrics` `priority-high`
Get engineering leadership sign-off on KPI framework and baselines.
**AC:** Framework approved · baselines captured · reporting cadence agreed

### Story 1.4 — Pilot team selection and kickoff
**Labels:** `story` `consumer-success` `priority-high`
Select 2 pilot teams. Kickoffs. Platform access provisioned.
**AC:** 2 teams confirmed by Week 3 · success metrics agreed · first provision by Week 4

---

## EPIC 2 — Agent system deployment
**Labels:** `epic` `agent-system` `priority-high` | **Milestone:** M1/M2

### Story 2.1 — Agent 1: Priority signal synthesiser
**Labels:** `story` `agent-system` `priority-high` | **Milestone:** M1
Deploy pm-agent.py on real feedback corpus. First ranked backlog output.
**AC:** Running on interview corpus · ranked backlog in Week 3 planning · conflicts flagged
**Depends on:** Story 1.1

### Story 2.2 — Agent 2: Architecture order assessor
**Labels:** `story` `agent-system` `priority-medium` | **Milestone:** M2
Connect to live lineage graph. Run conflict analysis on Agent 1 output.
**AC:** Reordered backlog with dependency annotations · 1+ conflict escalated to PM
**Depends on:** Story 2.1, Story 3.2

### Story 2.3 — Agent 3: Security & accessibility reviewer
**Labels:** `story` `agent-system` `security` `priority-medium` | **Milestone:** M2
Security + WCAG review against architecture-ordered backlog.
**AC:** RBAC/OIDC/SOC2/WCAG checklist complete · go/no-go per feature before Week 9
**Depends on:** Story 2.2

### Story 2.4 — Agent 4: Marketing builder
**Labels:** `story` `agent-system` `gtm` `priority-medium` | **Milestone:** M2
Generate per-team onboarding assets for GA launch.
**AC:** Release note per team · onboarding playbook per segment · announcement copy ready
**Depends on:** Story 2.3

---

## EPIC 3 — Core platform delivery
**Labels:** `epic` `platform-core` `priority-high` | **Milestone:** M2

### Story 3.1 — Self-service provisioning portal v1
**Labels:** `story` `platform-core` `priority-high`
VM + container lifecycle. RBAC-gated. Terraform/Ansible backend.
**AC:** Provision VM in <15 min · RBAC enforced · audit log on every action
**Depends on:** Story 3.4

### Story 3.2 — Data platform schema freeze + OpenLineage
**Labels:** `story` `data-lineage` `platform-core` `priority-high`
Freeze schemas. Instrument provisioning with OpenLineage. Deploy OpenMetadata.
**AC:** Lineage events on every Terraform apply · CMDB auto-reconciliation running · schema locked
**Depends on:** Story 1.2

### Story 3.3 — AI provisioning agent MVP
**Labels:** `story` `platform-core` `agent-system` `priority-high`
NL provisioning → Terraform plan → approve → execute. Full audit trail.
**AC:** 5+ agent provisions by pilot teams · rollback tested
**Depends on:** Story 3.2, Story 3.4

### Story 3.4 — RBAC policy engine
**Labels:** `story` `security` `platform-core` `priority-high`
Role model + OIDC/SSO. Required before any broad self-service rollout.
**AC:** 4 roles defined · OIDC complete · violations blocked + logged · Agent 3 sign-off

### Story 3.5 — SOC2 audit logging
**Labels:** `story` `security` `priority-medium`
Immutable audit log for all provisioning, agent, and RBAC actions.
**AC:** Who/what/when/outcome logged · agent reasoning trace captured · retention meets SOC2

---

## EPIC 4 — GTM & adoption
**Labels:** `epic` `gtm` `priority-high` | **Milestone:** M3

### Story 4.1 — Wave 1 rollout (3 DC ops teams, Week 7–8)
**AC:** Onboarding complete · 3+ provisions per team · NPS pulse at 2 weeks

### Story 4.2 — Wave 2 rollout (migration + data/AI teams, Week 9–10)
**AC:** All 4 teams onboarded · dependency map for 1+ migration · lineage view demonstrated
**Depends on:** Story 3.2, Story 4.1

### Story 4.3 — Adoption dashboard
**AC:** Live metrics for leadership · weekly summary email · used in Week 12 QBR

### Story 4.4 — First QBR cycle
**AC:** QBRs with ≥7 teams by Week 13 · outcome vs. baseline · Q2 use cases captured

---

## EPIC 5 — Q2 planning
**Labels:** `epic` `priority-medium` | **Milestone:** M3

### Story 5.1 — Q2 roadmap draft
Run Agent 1 + 2 on QBR corpus. Ratify Q2 plan with stakeholders by Week 13.

---

## Critical path

```
1.1 interviews ──► 2.1 Agent1 ──────────────────────────────────► 5.1 Q2 plan
1.2 CMDB baseline ──► 3.2 schema+lineage ──► 2.2 Agent2 ──► 2.3 Agent3 ──► 2.4 Agent4
                   └──► 3.4 RBAC ──► 3.1 portal ──► 4.1 Wave1 ──► 4.4 QBR
                                  └──► 3.3 AI agent
```
