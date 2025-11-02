return {
	"L3MON4D3/LuaSnip",
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "tex", "bib" },
		callback = function()
			-- Keymaps for expanding and jumping in snippets

			vim.cmd [[
            imap <silent><expr> jk luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : 'jk'
            smap <silent><expr> jk luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : 'jk'

            imap <silent><expr> wq luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : 'wq'
            smap <silent><expr> wq  luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : 'wq'

            " Cycle forward through choice nodes

            imap <silent><expr> <C-k> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-k>'
            smap <silent><expr> <C-k> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-k>'
            imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-l>'
            smap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-l>'
        ]]
		end
	})
}
