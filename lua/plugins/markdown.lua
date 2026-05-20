return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master", -- Pin to backward compatible master branch
		build = ":TSUpdate",
		config = function()
			local ok, configs = pcall(require, "nvim-treesitter.configs")
			if ok then
				configs.setup({
					ensure_installed = { "markdown", "markdown_inline", "lua", "python", "vim", "vimdoc" },
					highlight = { enable = true },
				})
			end
		end
	},
}
