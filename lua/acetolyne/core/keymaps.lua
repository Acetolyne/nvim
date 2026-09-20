vim.g.mapleader = " "

local keymap = vim.keymap
--local neogit = require('neogit')

-- @todo below should change to NvimTree so we get the file list on the side instead of taking over the current buffer
--vim.keymap.set('n', '<leader>f', ':Explore<CR>', {
--    noremap = true,
--    desc = "Opens file explorer"
--  }) 

-- increment/decrement numbers
--keymap.set("n", "<leader>-", "<C-a>", { desc = "Increment number" }) -- increment
--keymap.set("n", "<leader>=", "<C-x>", { desc = "Decrement number" }) -- decrement

-- nvim tree mappings

keymap.set("n", "<leader>fo", "<cmd>NvimTreeFocus<CR>", { desc = "Open and focus file tree" }) -- toggle file explorer
keymap.set("n", "<leader>ft", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree view" }) -- toggle file explorer
keymap.set("n", "<leader>ff", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
keymap.set("n", "<leader>fc", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
keymap.set("n", "<leader>fr", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

-- telescope mappings

keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>sr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>ss", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>sc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })

-- find todo comments

keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

-- toggleterm
keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", {desc = "Toggle visibility of shell buffer"})
keymap.set("n", "<leader>ta", "<cmd>ToggleTermToggleAll<cr>", {desc = "Toggle visibility of all shell buffers"})

-- cheat sh
keymap.set({"n","i"}, "<leader>cs", "<cmd>Cheat<cr>", {desc = "show cheat sh popup window"})

-- toggle term keymaps for inside the terminal
function _G.set_terminal_keymaps()
  --vim.keymap.set('t', '<C-t>', [[<C-\><C-n>]], {buffer = 0, desc = "exit terminal mode"})
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], {buffer = 0, desc = "exit terminal mode"})
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- hotkeys to format current file
keymap.set('n', '<leader>fb', function() vim.lsp.buf.format({ async = true }) end, {desc = "format current buffer (LSP)"})
keymap.set('n', '<leader>fi', "mzgg=G`z", {desc = "re-indent current buffer"})

-- noice keymaps
-- TODO: add any noice plugin keymaps here

-- git signs
-- TODO: add gitsigns keymaps here instead of in the gitsigns setup
vim.keymap.set('n', '<leader>gb', "<cmd>Gitsigns toggle_current_line_blame<cr>", {desc = "toggle git line blame"})
vim.keymap.set('n', '<leader>gh', "<cmd>Gitsigns preview_hunk_inline<cr>", {desc = "toggle git inline hunk"})

-- neogit keymaps
-- NOTE: neogit keymaps are configured in neogit.lua plugin file to ensure the plugin is loaded first

-- claude code keymaps
keymap.set({ "n", "x" }, "<leader>ct", "<cmd>ClaudeCodeFocus<cr>", { desc = "Toggle/focus Claude Code" })
keymap.set("n", "<leader>cc", "<cmd>ClaudeCode --continue<cr>", { desc = "Claude Code: continue last conversation" })
keymap.set("n", "<leader>cr", "<cmd>ClaudeCode --resume<cr>", { desc = "Claude Code: resume (pick conversation)" })
keymap.set("n", "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", { desc = "Claude Code: select model" })
keymap.set("n", "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Claude Code: add current buffer" })
keymap.set("v", "<leader>cv", "<cmd>ClaudeCodeSend<cr>", { desc = "Claude Code: send selection" })

-- in file trees <leader>cb adds the file under the cursor instead of the tree buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "NvimTree", "neo-tree", "oil", "minifiles" },
  callback = function(ev)
    keymap.set("n", "<leader>cb", "<cmd>ClaudeCodeTreeAdd<cr>", { buffer = ev.buf, desc = "Claude Code: add file" })
  end,
})

-- diff management (Claude's proposed edits open as diffs in nvim)
keymap.set("n", "<leader>cy", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Claude Code: accept diff" })
keymap.set("n", "<leader>cn", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Claude Code: deny diff" })
