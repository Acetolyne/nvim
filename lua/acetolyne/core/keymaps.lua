vim.g.mapleader = " "

local keymap = vim.keymap

-- @todo below should change to NvimTree so we get the file list on the side instead of taking over the current buffer
--vim.keymap.set('n', '<leader>f', ':Explore<CR>', {
--    noremap = true,
--    desc = "Opens file explorer"
--  }) 

-- increment/decrement numbers
keymap.set("n", "<leader>-", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>=", "<C-x>", { desc = "Decrement number" }) -- decrement

-- nvim tree mappings

keymap.set("n", "<leader>t", "<cmd>NvimTreeFocus<CR>", { desc = "Open and focus file tree" }) -- toggle file explorer
keymap.set("n", "<leader>tt", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree view" }) -- toggle file explorer
keymap.set("n", "<leader>tf", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
keymap.set("n", "<leader>tc", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
keymap.set("n", "<leader>tr", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

-- telescope mappings

keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })

-- find todo comments

keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

-- toggle visibility of kubectl ui

keymap.set("n", "<leader>k", '<cmd>lua require("kubectl").toggle()<cr>', { noremap = true, silent = true })

-- toggleterm
keymap.set("n", "<leader>ss", "<cmd>ToggleTerm<cr>", {desc = "Toggle visibility of shell buffer"})
keymap.set("n", "<leader>sa", "<cmd>ToggleTermToggleAll<cr>", {desc = "Toggle visibility of all shell buffers"})



-- toggle term keymaps for inside the terminal
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
