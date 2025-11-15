return {
	{
		"catppuccin/nvim",
		lazy = true,
		-- name = "catppuccin",
		-- priority = 1000,
		-- config = function()
		-- 	require("catppuccin").setup({
		-- 		flavour = "mocha", -- latte, frappe, macchiato, mocha
		-- 		transparent_background = true,
		-- 		highlight_overrides = {
		-- 			all = function(colors)
		-- 				return {
		-- 					LineNr = { fg = "#89dceb" },
		-- 					CursorLineNr = { fg = "#f38ba8" },
		-- 				}
		-- 			end,
		-- 		},
		-- 	})
		-- vim.cmd.colorscheme("catppuccin-mocha")
		-- end,
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

	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			-- Default options:
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
			vim.opt.background = "dark"
			vim.cmd("colorscheme gruvbox")
		end,
	},
}
