# nvim-treesitter Archived — Impact Analysis Context

**Date:** April 3, 2026
**Status:** Repository archived (read-only). No further updates.
**Repo:** `nvim-treesitter/nvim-treesitter`

## What Happened

The sole maintainer (clason) archived the nvim-treesitter repository after a hostile exchange in GitHub Discussions. The plugin is now frozen — no new parser updates, no query file updates, no bug fixes.

## What nvim-treesitter Provided

1. **Parser management:** `ensure_installed`, `:TSInstall`, `:TSUpdate`, `auto_install` — downloading, compiling, and pinning tree-sitter grammar `.so` files via `tree-sitter-cli`.
2. **Curated query files:** `highlights.scm`, `indents.scm`, `folds.scm`, `injections.scm`, `textobjects.scm` — mapping tree-sitter AST node types to Neovim highlight groups and editor features.
3. **Abstraction API:** `require('nvim-treesitter').setup()`, module system for configuring highlighting, indentation, folding, incremental selection.
4. **Compatibility shims:** Version-gated code bridging differences between Neovim releases.

## What Neovim Provides Natively (without nvim-treesitter)

- `vim.treesitter.start()` — enable treesitter highlighting for a buffer
- `vim.treesitter.foldexpr()` — treesitter-based folding
- `vim.treesitter.language.register()` — associate filetypes with parsers
- Query file loading from `queries/{lang}/*.scm` in any runtimepath directory
- `:InspectTree` — built-in AST inspector
- Bundled parsers for C, Lua, Vim, Vimdoc, Markdown, Bash, Python, and Query (as of 0.12)

## What You Lose

- **Auto-installation of parsers** — must install manually or use a replacement plugin
- **The curated query file collection** — highlights/indents/folds for ~300 languages
- **`:TSUpdate` workflow** — synchronized parser + query updates
- **`ensure_installed` convenience** — declarative parser list in config

## Replacement Components

| Lost feature | Replacement | Notes |
|---|---|---|
| Parser auto-install | `lewis6991/ts-install.nvim` | Standalone parser installer, recommended by nvim-treesitter before archival |
| Query files | Fork of nvim-treesitter or manual runtimepath management | The query files are the real value; community forks expected |
| Highlighting setup | `vim.treesitter.start()` in ftplugin or FileType autocmd | Native Neovim API |
| Folding | `vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'` | Native Neovim API |
| Indentation | `vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"` | Was experimental even before archival |
| Textobjects | `nvim-treesitter-textobjects` (separate repo, not yet archived) | Check if still maintained |
| Context | `nvim-treesitter-context` (separate repo, not yet archived) | Check if still maintained |

## Current State

- Already running Neovim 0.12
- Some treesitter config changes already made for the 0.12 upgrade
- Focus analysis on remaining nvim-treesitter dependencies and migration gaps, not on the 0.11 → 0.12 version issue

## What to Look For in the Config

When analyzing a Neovim configuration for impact, check for:

1. **Direct dependency:** Any `nvim-treesitter/nvim-treesitter` in plugin specs (lazy.nvim, packer, vim-plug, etc.)
2. **Setup calls:** `require('nvim-treesitter').setup()` or the older `require('nvim-treesitter.configs').setup()`
3. **ensure_installed lists:** Declarative parser lists that will no longer auto-install on new machines
4. **auto_install = true:** Was already removed in recent versions; if present, config is stale
5. **`:TSInstall` / `:TSUpdate` commands:** In keymaps, autocmds, or build hooks
6. **Module references:** `highlight = { enable = true }`, `indent = { enable = true }`, `incremental_selection`, `rainbow` — these are nvim-treesitter module configs
7. **Transitive dependencies:** Plugins that `require('nvim-treesitter')` internally:
   - `nvim-treesitter-textobjects`
   - `nvim-treesitter-context`
   - `nvim-treesitter-refactor`
   - `nvim-ts-autotag`
   - `nvim-ts-context-commentstring` (now `ts-comments.nvim` or built-in in 0.12)
   - Various colorschemes that check for treesitter highlight groups
8. **Pinned commits/branches:** `branch = "main"` or `commit = "..."` in plugin spec — frozen at archival point
9. **build = ':TSUpdate'** in lazy.nvim spec — will error on archived repo if parsers need recompilation
10. **Parser-dependent features:** Any filetype that relies on non-bundled parsers (TypeScript, Rust, Go, etc.) for highlighting, folding, or indentation

## Risk Assessment (given 0.12 + partial migration)

- **Immediate:** No breakage if you don't update. Pinned commit continues to work on 0.12.
- **Short-term:** New parser grammars won't be tracked. New languages won't get query files.
- **Medium-term:** As upstream parsers evolve, pinned query files will drift out of sync, causing highlighting bugs.
- **Long-term:** Community will consolidate around a fork or Neovim will absorb more functionality. Migration will be needed.
- **Priority:** Identify any remaining nvim-treesitter plugin API calls that could be replaced with native 0.12 APIs or standalone alternatives, since the user has already started this migration.

## Recommended Actions

1. Pin nvim-treesitter to its final commit in your plugin manager
2. Evaluate `lewis6991/ts-install.nvim` as parser installer replacement
3. Monitor for a community fork of the query file collection
4. For languages you actively use, consider vendoring query files into your own runtimepath
5. Test removing nvim-treesitter entirely and using native `vim.treesitter.start()` + bundled parsers to see what breaks
