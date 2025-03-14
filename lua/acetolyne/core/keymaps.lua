vim.g.mapleader = " "

local keymap = vim.keymap

-- @todo below should change to NvimTree so we get the file list on the side instead of taking over the current buffer
--vim.keymap.set('n', '<leader>f', ':Explore<CR>', {
--    noremap = true,
--    desc = "Opens file explorer"
--  }) 

-- increment/decrement numbers
--keymap.set("n", "<leader>-", "<C-a>", { desc = "Increment number" }) -- increment
--keymap.set("n", "<leader>=", "<C-x>", { desc = "Decrement number" }) -- decrement

-- nvim tree mappings

keymap.set("n", "<leader>f", "<cmd>NvimTreeFocus<CR>", { desc = "Open and focus file tree" }) -- toggle file explorer
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
  vim.keymap.set('t', '<C-t>', [[<C-\><C-n>]], {buffer = 0, desc = "exit terminal mode"})
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], {buffer = 0, desc = "UNKNOWN"})
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], {buffer = 0, desc = "UNKNOWN"})
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], {buffer = 0, desc = "UNKNOWN"})
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], {buffer = 0, desc = "UNKNOWN"})
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], {buffer = 0, desc = "UNKNOWN"})
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], {buffer = 0, desc = "UNKNOWN"})
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- hotkey to format current file
vim.keymap.set('n', '<leader>fb', [[gg=G]], {desc = "format current buffer"}) -- lsp formatting
