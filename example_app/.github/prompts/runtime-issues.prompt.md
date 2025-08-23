---
mode: agent
---

Goal

- Triage a runtime error (e.g., RenderFlex overflow, NPE), propose a fix, apply safe changes, and verify via hot reload.

Steps

1. Connect to the Dart Tooling Daemon and fetch current runtime errors and stack traces (Dart MCP).
2. Expand the failing widget context (get_widget_tree at the stack’s top frame), capture key props (Dart MCP).
3. Open implicated files and run static checks (DCM analyze) only on those files.
4. Propose minimal code edits. Apply **only safe/autofixable** DCM fixes; format (DCM).
5. Hot-reload the app and re-query runtime errors (Dart MCP).
6. If still failing, show next-best edits; otherwise summarize: what changed, which DCM rules fired, before/after runtime status.
   Constraints

- Never stage/commit. Ask if edits exceed 200 changed lines.
  Output
- Short summary + diff snippet + linkable file:line list.
