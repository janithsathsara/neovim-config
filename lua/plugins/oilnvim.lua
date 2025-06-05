return {
	"stevearc/oil.nvim",
	lazy = true,
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
				natural_order = true,
				delete_to_trash = true,
			},
			columns = {
				"icon",
				"filename",
				"permissions",
				"size",
			},
		})
	end,
	keys = {
		{
			"<leader>e",
			"<CMD>Oil --float<CR>",
			"n",
			desc = "Open parent directory",
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
