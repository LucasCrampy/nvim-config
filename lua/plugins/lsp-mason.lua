return {
	"neovim/nvim-lspconfig",

	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {
				ensure_installed = {
					"rust_analyzer",
					"jsonls",
					"ast_grep",
					"grammarly",
					-- "jdtls", -- Removed
					"jedi_language_server",
					"lua_ls",
					"texlab",
				},
				automatic_enable = true,
			},
		},
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local on_attach = function(client, bufnr)
			local opts = { noremap = true, silent = true }
			local buf_set_keymap = vim.api.nvim_buf_set_keymap
			buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
			buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		end

		-- Set global defaults
		vim.lsp.config("global", {
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
}
