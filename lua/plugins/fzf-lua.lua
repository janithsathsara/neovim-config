return {
	{
		"ibhagwan/fzf-lua",
		lazy = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "FzfLua",
		keys = {
			{ "<leader>ff", "<cmd>FzfLua files<CR>", "n", desc = "find files" },
			{ "<leader>fw", "<cmd>FzfLua grep<CR>", "n", desc = "find files" },
			{ "<leader>sw", "<cmd>FzfLua grep_cword<CR>", "n", desc = "grep word under cursor" },
			{ "<leader>fr", "<cmd>FzfLua history<CR>", "n", desc = "recent files" },
			{ "<leader>fk", "<cmd>FzfLua keymaps<CR>", "n", desc = "recent files" },
			{ "<leader>fh", "<cmd>FzfLua helptags<CR>", "n", desc = "recent files" },
		},
	},
}
