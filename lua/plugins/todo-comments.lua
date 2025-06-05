return {
	{
		"folke/todo-comments.nvim",
		lazy = true,
		opts = {},
		keys = {
			{
				"<leader>ft",
				"<Cmd>lua Snacks.picker.todo_comments()<CR>",
				"n",
				desc = "Find todos",
			},
		},
	},
}
