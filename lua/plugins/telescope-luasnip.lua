return {
	"benfowler/telescope-luasnip.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		-- We need to tell telescope to load this extension
		require("telescope").load_extension("luasnip")
	end,
}
