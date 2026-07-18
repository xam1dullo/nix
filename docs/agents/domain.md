# Domain Docs

How the engineering skills should consume this repo's domain documentation when exploring the codebase. This repository uses an advanced **Multi-context** layout.

## Advanced Multi-Context Exploration

- **`CONTEXT-MAP.md`** at the repo root is the entry point. It contains a map of all available contexts (e.g. `frontend`, `backend/ordering`, `infrastructure`) and points to their respective `CONTEXT.md` files. **You MUST start here.**
- **`src/<context>/CONTEXT.md`** (or wherever the map points): Read the context-specific file(s) relevant to the current task to understand the ubiquitous language, boundaries, and domain rules of that specific bounded context.
- **`docs/adr/`**: Contains system-wide Architecture Decision Records. Read these for cross-cutting architectural context.
- **`src/<context>/docs/adr/`**: Contains context-scoped decisions. These override global decisions if they conflict, within the boundary of that context.

If any of these files don't exist yet, **proceed silently**. Don't flag their absence; don't suggest creating them upfront. The producer skill (`/grill-with-docs`) creates them lazily when terms or decisions actually get resolved.

## Advanced Multi-Context File Structure

```
/
├── CONTEXT-MAP.md                     ← Global registry of contexts
├── docs/adr/                          ← System-wide architectural decisions
└── src/
    ├── ordering/
    │   ├── CONTEXT.md                 ← Domain vocabulary and rules for ordering
    │   └── docs/adr/                  ← Context-specific decisions for ordering
    └── billing/
        ├── CONTEXT.md                 ← Domain vocabulary and rules for billing
        └── docs/adr/                  ← Context-specific decisions for billing
```

## Use the glossary's vocabulary

When your output names a domain concept (in an issue title, a refactor proposal, a hypothesis, a test name), use the term exactly as defined in the specific `CONTEXT.md` you are operating within. Don't drift to synonyms the glossary explicitly avoids.

## Flag ADR conflicts

If your output contradicts an existing ADR (either global or context-scoped), surface it explicitly rather than silently overriding:

> _Contradicts ADR-0007 (event-sourced orders) — but worth reopening because…_
