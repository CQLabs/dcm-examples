---
mode: agent
---

Define the task to achieve, including specific requirements, constraints, and success criteria.Goal

- Scan all Dart files in the workspace with both Dart/Flutter analyzer and DCM.
- Apply SAFE DCM autofixes and format, then re-check.
- Produce a PR-ready summary and a proposed commit message.
- List anything still failing with links.

Context

- Use BOTH MCP servers:
  - Dart MCP server → run analyzer across all `.dart` files; surface errors/warnings (don’t auto-apply analyzer fixes).
  - DCM MCP server → analyze + safe autofix + format + re-analyze across the workspace.
- Treat diffs > 200 changed lines as “large” and ASK before applying DCM autofixes.
- Do NOT stage or commit changes automatically.
- Output is in chat only (no files written).

Steps

1. Discover targets:
   - Find all `*.dart` files in the workspace.
   - Exclude common generated/build outputs (e.g., `/*.g.dart`, `/*.freezed.dart`, `build/`).
2. Dart/Flutter analyzer (via Dart MCP):
   - Run analyzer on all discovered Dart files.
   - Collect errors/warnings with file, line, code, and message.
3. DCM pass (via DCM MCP) on the workspace:
   - Run DCM analyze; summarize by severity and rule.
   - Apply SAFE autofixes only; show a unified diff preview. If the diff exceeds 200 lines, pause and ask.
   - Format changed files.
   - Re-run DCM analyze to verify; show before/after counts.
4. Compose outputs:

   - Proposed commit message (conventional):

     ```
     chore(quality): safe DCM autofixes + formatting (workspace)

     - fixed:
       - <rule_id>: <count>
       - <rule_id>: <count>
     - note: only safe DCM fixes applied; nothing staged/committed
     ```

   - PR Summary (paste-ready):
     • Scope: all Dart files in workspace  
     • DCM fixed: per-rule counts  
     • Analyzer results: remaining errors/warnings  
     • Remaining issues table (merged Dart/Flutter + DCM):
     | file | line | source | code/rule | message | link |
     - For GitHub/GitLab/ADO, build URLs to the current HEAD line; else use `relative/path.dart:line`.
   - Next steps: concise checklist for any residual error severity.

Constraints

- Never stage or commit automatically.
- Only apply DCM-labeled safe/autofixable changes.
- Keep output concise; collapse verbose logs into summaries.

Output

- Proposed PR commit message (fenced).
- PR Summary block (paste-ready).
- Table of remaining issues with links (file, line, source=`dart|flutter|dcm`, code/rule, message, link).
- One-line next step.
