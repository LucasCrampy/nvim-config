return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },

  config = function()
    -- Require the necessary modules
    local lspc = require("lspconfig")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    -- Setup Mason
    mason.setup()

    -- Setup Mason-LSPConfig
    mason_lspconfig.setup()

    -- Define a function to attach the LSP to the buffer
    local on_attach = function(client, bufnr)
      -- Set up buffer-local keybindings, etc.
      local opts = { noremap = true, silent = true }
      local buf_set_keymap = vim.api.nvim_buf_set_keymap
      buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
      buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      -- Add other keymaps as needed
    end

    -- Setup handlers for each LSP server
    mason_lspconfig.setup_handlers {
      function(server_name)
        lspc[server_name].setup {
          on_attach = on_attach, -- Ensure the LSP is attached to the buffer
        }
      end,
    }
  end,
}
