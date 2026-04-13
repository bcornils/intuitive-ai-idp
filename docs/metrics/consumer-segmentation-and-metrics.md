# Consumer Segmentation & Success Metrics Framework

**Version:** Q1 2026 | **Owner:** Principal PM

---

## Consumer segments

### Segment A — Migration teams
**Pain:** No dependency map. Migration planning is manual. Risk of taking down
dependent services is unquantified.
**Success metric:** Migration planning cycle <2 weeks (from 4–6). Zero unplanned
dependency incidents per migration.
**Count:** ~3 of 9 teams in Q1 pool

### Segment B — DC Ops teams
**Pain:** Provisioning is ticket-based, 2–3 day SLA. CMDB unreliable.
Incident root cause requires manual correlation across 4+ tools.
**Success metric:** Time-to-provision <4h. CMDB accuracy ≥85% sustained.
MTTR for infra incidents reduced 30%.
**Count:** ~4 of 9 teams in Q1 pool

### Segment C — Data/AI platform teams
**Pain:** Infrastructure provisioning for data environments is opaque.
Pipeline failures hard to trace to infra root causes.
**Success metric:** Data infra provisioning <2h. Infra-originated pipeline
incidents identifiable within 15 min via lineage graph.
**Count:** ~2 of 9 teams in Q1 pool

---

## Platform-level KPIs

### Adoption metrics
| Metric | Q1 target | Method |
|---|---|---|
| Active consumer teams | ≥7 of 9 | Teams with ≥1 provision in last 30 days |
| Provisioning volume | Baseline + 50% MoM from Week 10 | Platform API logs |
| Self-service ratio | >60% via platform vs. manual ticket | Ticket system comparison |
| Onboarding completion | 100% of engaged teams | Onboarding tracker |

### Operational metrics
| Metric | Q1 target | Method |
|---|---|---|
| Time-to-provision | <4 hours (p50) | Request → resource available timestamp |
| CMDB accuracy | ≥85% sustained | Automated reconciliation vs. actual state |
| Platform availability | ≥99.5% | SLO dashboard (OTel + Grafana) |
| Incident MTTR | 30% reduction vs. Q0 baseline | Incident tracker |

### Quality & trust metrics
| Metric | Q1 target | Method |
|---|---|---|
| Consumer NPS | ≥40 | Quarterly survey + in-product pulse |
| Support ticket volume | <3 tickets/team/month by Week 12 | Jira/support tracker |
| Failed provision rate | <5% | Platform error logs |
| Rollback frequency | <2% of provisions | GitOps audit log |

---

## DORA metrics (platform delivery team)

| Metric | Target |
|---|---|
| Deployment frequency | Weekly per squad |
| Lead time for changes | <3 days |
| Change failure rate | <5% |
| MTTR | <4 hours |

---

## Consumer success checkpoints

**30-day:** Interview done · onboarding scheduled · 1 provision completed
**60-day:** Regular provisioning (>5 actions) · NPS pulse submitted
**90-day (QBR):** Outcome vs. baseline reviewed · Q2 use cases identified

---

## Agent 1 priority weighting model

| Factor | Weight | Description |
|---|---|---|
| Frequency | 25% | How many teams requested this |
| Consumer tier impact | 30% | Segment A weighted higher in Q1 |
| Strategic alignment | 25% | Advances orchestration engine bet? |
| Technical debt cost | 20% | Cost of NOT doing this |

Requests scoring high on frequency from only 1–2 teams are flagged:
loudest voice ≠ broadest pain.
