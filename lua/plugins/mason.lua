return {
	{

		"mason-org/mason.nvim",
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			-- import mason
			local mason = require("mason")

			-- import mason-lspconfig
			local mason_lspconfig = require("mason-lspconfig")

			local mason_tool_installer = require("mason-tool-installer")

			-- enable mason and configure icons
			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			mason_lspconfig.setup({
				-- list of servers for mason to install
				ensure_installed = {
					"rust_analyzer",
					"emmet_language_server",
					"jsonls",
					"ts_ls",
					"html",
					"cssls",
					"lua_ls",
					"pylsp",
					"marksman",
					"taplo",
					"angularls",
					"harper_ls",
				},
			})

			mason_tool_installer.setup({
				ensure_installed = {
					"stylua",
					"prettierd",
					"eslint_d",
					"ruff",
					"clang-format",
				},
			})
		end,
	},
}
