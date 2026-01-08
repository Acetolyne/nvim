-- Disable unused providers early to improve startup and prevent freezing
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

require("acetolyne.core.options")

require("acetolyne.core.keymaps")

-- Setup safe clipboard with timeout protection
require("acetolyne.core.clipboard").setup()
