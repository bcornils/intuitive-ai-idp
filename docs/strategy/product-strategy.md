# Product Strategy — Intuitive.ai Infrastructure Platform

**Version:** Q1 2026 | **Owner:** Principal PM | **Status:** Active

---

## 1. Problem statement

Enterprise datacenter teams managing hybrid VMware/OpenStack/AWS environments
face three compounding problems:

- **Provisioning toil** — VM and container lifecycle is manual, ticket-driven,
  measured in days not hours. No self-service.
- **CMDB drift** — configuration data is inaccurate within hours of any change.
  AI features built on bad CMDB data make autonomous bad decisions.
- **Migration paralysis** — teams need to move from legacy virtualisation to
  cloud-native but have no structured platform path or dependency visibility.

---

## 2. Vision

**A provisioning execution engine that any team — and any portal — can call.**

We are not building another Internal Developer Portal. Backstage holds ~89%
IDP market share; competing there is a losing bet. We build the layer underneath:
the API-first orchestration engine that converts intent into provisioned,
tracked, CMDB-accurate infrastructure across VMware, OpenStack, and AWS.

---

## 3. Competitive positioning

| Competitor | Their strength | Why we win |
|---|---|---|
| Backstage / Roadie | Portal standard, 89% share, CNCF | We own DC lifecycle they ignore |
| ServiceNow ITOM | AIOps leader, IDC 2026 #1 | They win on ITSM; we win on provisioning depth |
| Port / Humanitec | No-code portal + orchestrator | No VMware/OpenStack DC expertise |
| Harness IDP | All-in-one CI/CD + IDP | AI in pipelines, not infra lifecycle |
| AWS DevOps Agent | Mature agentic remediation | AWS-only; we operate hybrid + on-prem |

---

## 4. Strategic architecture bets

**Bet 1: Orchestration engine, not portal**
Be the Humanitec of the datacenter. Provide provisioning APIs. Let any portal
be the UI. Preserves Backstage ecosystem investment while giving us the
defensible execution layer.

**Bet 2: Lineage-instrumented provisioning**
Every Terraform apply emits an OpenLineage event. CMDB accuracy becomes a
pipeline property, not a data quality project. Collapses the two-step problem
(provision then manually update CMDB) that drives most DC operational toil.

**Bet 3: Risk-proportional CI/CD gates**
AI-native CI/CD does not remove quality gates — it makes them intelligent.
Low-risk changes get fast-path. High-risk changes get dynamic stricter gates.
Consumer confidence maintained because signal is less noisy, not because
the gate is gone.

**Bet 4: OpenTelemetry as telemetry standard**
OTel is non-negotiable for 2026 platform engineering. All platform services
instrument via OTel. Unified telemetry store (Parquet/Iceberg-backed).

---

## 5. What we are NOT building this quarter

- A Backstage-competitive portal UI
- A general-purpose CI/CD platform
- A data governance product for non-infra data
- Any AI feature that requires CMDB accuracy below 80% to function safely

---

## 6. Q1 priorities

| Priority | Feature | Gate |
|---|---|---|
| 1 | Self-service provisioning portal v1 | RBAC policy engine complete |
| 2 | Data platform schema freeze + OpenLineage | Architecture sign-off |
| 3 | AI provisioning agent MVP | Schema freeze done |
| 4 | Security baseline (OIDC/SSO + SOC2 logging) | Agent 3 sign-off |
| 5 | Adoption dashboard + QBR framework | GA launch |

---

## 7. Roadmap horizon

**Q1:** Foundation + provisioning — portal, schema, AI agent pilot, security
**Q2:** AI operations + migration tooling — anomaly detection, dependency mapper
**Q3:** Scale + ecosystem — Backstage plugin, multi-DC, self-healing infra

---

## 8. Risks

| Risk | Mitigation |
|---|---|
| CMDB accuracy doesn't reach 85% | Lineage instrumentation makes it a pipeline property |
| Consumer adoption slower than forecast | Phased rollout with 2 pilot teams first |
| GitHub reliability dependency | Self-hosted runners for production DC pipelines |
| Squad capacity conflict | Agent 2 surfaces dependency conflicts weekly |
