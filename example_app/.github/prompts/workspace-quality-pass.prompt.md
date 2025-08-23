---
mode: agent
---

Goal: Run a full DCM quality pass across the whole branch: analyze → safe autofix → format → re-analyze → propose a PR commit message → list remaining issues with links.

Context

- Use DCM MCP tools for analyze/fix/format. Do NOT stage or commit.
- Respect an existing baseline if present; call out only-new issues when relevant.
- Output is in chat only (no files written).

Steps

1. Analyze (whole workspace on current branch):

   - Run DCM analyze across the entire workspace (minus .g.dart files and excluded files and folders).
   - Collect machine-readable findings and summarize:
     • totals by severity
     • top rules by count
     • top files by count

2. Safe Autofix:
   - Apply only safe/autofixable changes.
   - Show a unified diff preview (do NOT stage/commit).
   - If the diff exceeds 200 lines, pause and ask before applying.
3. Format:Format files that were changed by autofixes.

4. Verify:

   - Re-run DCM analyze on the whole workspace.
   - Show before/after counts, noting any residual “error” severity.

5. Propose PR Commit Message:

   - Conventional header:
     chore(dcm): apply safe autofixes across branch
   - Bullets summarizing fixed rules with counts (e.g., `avoid-unsafe-reduce: 7`).
   - Note: “safe fixes only; no files staged or committed.”

6. Report Remaining Issues (with links):
   - Produce a Markdown table:
     | file | line | rule_id | message | link |
   - For GitHub/GitLab/ADO remotes, construct a URL to the current {{branch}} at the line.
   - Otherwise, provide `relative/path.dart:line`.

Constraints

- Never stage or commit automatically.
- Only apply changes considered safe/autofixable by DCM.
- Keep the chat output concise; collapse long logs into summaries.

Output

- Proposed PR commit message (fenced).
- Summary of applied fixes (rule → count).
- Table of remaining findings with links (file, line, rule_id, message, link).
- One-line next step (e.g., “open these files” or “run the tuning prompt”).
