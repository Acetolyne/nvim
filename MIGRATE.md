# Keybindings to migrate

Keys from `KEYBINDINGS.md` that are not (or not only) set in `core/keymaps.lua`. Paths are relative to `lua/acetolyne/`.

## Search (Telescope)
| Key | Action | Defined in |
|---|---|---|
| `<leader>sf` | Fuzzy find files in the cwd | `core/keymaps.lua` and `plugins/telescope.lua` (duplicate) |
| `<leader>sr` | Recent files | `core/keymaps.lua` and `plugins/telescope.lua` (duplicate) |
| `<leader>ss` | Live grep in the cwd | `core/keymaps.lua` and `plugins/telescope.lua` (duplicate) |
| `<leader>sc` | Grep the word under the cursor | `core/keymaps.lua` and `plugins/telescope.lua` (duplicate) |

## LSP (only active in buffers with an LSP attached)
| Key | Action | Defined in |
|---|---|---|
| `gd` | Definitions | `plugins/lsp/lspconfig.lua` |
| `gD` | Declaration | `plugins/lsp/lspconfig.lua` |
| `gR` | References | `plugins/lsp/lspconfig.lua` |
| `gi` | Implementations | `plugins/lsp/lspconfig.lua` |
| `gt` | Type definitions | `plugins/lsp/lspconfig.lua` |
| `K` | Hover documentation | `plugins/lsp/lspconfig.lua` |
| `<leader>ca` | Code actions (normal and visual) | `plugins/lsp/lspconfig.lua` |
| `<leader>rn` | Rename symbol | `plugins/lsp/lspconfig.lua` |
| `<leader>d` | Show line diagnostics in a float | `plugins/lsp/lspconfig.lua` |
| `<leader>D` | File diagnostics in Telescope | `plugins/lsp/lspconfig.lua` |
| `[d` / `]d` | Previous / next diagnostic | `plugins/lsp/lspconfig.lua` |
| `<leader>rs` | Restart the LSP | `plugins/lsp/lspconfig.lua` |

## Diagnostics lists (Trouble)
| Key | Action | Defined in |
|---|---|---|
| `<leader>iw` | Workspace diagnostics | `plugins/trouble.lua` |
| `<leader>id` | Diagnostics for the current buffer | `plugins/trouble.lua` |
| `<leader>iq` | Quickfix list | `plugins/trouble.lua` |
| `<leader>il` | Location list | `plugins/trouble.lua` |
| `<leader>it` | TODOs | `plugins/trouble.lua` |

## TODO comments
| Key | Action | Defined in |
|---|---|---|
| `]t` / `[t` | Next / previous TODO comment | `plugins/todo-comments.lua` |

## Git
| Key | Action | Defined in |
|---|---|---|
| `<leader>go` | Open Neogit in a vsplit | `plugins/neogit.lua` |
| `<leader>gb` / `<leader>tb` | Toggle inline blame on the current line | `core/keymaps.lua` (`gb`), `plugins/gitsigns.lua` (`tb`) |
| `<leader>gh` / `<leader>hi` | Preview the hunk inline | `core/keymaps.lua` (`gh`), `plugins/gitsigns.lua` (`hi`) |
| `]c` / `[c` | Next / previous hunk | `plugins/gitsigns.lua` |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk (also works on a visual selection) | `plugins/gitsigns.lua` |
| `<leader>hS` / `<leader>hR` | Stage / reset the whole buffer | `plugins/gitsigns.lua` |
| `<leader>hp` | Preview hunk in a popup | `plugins/gitsigns.lua` |
| `<leader>hb` | Full blame popup for the line | `plugins/gitsigns.lua` |
| `<leader>hd` / `<leader>hD` | Diff against the index / against `~` | `plugins/gitsigns.lua` |
| `<leader>hq` / `<leader>hQ` | Hunks to quickfix (buffer / all) | `plugins/gitsigns.lua` |
| `<leader>tw` | Toggle word diff | `plugins/gitsigns.lua` |
| `ih` (operator/visual) | Select the hunk as a text object | `plugins/gitsigns.lua` |

## Clipboard (system clipboard, custom)
| Key | Action | Defined in |
|---|---|---|
| `<leader>y` | Copy the line (normal) or selection (visual) to the system clipboard | `core/clipboard.lua` |
| `<leader>p` | Paste from the system clipboard (visual mode replaces the selection) | `core/clipboard.lua` |

## Completion (nvim-cmp)
| Key | Action | Defined in |
|---|---|---|
| `<C-j>` / `<C-k>` | Next / previous suggestion | `plugins/nvim-cmp.lua` |
| `<C-b>` / `<C-f>` | Scroll docs up / down | `plugins/nvim-cmp.lua` |
| `<C-Space>` | Trigger completion | `plugins/nvim-cmp.lua` |
| `<C-e>` | Close the completion menu | `plugins/nvim-cmp.lua` |
| `<CR>` | Confirm the selection | `plugins/nvim-cmp.lua` |

## Misc
| Key | Action | Defined in |
|---|---|---|
| `<C-Space>` | Treesitter: start / grow the selection | `plugins/treesitter.lua` |

## Claude Code and Comment.nvim
| Key | Action | Defined in |
|---|---|---|
| `<leader>ct` | Toggle Claude Code (normal and terminal) | `plugins/claudecode.lua` |
| `<leader>cc` / `<leader>cv` / `<leader>cr` | Claude Code with continue / verbose / resume | `plugins/claudecode.lua` |
| `gcc` / `gbc` / `gc` / `gb` / `gco` / `gcO` / `gcA` | Comment toggles and extras | `plugins/comment.lua` (plugin defaults) |

## Search (Telescope), inside the picker
| Key | Action | Defined in |
|---|---|---|
| `<C-k>` / `<C-j>` | Move up / down | `plugins/telescope.lua` |
| `<C-q>` | Send selected results to the quickfix list | `plugins/telescope.lua` |
