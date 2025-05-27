return {
	"sindrets/diffview.nvim",
	event = "VeryLazy",
	config = function()
		require("diffview").setup({
			vim.keymap.set("n", "<leader>gd", "<CMD>DiffviewFile<CR>", { desc = "Open diffview" }),
			vim.keymap.set("n", "<leader>gD", "<CMD>DiffviewClose<CR>", { desc = "Close diffview" }),
		})
	end,
}
