local function stats_footer()
	local stats = require("lazy").stats()
	local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
	return { string.format("⚡ Neovim loaded %d/%d plugins in %.2fms", stats.loaded, stats.count, ms) }
end

local mocha = {
	teal = "#94e2d5",
	lavender = "#b4befe",
	base = "#cdd6f4",
	peach = "#fab387",
	maroon = "#eba0ac",
	red = "#f38ba8",
}

return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			" ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ",
			" ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ",
			" ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ",
			" ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ",
			" ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ",
			" ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
			"                                                     ",
		}

		dashboard.section.header.opts.hl = "AlphaHeader"

		dashboard.section.buttons.val = {
			dashboard.button("f", "󰱼  Find files", "<cmd>Tv files<cr>"),
			dashboard.button("w", "  Grep text", "<cmd>Tv text<cr>"),
			dashboard.button("r", "󰁯  Recent files", "<cmd>Tv recent-files<cr>"),
			dashboard.button("t", "  TV channels", "<cmd>Tv<cr>"),
			dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
		}

		dashboard.section.buttons.opts.hl = "AlphaButtons"

		dashboard.section.footer.val = stats_footer()
		dashboard.section.footer.opts.hl = "AlphaFooter"

		alpha.setup(dashboard.opts)

		vim.api.nvim_set_hl(0, "AlphaHeader", { fg = mocha.teal })
		vim.api.nvim_set_hl(0, "AlphaButtons", { fg = mocha.peach })
		vim.api.nvim_set_hl(0, "AlphaFooter", { fg = mocha.maroon })

		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			once = true,
			callback = function()
				dashboard.section.footer.val = stats_footer()
				pcall(vim.cmd.AlphaRedraw)
			end,
		})

		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}