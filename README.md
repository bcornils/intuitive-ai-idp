# Intuitive.ai — Infrastructure Platform · Q1 Principal PM Plan

> **Role:** Principal Product Manager, Enterprise Infrastructure Platform
> **Quarter:** Q1 (13 weeks)
> **Scope:** 5 engineering squads · 9 consumer teams · hybrid DC + cloud environments

---

## How to navigate this repo

| Path | What's there |
|---|---|
| `docs/strategy/` | Product vision, competitive positioning, architecture bets |
| `docs/metrics/` | KPI framework, consumer success metrics, DORA targets |
| `docs/adoption/` | GTM plan, onboarding playbooks, consumer segmentation |
| `docs/lineage/` | Data lineage + telemetry architecture decisions |
| `automation/` | Working AI PM automation — feedback synthesiser + backlog ranker |
| `ISSUES.md` | Full GitHub Issues backlog — import guide below |
| `AI_INTERACTION_LOG.md` | Complete AI collaboration log |

---

## The one-sentence strategy

**Own the datacenter provisioning execution layer** — be the orchestration engine
that any portal (Backstage, Port, custom) calls, not a portal competing with them.
Moat = VMware/OpenStack lifecycle depth + AI agent provisioning +
lineage-instrumented telemetry that SaaS-first competitors cannot replicate.

---

## Q1 shape at a glance

```
Weeks 1–3   │ Foundation & discovery
             │ Consumer interviews · CMDB baseline · metrics ratified · Agent 1 live

Weeks 4–8   │ Core platform delivery
             │ Self-service provisioning portal v1 · data platform schema freeze
             │ + OpenLineage · AI provisioning agent MVP · security baseline

Weeks 9–13  │ GTM + close
             │ GA launch to all 9 consumer teams · first QBR cycle
             │ Agent 4 generating per-team launch assets · Q2 plan drafted
```

**End-of-Q1 success bar:** ≥7/9 consumer teams actively provisioning ·
time-to-provision <4h · all 4 PM agents operational.

---

## GitHub Issues — import guide

```bash
# Install GitHub CLI: https://cli.github.com
gh auth login
chmod +x scripts/create_issues.sh
./scripts/create_issues.sh YOUR_ORG/YOUR_REPO
```

---

## AI automation — quick start

```bash
cd automation
pip install -r requirements.txt
export ANTHROPIC_API_KEY=your_key_here
python pm-agent.py --demo
```

Full setup in `automation/README.md`.

---

## Key architectural bets

1. **Lineage-instrumented provisioning** — every Terraform apply emits an
   OpenLineage event. CMDB updated as side-effect, not a manual step.
2. **Risk-proportional CI/CD gates** — smarter gates, not fewer gates.
3. **Orchestration engine, not portal** — Backstage/Port call our APIs.

---

## AI collaboration

Full interaction log in `AI_INTERACTION_LOG.md` — every prompt, decision to
accept or reject AI output, and what was retained as PM judgment.
