---
mode: agent
---
Goal: Propose DCM rules that fit my intent, with YAML-ready IDs.

Context:

- Use the DCM MCP rule catalog (ids, categories, severity, autofixable, short description).
- If rules live in a dedicated DCM config, target that. Otherwise, prepare an analysis_options.yaml snippet.
- Do NOT commit anything.
- rules are always in analysis_options.yaml file and under dart_code_metrics as following example:
    dart_code_metrics:
      extends:
        - presets-name, e.g recommended
      rules:
        - rule-id e.g avoid-slow-collection-methods # Comment
      metrics:
        metric-id e.g lines-of-code: metric value e.g 10

Steps:

1) Query the rule catalog and filter rules based on {{["performance", "memory-leaks"]}} only on category {{["common", "flutter"]}}
2) Output a table:
   | rule_id | category | severity | autofixable | why it matches my keywords |
3) Output a YAML-ready rules' Ids with same-line comments
4) Suggest what to try first (autofixable rules).

Output:

- Markdown table with link to documentation
- Using reporter yaml to output analysis_option.yaml ready rules with only rules' IDs with no extra config
- A 3–5 line recommendation (“Start with these X rules because…”).
