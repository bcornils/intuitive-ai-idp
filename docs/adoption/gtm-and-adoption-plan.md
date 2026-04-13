# GTM & Adoption Plan

**Version:** Q1 2026 | **Owner:** Principal PM

---

## GTM philosophy

Internal platform GTM applies the same muscles as market products.
Teams switch when the platform removes more friction than it introduces,
and when they see peers succeeding. Strategy: **start narrow, demonstrate
wins visibly, expand from credibility.**

---

## Phase 1: Pilot (Weeks 1–6)

**Target:** 2 anchor teams (1 migration, 1 DC ops)
**Goal:** Reference customers with documented before/after metrics

### Pilot selection criteria
- Active pain (provisioning queue >5 tickets/week currently)
- Technical readiness (Terraform familiarity)
- Leadership visibility (wins will be noticed by peers)
- Reasonable risk profile (not in a freeze or critical migration)

### Pilot onboarding sequence
| Day/Week | Action |
|---|---|
| Day 1 | Kickoff: platform walkthrough, agree success metric |
| Week 1 | First VM provisioned end-to-end |
| Week 2 | Platform integrated into team's existing workflow |
| Week 4 | Retrospective: structured feedback, NPS pulse |
| Week 6 | Case study drafted: time-to-provision delta, quote captured |

---

## Phase 2: Broad rollout (Weeks 7–10)

**Gate:** Agent 3 security sign-off complete. Pilot case studies available.

| Wave | Teams | Week | Reason |
|---|---|---|---|
| Pilot | 2 anchor teams | Wk 1–6 | Reference customers |
| Wave 1 | 3 DC ops teams | Wk 7–8 | Highest volume, fastest ROI |
| Wave 2 | 2 migration teams | Wk 9 | Need migration dependency tooling |
| Wave 3 | 2 data/AI teams | Wk 10 | Need OpenLineage instrumentation |

---

## Phase 3: Steady-state (Weeks 11–13+)

- Monthly platform health reports to each team lead
- QBRs with structured agenda
- In-product usage analytics surfaced to team leads
- Feedback loop: support tickets → Agent 1 corpus → next quarter priorities

---

## Adoption risk register

| Risk | Signal | Response |
|---|---|---|
| Team not using platform after access | Zero provisions after 2 weeks | PM check-in, unblock session |
| Team reverting to legacy workflow | Ticket volume not declining | Root cause interview |
| NPS below 20 | Score or verbatim feedback | Escalate to PM + Eng lead same week |
| Onboarding stalling at RBAC | "Can't access X" tickets | Dedicated RBAC support slot |

---

## Competitive positioning per segment (Agent 4 copy)

**Migration teams:**
"Unlike manual migration planning, Intuitive.ai gives you a dependency-aware
provisioning engine that maps what depends on what before you move anything —
so migrations ship on schedule, not six months late."

**DC Ops teams:**
"Unlike ticket-driven provisioning, Intuitive.ai delivers self-service VM
provisioning in under 4 hours, with CMDB accuracy maintained automatically
as a side-effect of every provisioning action."

**Data/AI teams:**
"Unlike platforms that stop at provisioning, Intuitive.ai's OpenLineage-
instrumented stack traces from infrastructure event to pipeline impact —
so you know in 15 minutes whether a failed Spark job is code or infra."
