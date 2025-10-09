return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-mocha")

			--NOTE: line number colors
			-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#cdd6f4", bg = "NONE" })
			-- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#cdd6f4", bg = "NONE", bold = true })
			--NOTE: background transparent

			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				transparent_background = true,
				mocha = {
					highlight_overrides = {
						LineNr = { fg = "#cdd6f4" },
						CursorLineNr = { fg = "#cdd6f4" },
					},
				},
			})
		end,
	},

	{

		"folke/tokyonight.nvim",
		lazy = true,
		-- priority = 1000,
		-- name = "tokyonight",
		-- opts = {},
		-- config = function()
		-- 	require("tokyonight").setup({
		-- 		style = "night",
		-- 		transparent = false,
		-- 		on_highlights = function(hl, colors)
		-- 			--NOTE: line number colors
		-- 			hl.LineNr = { fg = "#cdd6f4" } -- Bright yellow
		-- 			hl.CursorLineNr = { fg = colors.orange } -- Use theme's orange
		-- 			hl.LineNrAbove = { fg = "#cdd6f4" } -- Blue for lines above cursor
		-- 			hl.LineNrBelow = { fg = "#cdd6f4" } -- Pink for lines below cursor
		-- 		end,
		-- 	})
		-- 	vim.cmd.colorscheme("tokyonight-night")
		-- 	vim.api.nvim_set_hl(0, "LineNr", { fg = "#cdd6f4", bg = "NONE" })
		-- 	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#cdd6f4", bg = "NONE", bold = true })
		-- end,
	},
}
