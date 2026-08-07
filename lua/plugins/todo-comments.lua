return {
	{
		"folke/todo-comments.nvim",
		lazy = true,
		cmd = {
			"Trouble todo",
			"TodoFzfLua",
		},
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		opts = {},
		keys = {
			{
				"<leader>ft",
				"<cmd>TodoFzfLua<CR>",
				"n",
				desc = "Find Todos",
			},
		},
	},
}
