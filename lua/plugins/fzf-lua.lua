return {
	{
		"ibhagwan/fzf-lua",
		lazy = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "FzfLua",
		opts = {
			keymap = {
				fzf = {
					["ctrl-a"] = "select-all+accept",
					["ctrl-q"] = "accept",
				},
			},
		},
		keys = {
			{ "<leader>ff", "<cmd>FzfLua files<CR>", "n", desc = "find files" },
			{ "<leader>fg", "<cmd>FzfLua global<CR>", "n", desc = "find global" },
			{ "<leader>fw", "<cmd>FzfLua live_grep<CR>", "n", desc = "find grep word" },
			{ "<leader>sw", "<cmd>FzfLua grep_cword<CR>", "n", desc = "grep word under cursor" },
			{ "<leader>fr", "<cmd>FzfLua history<CR>", "n", desc = "recent files" },
			{ "<leader>fk", "<cmd>FzfLua keymaps<CR>", "n", desc = "keymaps" },
			{ "<leader>fh", "<cmd>FzfLua helptags<CR>", "n", desc = "helptags" },
			{ "<leader>fm", "<cmd>FzfLua manpages<CR>", "n", desc = "manpages" },
			{ "<leader>fb", "<cmd>FzfLua builtin<CR>", "n", desc = "builtin" },
		},
	},
}
