return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<c-\>]], -- Mapping to open/close terminal with <C-\>
			terminal_mappings = true, -- Enable mappings in terminal mode
			dir = function()
				local buf_name = vim.api.nvim_buf_get_name(0)
				if buf_name ~= "" then
					local dir = vim.fn.fnamemodify(buf_name, ":h")
					if vim.fn.isdirectory(dir) == 1 then
						return dir
					end
				end
				return vim.fn.getcwd()
			end,
		})
	end,
}
