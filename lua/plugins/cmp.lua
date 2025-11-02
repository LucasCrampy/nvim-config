return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			-- ADD this line
			"saadparwaiz1/cmp_luasnip",
			-- REMOVE these two lines
			-- "hrsh7th/cmp-vsnip",
			-- "hrsh7th/vim-vsnip",
		},
		config = function()
			local cmp = require("cmp")
			local lspconfig = require("lspconfig")

			cmp.setup({
				snippet = {
					-- CHANGE this function
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					-- CHANGE this line
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})

			-- Set up cmdline sources
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
			})

			-- Set up LSP capabilities for all your installed servers
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Setup capabilities for each of your installed servers
			local servers = {
				"rust_analyzer",
				"jsonls",
				"ast_grep",
				"grammarly",
				"jdtls",
				"jedi_language_server",
				"lua_ls"
				-- We will add "texlab" in the next step
			}

			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
				})
			end
		end,
	},
}
