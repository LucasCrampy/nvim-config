return {
	'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts ={
		options = {
			icons_enabled = true,
			theme = 'auto',
			component_separators = { left = '', right = ''},
			section_separators = { left = '', right = ''},
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			}
		},
		sections = {
			lualine_a = {'mode'},
			lualine_b = { 'diff', 'diagnostics'},
			lualine_c = {
				'filename',
				{
					function()
						local profile = vim.g.current_profile or "Code"
						local icon = ""
						if profile == "Mathematics" then
							icon = ""
						elseif profile == "Writing" then
							icon = "󰏫"
						end
						return icon .. " " .. profile
					end,
					color = { gui = "bold" }
				}
			},
			lualine_x = {'filetype'},
			lualine_y = {'progress'},
			lualine_z = {'location'}
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {'filename'},
			lualine_x = {'location'},
			lualine_y = {},
			lualine_z = {}
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {}
	}

}
