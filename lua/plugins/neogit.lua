return {
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			"folke/snacks.nvim", -- optional
		},
		config = function()
			require("neogit").setup()
		end,
		keys = {
			{ "<leader>gg", "<Cmd>Neogit<CR>", "n", desc = "Neogit open" },
			{
				"<leader>gc",
				function()
					neogit.open({ "commit" })
				end,
				"n",
				desc = "Neogit commit",
			},
			{
				"<leader>gl",
				"<CMD>Neogit log<CR>",
				"n",
				desc = "Neogit commit",
			},
		},
	},
}
