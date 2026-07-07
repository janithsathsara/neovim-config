return {
	"dlyongemallo/diffview-plus.nvim",
	lazy = true,
	version = "*",
	config = true,
	cmd = {
		"DiffviewOpen",
		"DiffviewToggle",
		"DiffviewFileHistory",
		"DiffviewDiffFiles",
		"DiffviewLog",
	},
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
