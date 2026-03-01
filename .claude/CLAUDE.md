## Tool Preferences

1. Built-in tools (Read, Grep, Glob, Edit) over MCP over terminal commands
2. Exceptions — ALWAYS use MCP for these:
   - Git MCP for all git operations
   - GitHub MCP for GitHub repository operations

## Search & Web Tools

Use the right tool for the job — they are complementary, not interchangeable.

### Built-in WebSearch / WebFetch
- **WebSearch**: Quick factual lookups, documentation questions, syntax checks, "what is X"
- **WebFetch**: Read a specific URL when you already have it. Basic — fails on protected/JS-heavy sites

### Tavily MCP — extraction, crawling, research
- **tavily_search**: General web search (use when WebSearch is unavailable or needs domain/date filtering)
- **tavily_extract**: Pull full content from URLs including protected sites (LinkedIn, paywalled). Use instead of WebFetch when it fails
- **tavily_crawl**: Traverse an entire website in parallel (e.g., "read all pages of this library's docs")
- **tavily_map**: Discover a website's URL structure without extracting content
- **tavily_research**: Autonomous multi-step research agent — performs 5-15 searches, reads pages, synthesizes a report. Use for complex questions requiring multiple angles (e.g., "compare approaches to X with trade-offs")

### Exa MCP — semantic search, category filters
- **web_search_exa**: Neural/semantic search — finds conceptually relevant results, not just keyword matches. Use when keyword search returns poor results
- **get_code_context_exa**: Code-specific search across GitHub, Stack Overflow, docs. Returns compact snippets
- **company_research_exa**: Business/company information lookup
- **web_search_advanced_exa**: Full control over filters, domains, dates, content options
- **crawling_exa**: Full webpage content retrieval from a known URL
- **people_search_exa**: Professional profile search (LinkedIn)
- **deep_researcher_start/check**: Async deep research agent (alternative to tavily_research)
- **Category filters**: Use `tweet` for Twitter/X content, `research_paper` for academic papers, `company`, `people`

### Context7 MCP — library documentation
- Use for API docs and library usage questions — more precise than any web search for this specific use case

## Git & GitHub

- Conventional Commits standard for commit messages and branch names
- AI-generated PR/issue text must be signed with model info

## NVM & Node

- When running Node and Yarn commands, execute `nvm use` first (no need to source `nvm.sh`) in the working directory to set the correct Node.js version.

@~/.claude/work.md
