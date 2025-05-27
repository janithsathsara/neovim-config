return {
	{
		"folke/todo-comments.nvim",
		event = "BufEnter",
		lazy = false,
		priority = 1000,
		opts = function()
			vim.keymap.set("n", "<leader>ft", "<Cmd>lua Snacks.picker.todo_comments()<CR>", { desc = "Find todos" })
		end,
	},
}
