return {
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim", --  Diff integration
			"folke/snacks.nvim",
		},
		config = function()
			local neogit = require("neogit")
			neogit.setup({
				disable_line_numbers = false,
				disable_relative_line_numbers = false,
				integrations = {
					diffview = true,
					snacks = true,
				},
			})
		end,
		keys = {
			{ "<leader>gg", "<Cmd>Neogit<CR>", "n", desc = "Neogit open" },
			{
				"<leader>gc",
				function()
					require("neogit").open({ "commit" })
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
