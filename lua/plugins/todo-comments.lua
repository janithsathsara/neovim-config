return {
	{
		"folke/todo-comments.nvim",
        lazy = false,
        priority = 100,
		opts = function ()
          vim.keymap.set("n","<leader>ft","<Cmd>TodoTelescope<CR>", {desc = "Find todos"})
        end,
	},
}
