# AI Interaction Log — Intuitive.ai IDP Q1 PM Assessment

> **First-class deliverable.** This log captures the complete AI collaboration
> used to produce this repository — prompts, responses, research citations,
> iteration decisions, and deployment troubleshooting. Reviewed alongside the
> repo artifacts, not separately.

**Tool:** Claude (Anthropic) — claude.ai  
**Model:** Claude Sonnet (claude.ai web interface)  
**Total sessions:** 2 accounts, 1 continuous working session  
**Date:** April 12, 2026  
**Note on two accounts:** Session hit claude.ai usage limits mid-way through
deployment work. Continued on a second account to complete the repo setup.
This reflects genuine 4-hour depth of engagement with the tool, not a
workaround — pushing AI collaboration hard enough to hit limits is part of
the story.

---

## Session 1 — Strategy, Competitive Analysis, Roadmap, Research Challenge

### Prompt 1 — Initial brief (10:00 AM)

**User:**
> Think like a Principal Product Manager, create a roadmap for Intuitive.ai.
> Please take into consideration the tech in the job description to help me
> create a set of agents to understand priority based on user feedback, an
> architect agent to assess if there is a best practice order, understanding
> this might be in conflict with the user feedback. an agent to assess security
> and accessibility as a review after the architecture review. an agent to
> create a marketing campaign based on the feature order. Please do a
> comparison of competitors as a first pass before creating agents, while
> Intuitive.ai is looking for their edge, they also need to make trade offs
> based on how the industry is shifting in an AI first world. here is the full
> job description and assignment.

**Claude response summary:**
Claude ran two web searches to ground the competitive analysis in current
market data before producing any artifacts. Key findings surfaced:

- Backstage holds ~89% market share among IDP adopters but is a commoditised
  portal layer
- Gartner flagged AI agents reshaping Infrastructure & Operations
- ServiceNow agentic AI enabling self-healing infrastructure by 2026
- Deployment platforms (Northflank framing) go beyond portals by running
  workloads — the key differentiator framing for Intuitive.ai

Claude then produced a four-tab interactive artifact:
1. **Competitive landscape** — Backstage, Port, Cortex, Humanitec, ServiceNow
   positioned against Intuitive.ai's VMware/OpenStack datacenter depth
2. **Four-agent PM system** — Priority Agent → Architecture Agent → Security &
   Accessibility Agent → Marketing Agent, with deliberate sequencing rationale
3. **Q1 Roadmap** — three phases: Weeks 1–3 (feedback corpus + Agent 1),
   Weeks 4–8 (provisioning portal + data platform foundation), Weeks 9–13
   (GTM push + QBR cycle)
4. **Trade-offs** — honest PM story: consumers vote for AI anomaly detection
   first; shipping AI on unstable telemetry schema destroys trust faster than
   shipping nothing

**Strategic bet surfaced by Claude:**
> "Intuitive.ai should not compete on the portal layer where Backstage has
> already won. The winning position is the orchestration execution engine —
> be the layer any portal calls, own the datacenter provisioning API, and let
> Backstage/Port be consumers of your platform rather than competitors to it."

---

### Prompt 2 — Research challenge on data lineage and CI/CD (10:12 AM)

**User:**
> What's the industries take on understanding not only the dependency graph but
> the data lineage of how information flows through, using this as insights to
> improve the IDP orchestration execution engine. I worry that without an
> understanding on the connective tissue. Further CI/CD is likely changing in
> an AI world however without those gates users start to lose customer
> confidence, unless we see the current trend of reduced reliability (I think
> GitHub is at 91% uptime atm) deprioritizes it as a top tier priority.
> Further leveraging data lineage must certainly tighten the telemetry story,
> unless I'm missing something. Please act as a Product researcher to assess
> if the above assumptions are incorrect. If correct does this change any of
> the above roadmap assumptions.

**Why this prompt matters:**
This was a deliberate hypothesis-testing prompt — not asking Claude to validate
assumptions, but to challenge them. The PM instinct here was to pressure-test
the roadmap before committing to the artifact structure.

**Claude response summary:**
Claude ran two additional web searches and returned a structured research
verdict across three hypotheses:

**Hypothesis 1 — Data lineage as connective tissue:**
Verdict: Correct, and the roadmap was missing this dimension.
- Dependency graph = structural what. Data lineage = how information flows and
  transforms. Without lineage, the orchestration engine sequences deployments
  correctly but cannot reason about whether the data feeding each stage is
  trustworthy.
- Key insight: an agent acting on stale or corrupted CMDB data doesn't make a
  bad recommendation — it makes an autonomous bad action.
- Roadmap impact: OpenLineage instrumentation must be bundled into the data
  platform schema freeze sprint (Weeks 4–6), not treated as a separate
  workstream.

**Hypothesis 2 — GitHub reliability deprioritizing CI/CD gates:**
Verdict: Directionally correct on the reliability crisis, but the implication
is the opposite of what was suggested.
- GitHub logged 37 incidents in February 2026; third-party tracking puts uptime
  at 90.21% over 90 days — one nine, not three.
- Industry response to unreliability is NOT to remove gates — it is to make
  gates risk-proportional. Low-risk changes get fast-path approval; high-risk
  changes get tighter scrutiny.
- Roadmap impact: Agent 3 (Security & Accessibility) review should explicitly
  include CI/CD substrate risk assessment — which pipelines are
  GitHub-dependent and what the failover plan is.

**Hypothesis 3 — Lineage tightening the telemetry story:**
Verdict: Yes, unambiguously. The provisioning event itself (VM created via
Terraform) should automatically emit a lineage event that registers the new
resource in the telemetry graph. This collapses the two-step problem (provision
first, update CMDB second) into a single atomic operation.

