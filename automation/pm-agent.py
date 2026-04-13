#!/usr/bin/env python3
"""
pm-agent.py — Priority Signal Synthesiser
Intuitive.ai Infrastructure Platform · Q1 PM Automation

Ingests consumer feedback and uses Claude to rank features,
surface conflicts, and draft PRD stubs.

Usage:
    python pm-agent.py --demo
    python pm-agent.py --input feedback.json --output ranked_backlog.md
    python pm-agent.py --input tickets.csv --format csv --output report.md

Setup:
    pip install -r requirements.txt
    export ANTHROPIC_API_KEY=your_key_here
"""

import argparse
import json
import csv
import os
import sys
import datetime
from pathlib import Path

try:
    import anthropic
except ImportError:
    print("ERROR: anthropic package not found. Run: pip install anthropic")
    sys.exit(1)


SYNTHESIS_SYSTEM = """You are a senior Principal Product Manager at Intuitive.ai,
an enterprise infrastructure platform company.

The platform is an infrastructure provisioning orchestration engine serving
enterprise datacenter teams. Key consumer segments:
- Segment A (Migration teams): Moving workloads VMware to OpenStack/AWS
- Segment B (DC Ops teams): Day-to-day infrastructure operations
- Segment C (Data/AI platform teams): Building data pipelines on infrastructure

Core platform bets:
1. Orchestration engine not portal — be the layer any portal calls
2. Lineage-instrumented provisioning — CMDB accuracy as pipeline property
3. Risk-proportional CI/CD gates — smarter not fewer
4. OpenTelemetry as telemetry standard

Always surface:
- Where loudest voice does not equal broadest pain
- Technical blockers that make a high-priority request dangerous to ship early
- Conflicts between consumer priority and best-practice delivery sequence

Respond in structured JSON matching the schema requested."""


RANKING_PROMPT = """Analyse the following consumer feedback and produce a
ranked feature backlog.

Feedback corpus:
{feedback}

Produce a JSON response with this exact structure:
{{
  "summary": "2-3 sentence synthesis of dominant themes",
  "ranked_features": [
    {{
      "rank": 1,
      "feature": "feature name",
      "consumer_demand_score": 0,
      "strategic_alignment_score": 0,
      "technical_risk": "low|medium|high",
      "architectural_dependency": "none or describe",
      "recommended_quarter": "Q1|Q2|Q3",
      "rationale": "why this rank, conflicts flagged",
      "prd_stub": "2-3 sentence acceptance criteria draft",
      "consumer_segments": ["A", "B", "C"]
    }}
  ],
  "conflicts": [
    {{
      "conflict": "description of conflict",
      "consumer_wants": "what consumers asked for",
      "technical_reality": "why that sequence is risky",
      "recommended_resolution": "how PM should address this"
    }}
  ],
  "loudest_voice_flags": [
    {{
      "feature": "feature name",
      "requesting_teams": 1,
      "total_teams": 9,
      "flag": "high frequency from few teams"
    }}
  ],
  "q1_ship_order": ["feature1", "feature2", "feature3"],
  "metadata": {{
    "total_feedback_items": 0,
    "unique_requesting_teams": 0,
    "analysis_timestamp": ""
  }}
}}

Return only valid JSON. No markdown fences. No preamble."""


REPORT_PROMPT = """Convert this ranked backlog JSON into a readable markdown
report for engineering leadership. Include:
- Executive summary (3 sentences max)
- Top 5 ranked features with rationale
- Conflicts table
- Recommended Q1 ship order
- Key risks

Keep it tight — this is for a 10-minute leadership review.

JSON input:
{ranked_json}"""


SAMPLE_FEEDBACK = [
    {
        "source": "support_ticket",
        "team": "DC Ops Team Alpha",
        "segment": "B",
        "date": "2026-03-15",
        "content": "VM provisioning is taking 3 days. We have 12 tickets in queue. The business is waiting on dev environments and we have no self-service path. This is our number one pain."
    },
    {
        "source": "nps_verbatim",
        "team": "Data Platform Team",
        "segment": "C",
        "date": "2026-03-18",
        "content": "We had a Spark pipeline fail last week and spent 4 hours figuring out if it was an infra issue or code. No way to trace from pipeline failure back to infrastructure events. Need lineage across the stack."
    },
    {
        "source": "qbr_note",
        "team": "Migration Team Omega",
        "segment": "A",
        "date": "2026-03-20",
        "content": "We need AI anomaly detection before we start the VMware migration. We want to know if something goes wrong automatically. Can this be in Q1? This is our blocker."
    },
    {
        "source": "interview_note",
        "team": "DC Ops Team Beta",
        "segment": "B",
        "date": "2026-03-12",
        "content": "The CMDB is wrong almost immediately after any change. We stopped trusting it 6 months ago. If you could make CMDB accuracy automatic I would champion this platform."
    },
    {
        "source": "interview_note",
        "team": "Migration Team Alpha",
        "segment": "A",
        "date": "2026-03-10",
        "content": "We need to understand dependencies before we migrate anything. Last migration we took down 3 services nobody knew depended on it. A dependency map would have saved us."
    },
    {
        "source": "support_ticket",
        "team": "DC Ops Team Gamma",
        "segment": "B",
        "date": "2026-03-22",
        "content": "Need self-service provisioning. Currently file a ticket and wait 2-3 days even for simple dev VMs."
    },
    {
        "source": "nps_verbatim",
        "team": "Migration Team Omega",
        "segment": "A",
        "date": "2026-03-19",
        "content": "AI anomaly detection is critical. We cannot migrate without confidence we will know immediately if something breaks."
    },
    {
        "source": "interview_note",
        "team": "Data Platform Team",
        "segment": "C",
        "date": "2026-03-14",
        "content": "We provision Spark clusters manually via Terraform. It takes 45 minutes and has 6 manual steps. An automated provisioning path with right defaults would save us hours weekly."
    },
    {
        "source": "qbr_note",
        "team": "DC Ops Team Alpha",
        "segment": "B",
        "date": "2026-03-21",
        "content": "Chargeback visibility would be nice but provisioning self-service is way more urgent for us right now."
    }
]


