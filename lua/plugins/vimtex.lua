return {
	{
		"lervag/vimtex",
		lazy = false, -- Load vimtex fully
		init = function()
			-- Set the viewer to Skim
			vim.g.vimtex_view_method = 'skim'
			vim.g.vimtex_compiler_method = "latexmk"
		end,
	},
}
