return {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    init = function()
        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_output_win_max_height = 20
    end,
    keys = {
        { "<leader>me", ":MoltenEvaluateOperator<CR>", desc = "[M]olten [E]valuate", silent = true },
        { "<leader>mi", ":MoltenInit<CR>", desc = "[M]olten [I]nitialize", silent = true },
    }
}
