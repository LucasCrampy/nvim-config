return {
	-- 1. The Snippet Engine
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		config = function()
			local luasnip = require("luasnip")

			-- This is the NEW path, pointing to your local folder
			local snippet_path = vim.fn.stdpath("config") .. "/lua/snippets"
			require("luasnip.loaders.from_lua").load({ paths = { snippet_path } })

			-- Keymaps for expanding and jumping in snippets
			vim.keymap.set({ "i", "s" }, "jk", function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "wq", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { silent = true })

			-- Keymaps for cycling through choice nodes
			vim.keymap.set({ "i", "s" }, "<C-j>", function()
				if luasnip.choice_active() then
					luasnip.change_choice(1)
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-k>", function()
				if luasnip.choice_active() then
					luasnip.change_choice(-1)
				end
			end, { silent = true })
		end,
	},

	-- 2. The Bridge between nvim-cmp and luasnip
	{
		"saadparwaiz1/cmp_luasnip",
	},
}
