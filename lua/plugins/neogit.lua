return {
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			"folke/snacks.nvim", -- optional
		},
		config = function()
			require("neogit").setup()
		end,
		keys = {
			{ "<leader>gg", "<Cmd>Neogit<CR>", "n", desc = "Neogit open" },
			{
				"<leader>gc",
				"<Cmd>neogit commit<CR>",
				"n",
				desc = "Neogit commit",
			},
		},
	},
}
