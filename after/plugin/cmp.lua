
	local cmp = require("cmp")
	local lspkind = require('lspkind')
	vim.opt.completeopt = { "menu", "menuone", "noselect" }

	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				require'lspconfig'.gopls.setup{} --golang
			end,
		},
		window = {
			completion = {
				cmp.config.window.bordered(),
				border = "rounded",
				winhighlight = "Normal:CmpNormal",
			},
			documentation = {
				cmp.config.window.bordered(),
				winhighlight = "Normal:CmpDocNormal",
			}
		},
		mapping = cmp.mapping.preset.insert({
			["<CR>"] = cmp.mapping.confirm({ select = false }),
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
		}),
		sources = cmp.config.sources({
			{ name = 'cmp_tabnine' },
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "luasnip" }, -- For luasnip users.
			-- { name = "orgmode" },
		}, {
			{ name = "buffer" },
			{ name = "path" },
		}),
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
			  local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			  local strings = vim.split(kind.kind, "%s", { trimempty = true })
			  kind.kind = " " .. (strings[1] or "") .. " "
			  kind.menu = "    (" .. (strings[2] or "") .. ")"
		
			  return kind
			end,
		},
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})