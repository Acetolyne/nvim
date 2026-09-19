# Neovim Keybindings

Leader is `<Space>`. Collected from the config files; not tested in a live session.

## Files and explorer (nvim-tree)
| Key | Action |
|---|---|
| `<leader>f` | Open and focus the file tree |
| `<leader>ft` | Toggle the file tree |
| `<leader>ff` | Toggle the tree on the current file |
| `<leader>fc` | Collapse the tree |
| `<leader>fr` | Refresh the tree |
| `<leader>fb` | Reformat the whole buffer (`gg=G`, re-indents, not LSP formatting) |

## Search (Telescope)
| Key | Action |
|---|---|
| `<leader>sf` | Fuzzy find files in the cwd |
| `<leader>sr` | Recent files |
| `<leader>ss` | Live grep in the cwd |
| `<leader>sc` | Grep the word under the cursor |
| `<leader>st` | Find TODO comments |

Inside Telescope: `<C-k>` and `<C-j>` move up and down, and `<C-q>` sends the selected results to the quickfix list.

## LSP (only active in buffers with an LSP attached)
| Key | Action |
|---|---|
| `gd` | Definitions |
| `gD` | Declaration |
| `gR` | References |
| `gi` | Implementations |
| `gt` | Type definitions |
| `K` | Hover documentation |
| `<leader>ca` | Code actions (normal and visual) |
| `<leader>rn` | Rename symbol |
| `<leader>d` | Show line diagnostics in a float |
| `<leader>D` | File diagnostics in Telescope |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>rs` | Restart the LSP |

## Diagnostics lists (Trouble)
| Key | Action |
|---|---|
| `<leader>iw` | Workspace diagnostics |
| `<leader>id` | Diagnostics for the current buffer |
| `<leader>iq` | Quickfix list |
| `<leader>il` | Location list |
| `<leader>it` | TODOs |

## TODO comments
| Key | Action |
|---|---|
| `]t` / `[t` | Next / previous TODO comment |

## Git
| Key | Action |
|---|---|
| `<leader>go` | Open Neogit in a vsplit |
| `<leader>gb` / `<leader>tb` | Toggle inline blame on the current line |
| `<leader>gh` / `<leader>hi` | Preview the hunk inline |
| `]c` / `[c` | Next / previous hunk |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk (also works on a visual selection) |
| `<leader>hS` / `<leader>hR` | Stage / reset the whole buffer |
| `<leader>hp` | Preview hunk in a popup |
| `<leader>hb` | Full blame popup for the line |
| `<leader>hd` / `<leader>hD` | Diff against the index / against `~` |
| `<leader>hq` / `<leader>hQ` | Hunks to quickfix (buffer / all) |
| `<leader>tw` | Toggle word diff |
| `ih` (operator/visual) | Select the hunk as a text object |

## Terminal (ToggleTerm)
| Key | Action |
|---|---|
| `<leader>tt` | Toggle the shell buffer |
| `<leader>ta` | Toggle all shell buffers |

In terminal mode:

| Key | Action |
|---|---|
| `<C-t>` / `jk` | Exit to normal mode |
| `<C-h/j/k/l>` | Move between windows |
| `<C-w>` | Window command prefix |

## Clipboard (system clipboard, custom)
| Key | Action |
|---|---|
| `<leader>y` | Copy the line (normal) or selection (visual) to the system clipboard |
| `<leader>p` | Paste from the system clipboard (visual mode replaces the selection) |

## Completion (nvim-cmp)
| Key | Action |
|---|---|
| `<C-j>` / `<C-k>` | Next / previous suggestion |
| `<C-b>` / `<C-f>` | Scroll docs up / down |
| `<C-Space>` | Trigger completion |
| `<C-e>` | Close the completion menu |
| `<CR>` | Confirm the selection |

## Misc
| Key | Action |
|---|---|
| `<C-Space>` | Treesitter: start / grow the selection |
| `<leader>cs` | Cheat.sh popup (normal and insert) |

## Notes
- `<leader>f` sits on the same prefix as `ft`, `ff`, `fc`, `fr` and `fb`. Vim waits out `timeoutlen` before it fires, so opening the tree feels slightly delayed.
- Three terminal maps (`jk`, `<C-h/j/k/l>`, `<C-w>`) have the description "UNKNOWN".
- The Comment.nvim mappings (`gcc`, `gc`) and the Claude Code plugin's own keys are set inside their plugin configs and aren't listed here.
- Some mappings not listed are plugin defaults, such as the nvim-tree buffer keys and the Neogit UI keys.
