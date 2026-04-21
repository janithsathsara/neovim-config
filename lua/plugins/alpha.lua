local function stats_footer()
	local stats = require("lazy").stats()
	local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
	return { string.format("⚡ Neovim loaded %d/%d plugins in %.2fms", stats.loaded, stats.count, ms) }
end

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
			"                                                     ",
			" ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ",
			" ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ",
			" ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ",
			" ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ",
			" ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ",
			" ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
			"                                                     ",
		}

		dashboard.section.buttons.val = {
			dashboard.button("t", "📺  TV channels", "<cmd>Tv<cr>"),
			dashboard.button("ff", "󰱼  Find files", "<cmd>Tv files<cr>"),
			dashboard.button("fw", "  Grep text", "<cmd>Tv text<cr>"),
			dashboard.button("fr", "󰁯  Recent files", "<cmd>Tv recent-files<cr>"),
			dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
		}

		dashboard.section.footer.val = stats_footer()
		alpha.setup(dashboard.opts)

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