def load_feedback(path, fmt):
    p = Path(path)
    if not p.exists():
        raise FileNotFoundError(f"Input file not found: {path}")
    if fmt == "json":
        with open(p) as f:
            data = json.load(f)
        return data if isinstance(data, list) else [data]
    elif fmt == "csv":
        items = []
        with open(p, newline="") as f:
            reader = csv.DictReader(f)
            for row in reader:
                items.append(dict(row))
        return items
    else:
        raise ValueError(f"Unsupported format: {fmt}")


def rank_features(client, feedback):
    feedback_str = json.dumps(feedback, indent=2)
    print(f"  Sending {len(feedback)} feedback items to Claude...")
    response = client.messages.create(
        model="claude-sonnet-4-20250514",
        max_tokens=4000,
        system=SYNTHESIS_SYSTEM,
        messages=[{"role": "user", "content": RANKING_PROMPT.format(feedback=feedback_str)}]
    )
    raw = response.content[0].text.strip()
    if raw.startswith("```"):
        raw = raw.split("```")[1]
        if raw.startswith("json"):
            raw = raw[4:]
    raw = raw.strip()
    result = json.loads(raw)
    result["metadata"]["analysis_timestamp"] = datetime.datetime.utcnow().isoformat() + "Z"
    result["metadata"]["total_feedback_items"] = len(feedback)
    return result


def generate_report(client, ranked):
    print("  Generating markdown report...")
    response = client.messages.create(
        model="claude-sonnet-4-20250514",
        max_tokens=2000,
        messages=[{"role": "user", "content": REPORT_PROMPT.format(ranked_json=json.dumps(ranked, indent=2))}]
    )
    return response.content[0].text


def write_outputs(ranked, report, output_path):
    out = Path(output_path)
    with open(out, "w") as f:
        f.write(report)
    print(f"  Report saved: {out}")
    json_path = out.with_suffix(".json")
    with open(json_path, "w") as f:
        json.dump(ranked, f, indent=2)
    print(f"  JSON saved:   {json_path}")
    if ranked.get("conflicts"):
        print("\n  CONFLICTS:")
        for c in ranked["conflicts"]:
            print(f"    - {c['conflict']}")
            print(f"      Resolution: {c['recommended_resolution']}\n")
    if ranked.get("loudest_voice_flags"):
        print("  LOUDEST VOICE FLAGS:")
        for f_ in ranked["loudest_voice_flags"]:
            print(f"    - {f_['feature']}: {f_['flag']}")


def main():
    parser = argparse.ArgumentParser(description="PM Agent — Priority signal synthesiser")
    parser.add_argument("--input", help="Feedback file (JSON or CSV)")
    parser.add_argument("--format", default="json", choices=["json", "csv"])
    parser.add_argument("--output", default="ranked_backlog.md")
    parser.add_argument("--demo", action="store_true", help="Run with built-in sample data")
    args = parser.parse_args()

    api_key = os.environ.get("ANTHROPIC_API_KEY")
    if not api_key:
        print("ERROR: ANTHROPIC_API_KEY not set.")
        print("       export ANTHROPIC_API_KEY=your_key_here")
        sys.exit(1)

    client = anthropic.Anthropic(api_key=api_key)

    print("\n========================================")
    print("  Intuitive.ai PM Agent — Priority Synth")
    print("========================================\n")

    if args.demo:
        print("  Using built-in sample data (9 items)")
        feedback = SAMPLE_FEEDBACK
        if args.output == "ranked_backlog.md":
            args.output = "demo_ranked_backlog.md"
    elif args.input:
        print(f"  Loading: {args.input}")
        feedback = load_feedback(args.input, args.format)
        print(f"  Loaded {len(feedback)} items")
    else:
        print("ERROR: Provide --input <file> or --demo")
        parser.print_help()
        sys.exit(1)

    print("\n[1/2] Analysing with Claude...")
    ranked = rank_features(client, feedback)
    print(f"  {len(ranked.get('ranked_features', []))} features ranked")

    print("\n[2/2] Generating report...")
    report = generate_report(client, ranked)

    print("\n[Output]")
    write_outputs(ranked, report, args.output)

    ship_order = ranked.get("q1_ship_order", [])
    print(f"\nDone. Q1 ship order: {' -> '.join(ship_order)}\n")


if __name__ == "__main__":
    main()
