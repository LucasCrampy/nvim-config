-- keys.lua: Simplified and grouped keybindings with descriptions
local map = vim.keymap.set -- THIS IS THE ONLY LINE THAT CHANGED

-- Basic File Management
map("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "[W]rite File" })
map("n", "<leader>q", ":q<CR>", { noremap = true, silent = true, desc = "[Q]uit Window" })
map("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "[E]xplorer (File Tree)" })

-- Group 1: <leader>f (Find)
-- 'which-key' will automatically create a "+[F]ind" menu for these
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true, desc = "[F]ind [F]iles" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true, desc = "[F]ind [G]rep (Text)" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true, desc = "[F]ind [B]uffers" })
map("n", "<leader>fh", "<cmd>TISCOCOPE help_tags<cr>", { noremap = true, silent = true, desc = "[F]ind [H]elp" })

-- Group 2: <leader>t (Terminal/Toggle)
-- 'which-key' will automatically create a "+[T]erminal / Toggles" menu
map("n", "<leader>tt", ":ToggleTerm<CR>", { noremap = true, silent = true, desc = "[T]oggle [T]erminal" })
map("n", "<leader>tg", ":LazyGit<CR>", { noremap = true, silent = true, desc = "[T]oggle [G]it (LazyGit)" })

-- Group 3: <leader>s (Spell Check)
-- 'which-key' will automatically create a "+[S]pell Check" menu
map("n", "<leader>st", ":set spell!<CR>", { noremap = true, silent = true, desc = "[T]oggle Spell Check" })
map("n", "<leader>sn", "]s", { noremap = true, silent = true, desc = "[N]ext Error" })
map("n", "<leader>sp", "[s", { noremap = true, silent = true, desc = "[P]revious Error" })
map("n", "<leader>ss", "z=", { noremap = true, silent = true, desc = "[S]uggestions" })
map("n", "<leader>sa", "m'[s1z=`'", { noremap = true, silent = true, desc = "[A]uto-correct Previous" })

-- Group 4: <leader>c (Code)
-- 'which-key' will automatically create a "+[C]ode" menu
map("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "[A]ction (LSP)" })

-- Completion keybinds (no change)
local insert_opts = { noremap = true, silent = true, expr = true }
map("i", "<C-b>", "v:lua.cmp.mapping.scroll_docs(-4)", insert_opts)
map("i", "<C-f>", "v:lua.cmp.mapping.scroll_docs(4)", insert_opts)
map("i", "<C-Space>", "v:lua.cmp.mapping.complete()", insert_opts)
map("i", "<C-e>", "v:lua.cmp.mapping.abort()", insert_opts)
map("i", "<CR>", "v:lua.cmp.mapping.confirm({ select = true })", insert_opts)
