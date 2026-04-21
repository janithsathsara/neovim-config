return {
	{
		"NeogitOrg/neogit",
		lazy = true,
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local neogit = require("neogit")
			neogit.setup({
				disable_line_numbers = false,
				disable_relative_line_numbers = false,
				integrations = {
					diffview = true,
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
		},
	},
}
