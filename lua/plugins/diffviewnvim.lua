return {
	"sindrets/diffview.nvim",
	lazy = true,
	config = true,
	keys = {
		{
			"<leader>gd",
			"<CMD>DiffviewFile<CR>",
			"n",
			desc = "Open diffview",
		},
		{
			"<leader>gD",
			"<CMD>DiffviewClose<CR>",
			"n",
			desc = "Close diffview",
		},
	},
}
