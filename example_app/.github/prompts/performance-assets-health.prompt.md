---
mode: agent
---

Define the task to achieve, including specific requirements, constraints, and success criteria.Goal

- Identify static performance risks and waste in UI/assets, propose quick wins, and verify.

Steps

1. Calculate complexity metrics and list fns > threshold (DCM metrics).
2. Run widget analysis for rebuild/structure smells and missing semantics (DCM analyze_widgets).
3. Audit image/asset issues (oversized, wrong formats/dimensions) (DCM analyze_assets).
4. Propose small refactors (extract methods, keys, consts), and image actions (compress/resize/convert).
5. Apply **safe** DCM fixes (if any) + format, then re-analyze to verify deltas.
   Output

- Markdown table of hotspots: (file | function/widget | issue | quick win) + suggested PR checklist.
  Constraints
- No auto-commit; keep edits minimal and safe.
