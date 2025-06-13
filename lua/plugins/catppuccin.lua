return {
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		-- priority = 1000,
		-- config = function()
		-- 	vim.cmd.colorscheme("catppuccin-mocha")
		-- end,
	},
	{
		"nobbmaestro/nvim-andromeda",
		dependencies = { "tjdevries/colorbuddy.nvim", branch = "dev" },
		lazy = true,
		name = modus,
		-- priority = 1000,
		-- config = function()
		-- 	require("andromeda").setup({})
		-- 	-- vim.cmd.colorscheme([[colorscheme modus_operandi]])
		-- end,
	},
	{

		"folke/tokyonight.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		priority = 1000,
		name = "tokyonight",
		opts = {},
		config = function()
			-- require("tokyonight.colors").setup({
			-- 	style = "night",
			-- })
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},
}
