# Neovim Keybindings

Leader is `<Space>`. The "Defined in" column tracks where each key is set; the goal is for everything to live in `core/keymaps.lua`. Paths are relative to `lua/acetolyne/`. Collected from the config files; not tested in a live session.

## Files and explorer (nvim-tree)
| Key | Action | Defined in |
|---|---|---|
| `<leader>f` | Open and focus the file tree | `core/keymaps.lua` |
| `<leader>ft` | Toggle the file tree | `core/keymaps.lua` |
| `<leader>ff` | Toggle the tree on the current file | `core/keymaps.lua` |
| `<leader>fc` | Collapse the tree | `core/keymaps.lua` |
| `<leader>fr` | Refresh the tree | `core/keymaps.lua` |
| `<leader>fb` | Reformat the whole buffer (`gg=G`, re-indents, not LSP formatting) | `core/keymaps.lua` |

## Search (Telescope)
| Key | Action | Defined in |
|---|---|---|
| `<leader>sf` | Fuzzy find files in the cwd | `core/keymaps.lua` and `plugins/telescope.lua` (duplicate) |
| `<leader>sr` | Recent files | `core/keymaps.lua` and `plugins/telescope.lua` (duplicate) |
| `<leader>ss` | Live grep in the cwd | `core/keymaps.lua` and `plugins/telescope.lua` (duplicate) |
| `<leader>sc` | Grep the word under the cursor | `core/keymaps.lua` and `plugins/telescope.lua` (duplicate) |
| `<leader>st` | Find TODO comments | `core/keymaps.lua` |

Inside Telescope: `<C-k>` and `<C-j>` move up and down, and `<C-q>` sends the selected results to the quickfix list (defined in `plugins/telescope.lua`).

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

## Terminal (ToggleTerm)
| Key | Action | Defined in |
|---|---|---|
| `<leader>tt` | Toggle the shell buffer | `core/keymaps.lua` |
| `<leader>ta` | Toggle all shell buffers | `core/keymaps.lua` |

In terminal mode:

| Key | Action | Defined in |
|---|---|---|
| `<C-t>` / `jk` | Exit to normal mode | `core/keymaps.lua` |
| `<C-h/j/k/l>` | Move between windows | `core/keymaps.lua` |
| `<C-w>` | Window command prefix | `core/keymaps.lua` |

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
| `<leader>cs` | Cheat.sh popup (normal and insert) | `core/keymaps.lua` |

## Claude Code and Comment.nvim
| Key | Action | Defined in |
|---|---|---|
| `<leader>ct` | Toggle Claude Code (normal and terminal) | `plugins/claudecode.lua` |
| `<leader>cc` / `<leader>cv` / `<leader>cr` | Claude Code with continue / verbose / resume | `plugins/claudecode.lua` |
| `gcc` / `gbc` / `gc` / `gb` / `gco` / `gcO` / `gcA` | Comment toggles and extras | `plugins/comment.lua` (plugin defaults) |

## Still outside `core/keymaps.lua`
Any row whose "Defined in" column names another file still needs moving: LSP, Trouble, TODO comments, Neogit, gitsigns (except `gb`/`gh`), clipboard, nvim-cmp, treesitter, Telescope's in-picker keys, Claude Code and Comment.nvim. The Telescope `<leader>s*` keys are defined in both places and should be removed from `plugins/telescope.lua`.

## Notes
- `<leader>f` sits on the same prefix as `ft`, `ff`, `fc`, `fr` and `fb`. Vim waits out `timeoutlen` before it fires, so opening the tree feels slightly delayed.
- Three terminal maps (`jk`, `<C-h/j/k/l>`, `<C-w>`) have the description "UNKNOWN".
- Some mappings not listed are plugin defaults, such as the nvim-tree buffer keys and the Neogit UI keys.
