---
mode: agent
---

Goal

- Perform a **safe** package upgrade, apply analyzer/Dart fixes, then run a DCM pass to catch regressions.

Steps

1. Run `pub outdated` then plan `pub upgrade --major-versions` with a preview (Dart MCP: pub).
2. Apply upgrades **in a temp patch**; run analyzer on the workspace (Dart MCP: analyze_files).
3. Propose `dart fix --apply` candidates; show a diff preview; ASK before applying (Dart MCP: dart_fix, dart_format).
4. Run DCM analyze → **safe autofix** → format → re-analyze (DCM).
5. Summarize breaking changes discovered by analyzer + any new DCM “error” findings. Propose a PR message + follow-ups.
   Constraints

- No auto-commit. Pause if diff > 400 lines.
  Output
- PR summary with upgraded packages, applied fixes, remaining issues (file:line, rule/code), and recommended follow-ups.
