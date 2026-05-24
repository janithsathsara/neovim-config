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
					require("fff").live_grep({ query = "TODO|WARN|HACK|FIX|NOTE", grep = { modes = { "regex" } } })
				end,
				"n",
				desc = "Find Todos",
			},
		},
	},
}
