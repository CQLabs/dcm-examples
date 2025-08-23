---
mode: agent
---

Goal & Context

- Use both always **Dart MCP** and **DCM MCP** to perform a safe package upgrade, apply fixes, and ensure no regressions slip in.

Steps

1. **Plan upgrade**:

   - Run MCP outdated dart pub command.
   - Propose a MCP dart pub upgrade --major-versions plan with preview output.

2. **Apply in isolation**:

   - Apply upgrades in a **temporary patch**.
   - Run analyzer across the workspace (Dart MCP: analyze_files).

3. **Fix candidates**:

   - Propose fix --apply changes.
   - Show a unified diff preview and **ask before applying**.

4. **Quality sweep**:

   - Run DCM analyze.
   - Apply **safe autofixes** + format.
   - Re-analyze to verify.

5. **Summarize**:
   - Highlight analyzer findings and any new DCM “error” severity issues.
   - Draft a PR message with upgraded packages, fixed rules, and follow-up recommendations.

Constraints

- Never stage or commit automatically.
- Pause if the diff exceeds 400 lines.

Output

- **PR summary** including:
  - List of upgraded packages.
  - Applied analyzer fixes (Dart MCP).
  - Applied DCM fixes with rule counts.
  - Remaining issues table: file, line, source=`dart|dcm`, code/rule, message.
  - Recommended follow-ups.
