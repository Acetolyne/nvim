return {
  "neovim/nvim-lspconfig",
  priority = 1000,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- Optimize LSP performance
    vim.lsp.log.set_level("WARN") -- Reduce logging
    
    -- Debounce LSP requests
    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded"
      opts.max_width = opts.max_width or 80
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings, registered with which-key.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local wk = require("which-key")

        wk.add({
          buffer = ev.buf,
          silent = true,

          { "<leader>l", group = "LSP" },
          { "<leader>lr", "<cmd>Telescope lsp_references<CR>", desc = "Show LSP references" },
          { "<leader>lD", vim.lsp.buf.declaration, desc = "Go to declaration" },
          { "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", desc = "Show LSP definitions" },
          { "<leader>li", "<cmd>Telescope lsp_implementations<CR>", desc = "Show LSP implementations" },
          { "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", desc = "Show LSP type definitions" },

          -- in visual mode code actions apply to the selection
          { "<leader>ca", vim.lsp.buf.code_action, desc = "See available code actions", mode = { "n", "v" } },
          { "<leader>rn", vim.lsp.buf.rename, desc = "Smart rename" },
          { "<leader>rs", "<cmd>LspRestart<CR>", desc = "Restart LSP" },

          { "<leader>db", "<cmd>Telescope diagnostics bufnr=0<CR>", desc = "Show buffer diagnostics" },
          { "<leader>dl", vim.diagnostic.open_float, desc = "Show line diagnostics" },
          { "[d", vim.diagnostic.goto_prev, desc = "Go to previous diagnostic" },
          { "]d", vim.diagnostic.goto_next, desc = "Go to next diagnostic" },

          { "K", vim.lsp.buf.hover, desc = "Show documentation for what is under cursor" },
        })
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    vim.lsp.config("*", { capabilities = capabilities })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = { globals = { "vim" } },
          completion = { callSnippet = "Replace" },
        },
      },
    })
  end,
}
