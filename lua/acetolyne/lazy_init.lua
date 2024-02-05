local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = "acetolyne.lazy",
    change_detection = { notify = false },

	{
		"trunk-io/neovim-trunk",
		lazy = false,
		-- optionally pin the version
		-- tag = "v0.1.1",
		-- these are optional config arguments (defaults shown)
		opts = {
			trunkPath = "trunk",
			-- lspArgs = {},
			-- formatOnSave = true,
                        -- formatOnSaveTimeout = 10, -- seconds
			logLevel = "info"
		},
		main = "trunk",
		dependencies = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"}
	},
	{
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
          "nvim-tree/nvim-web-devicons",
        },
    },
})

--setup flowcat autocmd
vim.api.nvim_create_autocmd('BufWritePre', {
	-- run Flowcat after saving files
	pattern = {"*"},
	callback = function()
		local dir = vim.fn.getcwd()
		local args = [[flowcat -l -f {dir} -o {dir}/todo]]
		args = args:gsub('{dir}',dir)
		args = [[flowcat -l]]
		--   vim.fn.jobstart({"flowcat", "-l", "-o", "todo"}, {
		--     stdout_buffered = true,
		--     --on_stderr = function(_, data)
		--       --if data then
		--         --print("yo")
		--         --print(data)
		--       --end
		--     --end,
		--   })
		vim.fn.system('flowcat -l -f ' .. dir .. ' -o ' .. dir .. '/todo')
	end,
})
--[[
require("lazy").setup({
  use("~/personal/harpoon")

  use("theprimeagen/vim-be-good")
  use("theprimeagen/refactoring.nvim")
  --use("nvim-treesitter/nvim-treesitter-context");

  use {
	  "VonHeikemen/lsp-zero.nvim",
	  branch = "v1.x",
	  requires = {
		  -- LSP Support
		  {"neovim/nvim-lspconfig"},
		  {"williamboman/mason.nvim"},
		  {"williamboman/mason-lspconfig.nvim"},

		  -- Autocompletion
		  {"hrsh7th/nvim-cmp"},
		  {"hrsh7th/cmp-buffer"},
		  {"hrsh7th/cmp-path"},
		  {"saadparwaiz1/cmp_luasnip"},
		  {"hrsh7th/cmp-nvim-lsp"},
		  {"hrsh7th/cmp-nvim-lua"},

		  -- Snippets
		  {"L3MON4D3/LuaSnip"},
		  {"rafamadriz/friendly-snippets"},
	  }
  }

}, {})

--]]