**Three roadmap changes warranted:**
1. Add OpenLineage instrumentation to Weeks 4–6 data platform sprint
2. Map GitHub Actions dependencies in Week 2 discovery; recommend self-hosted
   runners for production DC pipelines
3. Reframe CMDB accuracy gate from one-time 85% threshold to a continuous SLO
   maintained by lineage-instrumented pipelines

**One confirmation:**
Architecture sequencing (data platform before AI features) is more correct than
originally conveyed. Framing to stakeholders: "we're building the data
foundation that makes AI agents trustworthy rather than dangerous."

---

### Prompt 3 — Deliverables and GitHub repo (10:25 AM)

**User:**
> great, i need the deliverables. and an easy way to add them to my GitHub
> repo. can you help with that.

**Claude response summary:**
Claude generated all 12 repo files programmatically using bash tools:

| File | Purpose |
|------|---------|
| README.md | Repo entry point — navigation guide, strategy one-liner |
| ISSUES.md | Full backlog: 5 epics, 19 stories, milestones, dependency map |
| AI_INTERACTION_LOG.md | AI collaboration record (placeholder — replaced by this file) |
| docs/strategy/product-strategy.md | Vision, positioning, bets, risks |
| docs/metrics/consumer-segmentation-and-metrics.md | 3 segments, KPIs, DORA targets |
| docs/adoption/gtm-and-adoption-plan.md | 3-phase rollout, risk register |
| docs/lineage/data-lineage-adr.md | Architecture decision record for OpenLineage |
| automation/pm-agent.py | Working CLI — ingests feedback, calls Claude API, outputs ranked backlog |
| automation/README.md | Setup instructions, usage, cost estimate |
| automation/sample_feedback.json | 5 feedback items to demo the tool |
| automation/requirements.txt | anthropic>=0.40.0 |
| scripts/create_issues.sh | Bulk-creates GitHub Issues via gh CLI |

Claude then added `.github/` folder with issue templates and PR template —
specifically noting the PR template bakes the lineage ADR into every engineer's
checklist, propagating the architectural decision without PM reminders.

10 meaningful commits were structured to show reviewers a coherent PM process:
init → strategy → metrics → ADR → GTM → backlog → automation → tooling →
ai-log → github-templates.

---

## Session 2 — Deployment Troubleshooting (8:30 PM, second account)

Session continued on a second Claude account after hitting usage limits.
This session covered the full deployment sequence from zip delivery failure
to live repo.

### Issue 1 — Zip file not downloadable from claude.ai

Claude.ai delivers generated files as browser-viewable artifacts, not direct
downloads. The zip could not be located or unzipped from the Desktop.

**Resolution:** Claude generated a self-contained `setup.sh` bash script that
recreated all files, made all 10 commits, created the GitHub repo, pushed, and
bulk-created Issues in a single command.

### Issue 2 — Wrong GitHub username in script argument

Script was run with `bethfuller` (local machine username) instead of `bcornils`
(GitHub username).

**Resolution:** Reran with correct argument: `bash ~/Downloads/setup.sh bcornils`

### Issue 3 — Repo name already exists on GitHub account

`createRepository` GraphQL error because repo had been created manually earlier.

**Resolution:** Deleted existing empty repo via GitHub UI, reran script cleanly.

### Issue 4 — Git push failed after repo creation

Repo created successfully but push step failed with "Repository not found."

**Resolution:** Manual push: `cd ~/intuitive-ai-idp && git push -u origin main`

### Issue 5 — create_issues.sh failing on bash 3 (macOS default)

Script used `declare -A` associative arrays requiring bash 4+. macOS ships
with bash 3.2.

**Resolution:** Homebrew bash 5.3.9 already installed at
`/opt/homebrew/Cellar/bash/5.3.9/bin/bash`. Ran script with explicit path:
`/opt/homebrew/Cellar/bash/5.3.9/bin/bash scripts/create_issues.sh bcornils/intuitive-ai-idp`

### Issue 6 — AI_INTERACTION_LOG.md was a placeholder

The auto-generated log was not the real conversation. The actual chat was
retrieved via a shared link and used to produce this file.

---

## Key PM decisions made with AI assistance

| Decision | How AI shaped it |
|----------|-----------------|
| Orchestration engine positioning | Claude's competitive research surfaced the portal vs. execution engine distinction — not in the original brief |
| Agent sequencing (security after architecture) | Claude made explicit why reviewing security against an unstable feature sequence creates noise |
| Data lineage as Q1 requirement | Claude's research challenge revealed the roadmap gap; ADR added as direct result |
| CMDB gate redefined as continuous SLO | Emerged from lineage research — not in original roadmap thinking |
| CI/CD risk-proportional gating | Claude corrected the hypothesis that reliability concerns deprioritize gates |
| Self-hosted runners recommendation | Claude identified GitHub dependency as architectural risk given 90.21% uptime data |

---

## What this log demonstrates

The assessors asked for the AI interaction log as a first-class deliverable
because they want to see *how* AI was used, not just what it produced.

This session shows:
- **Hypothesis-testing over validation-seeking** — prompts were designed to
  challenge assumptions, not confirm them
- **Research-grounded decisions** — every roadmap change was backed by cited
  sources, not AI opinion
- **Iterative refinement** — the roadmap changed three times based on research
  findings before any artifact was committed
- **Full-stack AI use** — strategy, research, artifact generation, scripting,
  deployment debugging, and log authoring all used AI assistance
- **Transparency about limitations** — two accounts, placeholder log replaced,
  deployment issues documented honestly
