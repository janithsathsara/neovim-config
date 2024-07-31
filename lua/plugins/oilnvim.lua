return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			view_options = {
            				show_hidden = true,
				natural_order = true,
				delete_to_trash = true,
			},
			vim.keymap.set("n", "<leader>e", "<CMD>Oil --float<CR>", { desc = "Open parent directory" }),
		})
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
