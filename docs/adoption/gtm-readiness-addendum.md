# GTM Readiness Assessment — Pre-Launch Risk Review

> **Added:** April 2026 — identified during assessment research phase via direct
> review of intuitive.ai. Included here because GTM readiness is not only about
> messaging and rollout sequencing — it includes the trust signals a prospective
> customer encounters before any sales conversation begins.

---

## Finding 1 — AI-Generated Imagery with Visible Artifacts

**Severity:** High  
**Type:** Brand credibility risk  
**Location:** intuitive.ai hero and feature sections

The current website uses AI-generated imagery that includes visible generation
artifacts — most notably malformed hands, a widely recognised signal of
AI-generated content to even casual observers.

**Why this matters for this specific product:**

Intuitive.ai's buyers are enterprise infrastructure and operations teams. These
are detail-oriented, skeptical audiences who make platform decisions worth
millions of dollars and years of operational dependency. The website is the
first trust signal in every sales motion, every recruitement conversation, and
every analyst briefing.

AI imagery artifacts communicate — unintentionally — that the team does not
sweat the details. For a platform whose entire value proposition is reliable,
precise infrastructure automation, that is a brand-positioning contradiction at
the top of the funnel.

This is not an aesthetic preference. It is a conversion risk.

**Recommendation:**

Replace AI-generated hero imagery before any outbound GTM motion begins.
Options in order of preference:

1. **Real customer environment photography** — racks, ops centers, team
   working shots. Authentic, differentiating, and impossible for SaaS-first
   competitors to replicate.
2. **Clean abstract data visualization** — network graphs, telemetry
   dashboards, infrastructure topology diagrams. On-brand for a data platform
   and avoids the uncanny valley entirely.
3. **High-quality licensed photography** (Getty, Unsplash Pro) — fast and
   low-cost stopgap while option 1 is arranged.

**Timeline:** P0 — before any paid media, analyst outreach, or conference
presence. Cost: low. Risk of not fixing: compounding first-impression damage
across every GTM channel simultaneously.

---

## Finding 2 — SSL Certificate Anomaly on Primary Domain

**Severity:** Critical  
**Type:** Platform trust and funnel integrity risk  
**Location:** intuitive.ai (primary domain)

The intuitive.ai domain is returning access errors consistent with an SSL
certificate misconfiguration or anomaly. Browser security warnings on a
primary domain create immediate, automatic friction at the top of every
funnel — sales, recruitment, press, and investor.

**Impact surface:**

| Funnel entry point | Impact |
|-------------------|--------|
| Prospective customer clicks a sales email link | Browser warning before they see a single word of positioning |
| Analyst or journalist researches the company | Security flag triggers skepticism about platform maturity |
| Candidate evaluates the company before interviewing | Trust signal failure before the first conversation |
| Investor or partner does basic due diligence | Compliance and operational rigor questioned immediately |

**Recommendation:**

This is a P0 infrastructure fix, not a product decision. Assign to platform
or DevOps immediately. Resolution is typically same-day once prioritised.

Validate fix with: `curl -vI https://intuitive.ai` and confirm clean TLS
handshake and valid certificate chain before any GTM activity resumes.

**Note for PM:** The SSL issue on the primary domain is also a signal worth
surfacing internally as a process question — if the marketing domain has a
certificate gap, what is the certificate rotation and monitoring posture for
the platform itself? Worth raising in the Week 2 architecture discovery
session as an ops hygiene data point, not as a criticism.

---

## GTM Readiness Gate — Recommended Checklist

Before the Week 9 GTM push in the Q1 roadmap, confirm:

- [ ] SSL certificate valid and monitored on all customer-facing domains
- [ ] AI-generated imagery replaced on primary website
- [ ] Website loads cleanly across Chrome, Safari, Firefox, and Edge
- [ ] Primary CTA (demo request / contact) tested end-to-end
- [ ] Core messaging reviewed against competitive positioning (portal vs.
      orchestration engine framing)
- [ ] Case study or reference customer narrative available for sales enablement
- [ ] Analytics (GA4 or equivalent) confirmed firing on all key pages

None of these are product features. All of them gate GTM effectiveness.
A platform that ships reliably but presents poorly loses deals before
engineering ever gets to demonstrate the product.
