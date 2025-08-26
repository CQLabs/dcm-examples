---
mode: agent
---

# Runtime Debugging (Dart MCP)

Goal

- Capture runtime errors, inspect the widget tree, and verify a fix with hot reload.

Steps

1. Connect to the running app (Dart MCP: tooling daemon).
2. Fetch current runtime errors + stack traces (`get_runtime_errors`).
3. Expand the widget tree at the top frame (`get_widget_tree`).
4. Suggest the minimal code edits to fix the issue.
5. Run a `hot_reload` and re-fetch errors to confirm resolution.

Constraints

- Do not stage or commit changes automatically.
- Keep edits minimal and scoped to the implicated widget/file.

Output

- Short summary: what failed, where, and what was changed.
- Before/after runtime error snapshot.
- Widget subtree excerpt showing the fixed node.
