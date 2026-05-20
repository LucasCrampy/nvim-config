local map = vim.keymap.set

-- 1. General Globals (Zero-delay and easy access)
map("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Write File (Save)" })
map("n", "<leader>q", ":q<CR>", { noremap = true, silent = true, desc = "Quit Window" })
map("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Explorer Sidebar" })
map("n", "<leader>n", "<cmd>NewFile<CR>", { noremap = true, silent = true, desc = "New File from Template" })
map("n", "<leader>z", "<cmd>ZenMode<CR>", { noremap = true, silent = true, desc = "Toggle Zen Mode" })

-- 2. Find Prefix (<leader>f) - Fuzzy Search
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true, desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true, desc = "Live Grep (Text Search)" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true, desc = "Open Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { noremap = true, silent = true, desc = "Help Tags" })

-- 3. Terminal & Git Prefix (<leader>t)
map("n", "<leader>tt", ":ToggleTerm<CR>", { noremap = true, silent = true, desc = "Toggle Terminal Window" })
map("n", "<leader>tg", ":LazyGit<CR>", { noremap = true, silent = true, desc = "Toggle LazyGit Terminal" })

-- 4. Code & LSP Prefix (<leader>c)
map("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code Actions" })
map("n", "<leader>cd", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Line Diagnostics Popup" })
map("n", "<leader>cf", function() require("conform").format({ async = true }) end, { noremap = true, silent = true, desc = "Format Buffer" })

-- 5. Math & Jupyter REPL Prefix (<leader>m)
map("n", "<leader>mi", ":MoltenInit<CR>", { noremap = true, silent = true, desc = "Initialize Molten REPL Kernel" })
map("n", "<leader>me", ":MoltenEvaluateOperator<CR>", { noremap = true, silent = true, desc = "Evaluate Line/Operator" })
map("v", "<leader>me", ":<C-u>MoltenEvaluateVisual<CR>gv", { noremap = true, silent = true, desc = "Evaluate Visual Selection" })
map("n", "<leader>mo", ":MoltenEnterOutput<CR>", { noremap = true, silent = true, desc = "Enter Output Window" })
map("n", "<leader>mh", ":MoltenHideOutput<CR>", { noremap = true, silent = true, desc = "Hide Output Window" })
map("n", "<leader>md", ":MoltenDelete<CR>", { noremap = true, silent = true, desc = "Delete Cell Output" })
map("n", "<leader>mg", "<cmd>MathGuide<CR>", { noremap = true, silent = true, desc = "Open Math Guide" })

-- 6. Profile & Theme Switcher Prefix (<leader>p)
map("n", "<leader>pp", "<cmd>Profile<CR>", { noremap = true, silent = true, desc = "Switch Profile" })
map("n", "<leader>pt", "<cmd>Theme<CR>", { noremap = true, silent = true, desc = "Select Theme Family" })

-- 7. Which-Key Group Registrations for discoverability
local wk_status, wk = pcall(require, "which-key")
if wk_status then
  wk.add({
    { "<leader>f", group = "[F]ind / Search" },
    { "<leader>t", group = "[T]erminal & Git" },
    { "<leader>c", group = "[C]ode / LSP" },
    { "<leader>m", group = "[M]ath & Jupyter REPL" },
    { "<leader>p", group = "[P]rofiles & Themes" },
  })
end

-- 8. Dynamic Spell check / Writing keymaps module
local M = {}

function M.setup_writing_keymaps()
  local opts = { noremap = true, silent = true }
  map("n", "<leader>st", ":set spell!<CR>", vim.tbl_extend("force", opts, { desc = "Toggle Spell Check" }))
  map("n", "<leader>sn", "]s", vim.tbl_extend("force", opts, { desc = "Next Spelling Error" }))
  map("n", "<leader>sp", "[s", vim.tbl_extend("force", opts, { desc = "Previous Spelling Error" }))
  map("n", "<leader>ss", "z=", vim.tbl_extend("force", opts, { desc = "Show Corrections Suggestions" }))
  map("n", "<leader>sa", "m'[s1z=`'", vim.tbl_extend("force", opts, { desc = "Auto-correct Last Error" }))

  if wk_status then
    wk.add({
      { "<leader>s", group = "[S]pellcheck & Writing" },
      { "<leader>st", desc = "Toggle Spell Check" },
      { "<leader>sn", desc = "Next Error" },
      { "<leader>sp", desc = "Previous Error" },
      { "<leader>ss", desc = "Show Corrections" },
      { "<leader>sa", desc = "Auto-correct Last" },
    })
  end
end

function M.clear_writing_keymaps()
  pcall(vim.keymap.del, "n", "<leader>st")
  pcall(vim.keymap.del, "n", "<leader>sn")
  pcall(vim.keymap.del, "n", "<leader>sp")
  pcall(vim.keymap.del, "n", "<leader>ss")
  pcall(vim.keymap.del, "n", "<leader>sa")

  if wk_status then
    wk.add({
      { "<leader>s", group = nil },
    })
  end
end

return M
