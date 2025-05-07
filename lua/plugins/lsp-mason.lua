return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		-- Require the necessary modules
		local lspconfig = require("lspconfig")
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		-- Setup Mason
		mason.setup()

		-- Setup Mason-LSPConfig with ensure_installed
		mason_lspconfig.setup({
			ensure_installed = {
				"rust_analyzer",
				"jsonls",
				"ast_grep",
				"grammarly",
				"jdtls",
				"jedi_language_server",
				"lua_ls"
			}
		})

		-- Define a function to attach the LSP to the buffer
		local on_attach = function(client, bufnr)
			local opts = { noremap = true, silent = true }
			local buf_set_keymap = vim.api.nvim_buf_set_keymap
			buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
			buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		end

		-- Explicitly setup each server
		lspconfig.rust_analyzer.setup({
			on_attach = on_attach,
		})

		lspconfig.jsonls.setup({
			on_attach = on_attach,
		})

		lspconfig.ast_grep.setup({
			on_attach = on_attach,
		})

		lspconfig.grammarly.setup({
			on_attach = on_attach,
		})

		lspconfig.jdtls.setup({
			on_attach = on_attach,
		})

		lspconfig.jedi_language_server.setup({
			on_attach = on_attach,
		})

		lspconfig.lua_ls.setup({
			on_attach = on_attach,
		})
	end,
}

