return {
	{
		"folke/todo-comments.nvim",
		lazy = true,
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		keys = {
			{
				"<leader>ft",
				function()
					require("tv").tv_channel("todo-comments")
				end,
				"n",
				desc = "Find todos",
			},
		},
	},
}
