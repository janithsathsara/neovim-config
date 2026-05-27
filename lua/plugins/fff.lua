return {
	{
		"dmtrKovalenko/fff.nvim",
		lazy = true,
		build = function()
			-- downloads a prebuilt binary or falls back to cargo build
			require("fff.download").download_or_build_binary()
		end,
		opts = {
			layout = { prompt_position = "top" },
			debug = {
				enabled = true,
				show_scores = true,
			},
			keymaps = {
				move_up = { "<C-k>" },
				move_down = { "<C-j>" },
			},
		},
		keys = {
			{
				"<leader>ff",
				function()
					require("fff").find_files()
				end,
				desc = "FFFind files",
			},
			{
				"<leader>fg",
				function()
					require("fff").live_grep()
				end,
				desc = "LiFFFe grep",
			},
			{
				"<leader>fz",
				function()
					require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } })
				end,
				desc = "Live fffuzy grep",
			},
			{
				"<leader>sw",
				function()
					require("fff").live_grep({ query = vim.fn.expand("<cword>") })
				end,
				desc = "Search current word",
			},
			{
				"<leader>ft",
				function()
					require("fff").live_grep({ query = "TODO|WARN|HACK|FIX|NOTE", grep = { modes = { "regex" } } })
				end,
				"n",
				desc = "Find Todos",
			},
		},
	},
	{
		dir = vim.fn.stdpath("config"),
		lazy = true,
		keys = {
			{
				"<leader>fr",
				function()
					require("config.fff_extra").recent_files()
				end,
				desc = "FFF recent files",
			},
			{
				"<leader>fk",
				function()
					require("config.fff_extra").keymaps()
				end,
				desc = "FFF keymaps",
			},
			{
				"<leader>fh",
				function()
					require("config.fff_extra").help()
				end,
				desc = "FFF help tags",
			},
		},
	},
}
