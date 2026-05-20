return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
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

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"rust_analyzer",
				"jsonls",
				"ast_grep",
				"lua_ls",
				"texlab",
				"pyright",     -- Python Data Science
				"matlab_ls",   -- MATLAB support
				"ltex",        -- Offline Grammar checker
			},
		})

		-- In Neovim 0.11+, set global configuration options natively.
		vim.lsp.config("global", {
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
}
