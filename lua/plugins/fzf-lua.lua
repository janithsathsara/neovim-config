return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		-- lazy = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "FzfLua",
		-- or if using mini.icons/mini.nvim
		-- dependencies = { "nvim-mini/mini.icons" },
		---@module "fzf-lua"
		---@type fzf-lua.Config|{}
		---@diagnostic disable: missing-fields
		---@diagnostic enable: missing-fields
		keys = {
			{ "<leader>ff", "<cmd>FzfLua files<CR>", desc = "find files" },
			{ "<leader>fw", "<cmd>FzfLua grep<CR>", desc = "find files" },
			{ "<leader>sw", "<cmd>FzfLua grep_cword<CR>", desc = "grep word under cursor" },
			{ "<leader>fr", "<cmd>FzfLua history<CR>", desc = "recent files" },
			{ "<leader>fk", "<cmd>FzfLua keymaps<CR>", desc = "recent files" },
			{ "<leader>fh", "<cmd>FzfLua helptags<CR>", desc = "recent files" },
		},
	},
}
