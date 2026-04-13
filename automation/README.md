# PM Agent — Setup & Usage

Ingests consumer feedback → calls Claude Sonnet → outputs ranked feature
backlog with conflict analysis and a stakeholder-ready markdown report.

## Setup (2 minutes)

```bash
cd automation
pip install -r requirements.txt
export ANTHROPIC_API_KEY=sk-ant-...
python pm-agent.py --demo
```

## Usage

```bash
# Demo mode (9 built-in sample feedback items)
python pm-agent.py --demo

# Your own JSON file
python pm-agent.py --input my_feedback.json --output ranked_backlog.md

# CSV export from Jira
python pm-agent.py --input tickets.csv --format csv --output report.md
```

## Input format (JSON)

```json
[
  {
    "source": "support_ticket | nps_verbatim | qbr_note | interview_note",
    "team": "Team name",
    "segment": "A | B | C",
    "date": "YYYY-MM-DD",
    "content": "The feedback text"
  }
]
```

Segments: A = Migration · B = DC Ops · C = Data/AI platform

## Outputs

- `ranked_backlog.md` — human-readable leadership report
- `ranked_backlog.json` — structured data, feeds Agent 2

## What it surfaces

1. Ranked features weighted by: frequency x segment impact x strategic alignment x tech debt cost
2. Conflicts — where consumer priority conflicts with delivery best practice
3. Loudest voice flags — high-frequency requests from few teams
4. Q1 ship order respecting dependencies

## Weekly workflow

1. Export support tickets to CSV
2. Add QBR notes or NPS verbatims
3. Run: `python pm-agent.py --input weekly.csv --format csv`
4. Review conflicts in terminal output
5. Use ranked output as starting point for sprint planning

## Cost estimate

~$0.01-0.03 per run with Claude Sonnet. ~$0.30-0.90/month for daily runs.
