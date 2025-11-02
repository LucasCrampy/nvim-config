-- This file is for all your custom user commands.

-- Define a function to open LazyGit
local function LazyGitToggleTerm()
	local Terminal = require("toggleterm.terminal").Terminal
	local term = Terminal:new({
		cmd = 'bash -c "lazygit"',
		direction = "float",
		name = "lazygit",
		close_on_exit = false,
	})
	term:toggle()
end

-- Create the user commands that your keymaps will use
vim.api.nvim_create_user_command("LazyGit", LazyGitToggleTerm, {})
