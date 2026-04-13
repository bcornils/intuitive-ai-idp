# Data Lineage & Telemetry Architecture — Decision Record

**Version:** Q1 2026 | **Status:** Proposed — requires arch squad sign-off Week 2

---

## Context

The Q1 roadmap originally defined CMDB accuracy (≥85%) as a binary gate before
AI features could ship. Research review identified a critical gap: without data
lineage instrumentation, hitting 85% is a one-time measurement, not a sustainable
state. Every manual change after measurement reintroduces drift immediately.

---

## Decision

**Provision-time lineage emission:** Every infrastructure provisioning action
(Terraform apply, Ansible playbook run, container deployment) emits an
OpenLineage event. CMDB updates are derived automatically from these events.

Before: Provision resource → manually update CMDB (often skipped, always delayed)
After:  Provision resource → lineage event → CMDB auto-reconciled as side-effect

---

## Architecture

```
Provisioning Agent (AI or human request)
    │
    ▼
Terraform / Ansible / K8s API
    │
    ├──► Infrastructure resource created/modified
    │
    └──► OpenLineage event emitted
              │
              ▼
         OpenMetadata (lineage store + catalog)
              │
              ├──► CMDB sync (automated reconciliation)
              ├──► Telemetry graph update
              └──► Data platform (Parquet/Iceberg lakehouse)
                        │
                        ▼
                   AI features + Observability dashboards
```

---

## Technology choices

| Layer | Technology | Rationale |
|---|---|---|
| Lineage standard | OpenLineage | CNCF-backed, tool-neutral, Airflow/dbt/Spark native |
| Metadata store | OpenMetadata | Open-source, API-first, pairs with OpenLineage |
| Telemetry | OpenTelemetry | Non-negotiable 2026 standard |
| Telemetry store | ClickHouse / Parquet+Iceberg | High-performance columnar, ad-hoc queries |
| Visualisation | Grafana | OTel-native, widely understood by ops teams |

---

## Implementation plan (Weeks 4–6, within schema sprint)

**Week 4:** OpenLineage integrated into Terraform wrapper · OpenMetadata deployed
**Week 5:** Lineage event schema agreed · CMDB reconciliation job built
**Week 6:** Schema freeze locked · Agent 2 updated to read live lineage graph
            · Grafana: CMDB accuracy as live SLO (not one-time audit)

---

## Impact on AI features

AI anomaly detection requires:
1. Stable telemetry schema ✓ (Week 6)
2. Historical baseline (4 weeks of data) → available Week 10
3. Lineage graph for causal tracing ✓ (Week 6)

AI anomaly detection can potentially ship Week 10–11 of Q1
(accelerated from Q2 if lineage lands on schedule).

---

## Key research finding

Industry consensus: organisations implementing AI first, then unifying
observability/lineage later, consistently fail. Correct sequence:
lineage → unified telemetry → AI features.

This validates the architecture gate in Agent 2.
