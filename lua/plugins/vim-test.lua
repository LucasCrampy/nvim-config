return {
	"vim-test/vim-test",
	config = function()
		function LazyGitToggleTerm()
			-- Open a terminal with ToggleTerm
			local Terminal = require("toggleterm.terminal").Terminal
			local term = Terminal:new({
				cmd = 'bash -c "lazygit"',
				direction = "float", -- You can change this to 'horizontal', 'vertical', or 'float'
				name = "lazygit",
				close_on_exit = false, -- Prevent the terminal from closing automatically
			})

			-- Run the terminal command
			term:toggle()
		end

		-- Define a function to compile, run and clean up Java files inside a terminal
		function CompileAndRunJavaToggleTerm()
			-- Check if the current file is a Java file
			if vim.bo.filetype ~= "java" then
				print("This is not a Java file.")
				return
			end

			-- Get the current file name without the extension
			local filename = vim.fn.expand("%:t:r")

			-- Open a terminal with ToggleTerm
			local Terminal = require("toggleterm.terminal").Terminal
			local term = Terminal:new({
				cmd = 'bash -c "javac ' .. filename .. ".java && java " .. filename .. '"',
				direction = "float", -- You can change this to 'horizontal', 'vertical', or 'float'
				name = "java-program",
				close_on_exit = false, -- Prevent the terminal from closing automatically
				on_exit = function(_, exit_code)
					if exit_code == 0 then
						print("Executed and cleaned up: " .. filename .. ".class")
					else
						print("Compilation or execution failed.")
					end
				end,
			})

			-- Run the terminal command
			term:toggle()
		end

		-- Create a custom command to run Java code
		vim.api.nvim_create_user_command("CompileAndRunJava", CompileAndRunJavaToggleTerm, {})
		vim.api.nvim_create_user_command("LazyGit", LazyGitToggleTerm, {})
	end,
}
