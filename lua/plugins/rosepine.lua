return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			variant = auto,
			dark_variant = "moon"
		})
	end
}
