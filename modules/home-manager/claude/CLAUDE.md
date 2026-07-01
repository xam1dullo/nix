- In all interactions and commit messages, be extremely concise and sacrifice grammar for the sake of concision.

## GitHub

- Your primary method for interacting with GitHub should be the GitHub CLI.

## Plans

- At the end of each plan, give me a list of unresolved questions to answer, if any. Make the questions extremely concise. Sacrifice grammar for the sake of concision.

## Matt Pocock Local Skills

- Matt Pocock skills from `deprecated`, `engineering`, `in-progress`, `misc`, `personal`, and `productivity` are installed locally in `/Users/admin/.claude/skills`.
- Use these local `SKILL.md` files directly when a task matches their descriptions. Do not fetch the GitHub repo again unless the user asks to update from upstream.
- The customized `obsidian-vault` skill is the local source of truth for RAG and must stay pointed at `/Users/admin/Documents/claude-node`.

## Obsidian-Backed Memory System

All persistent memory lives in a single Obsidian vault at `/Users/admin/Documents/claude-node/`. This overrides the default per-project memory path. Regardless of which project is active, always read from and write to this vault.

### RAG-first

Before answering or searching for anything that may depend on prior projects, saved decisions, architecture history, personal preferences, reusable knowledge, or local context, search the Obsidian/RAG vault first:

```bash
/Users/admin/Documents/claude-node/scripts/rag-search.sh "query"
```

Use external web search only after the vault has been checked, unless the user explicitly asks for live/current information.

### Memory Directory

All memory files go to `/Users/admin/Documents/claude-node/memory/`. Use the same frontmatter schema and type conventions defined in the auto-memory instructions, but write all files here — never to per-project `.claude` paths.

### Obsidian MCP Tool

A globally configured `obsidian` MCP server provides read access to the vault. Use it to:
- Search existing wiki pages before creating a new memory entry — avoid duplicating knowledge already captured in `wiki/`
- Read entity and concept pages to enrich memory files with accurate cross-links
- Verify a `[[wikilink]]` target exists before referencing it; create a stub if it doesn't

### Project Initialization Protocol

When the user begins work in any new project directory:
1. Search `wiki/entities/` for an existing project page
2. If absent, create `wiki/entities/<ProjectName>.md` with frontmatter: `created`, `updated`, `tags: [project]`, `sources: []`
3. Register it in `wiki/index.md` under a Projects section
4. Append an entry to `wiki/log.md`: `[YYYY-MM-DD] init | <ProjectName>`

### Cross-Linking Rules

Every memory file must `[[wikilink]]` to relevant vault pages:
- Tool used → `[[entities/ToolName]]`
- Pattern or principle applied → `[[concepts/PatternName]]`
- Missing wiki page → create a stub, then link

Every wiki entity or concept page touched during a session must backlink to the relevant project or memory context. Bidirectional links are mandatory — a one-directional link is incomplete.

### Knowledge Escalation

When a memory entry contains reusable, project-agnostic insight, escalate it to the wiki:
- Tool evaluation → `wiki/entities/<Tool>.md`
- Design pattern observed → `wiki/concepts/<Pattern>.md`
- Comparative analysis → `wiki/analysis/<topic>.md`
- Always log the escalation in `wiki/log.md`

### Invariants

- **No duplication**: search the wiki before writing a new memory file
- **No orphans**: every new wiki page must be linked from `wiki/index.md`
- **No silent writes**: every wiki mutation must have a `wiki/log.md` entry
- **Memory is private context; wiki is the canonical knowledge store**
