return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<c-\>]], -- Mapping to open/close terminal with <C-\>
			terminal_mappings = true, -- Enable mappings in terminal mode
		})
	end,
}
