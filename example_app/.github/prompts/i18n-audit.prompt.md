---
mode: agent
---

Goal

- Find hard-coded user-facing strings, clean up unused l10n, and align gen-l10n with analyzer.

Steps

1. Scan for l10n issues and **unused l10n** (DCM: check_unused_l10n + analyze).
2. Detect hard-coded strings in UI files; propose extraction points and ARB keys (DCM findings + heuristics).
3. Validate l10n setup with analyzer (Dart MCP: analyze_files); report missing delegates/locale configs.
4. Offer a staged plan:
   - generate/merge ARB entries,
   - replace literals with lookups (provide line-level edits),
   - remove unused keys.
5. Apply **safe** replacements where trivial; format; re-analyze (both).
   Output

- Checklist: new keys, replacements, remaining manual items with file:line links.
  Constraints
- Don’t auto-modify ARB files without confirmation.
