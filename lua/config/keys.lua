-- keys.lua: Custom keybindings for Neovim
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- File Explorer
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts) -- Toggle the file explorer

-- Telescope Keybindings
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts) -- Find files in the project
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts) -- Search text in files (live grep)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts) -- Switch between open buffers
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts) -- Access Neovim help tags

-- Save and Quit
map("n", "<leader>w", ":w<CR>", opts) -- Save the current file
map("n", "<leader>q", ":q<CR>", opts) -- Quit Neovim

-- Tab Management
map("n", "<leader>tn", ":tabnew<CR>", opts) -- Open a new tab
map("n", "<leader>tc", ":tabclose<CR>", opts) -- Close the current tab
map("n", "<leader>to", ":tabnext<CR>", opts) -- Switch to the next tab

-- Terminal Management
map("n", "<leader>t", ":ToggleTerm<CR>", opts) -- Open/close terminal

-- Java Compilation and Execution
map("n", "<leader>tr", ":CompileAndRunJava<CR>", opts) -- Compile and run Java code

map("n", "<leader>lg", ":LazyGit<CR>", opts) -- Compile and run Java code

-- nvim-cmp (Auto Completion)
map("i", "<C-b>", "v:lua.cmp.mapping.scroll_docs(-4)", { noremap = true, silent = true, expr = true }) -- Scroll documentation up
map("i", "<C-f>", "v:lua.cmp.mapping.scroll_docs(4)", { noremap = true, silent = true, expr = true }) -- Scroll documentation down
map("i", "<C-Space>", "v:lua.cmp.mapping.complete()", { noremap = true, silent = true, expr = true }) -- Trigger completion
map("i", "<C-e>", "v:lua.cmp.mapping.abort()", { noremap = true, silent = true, expr = true }) -- Abort completion
map("i", "<CR>", "v:lua.cmp.mapping.confirm({ select = true })", { noremap = true, silent = true, expr = true }) -- Confirm completion
