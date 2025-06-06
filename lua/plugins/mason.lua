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

			-- import mason LSP config
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
				-- List of servers for mason to install
				ensure_installed = {
					"clangd",
					"rust_analyzer",
					"emmet_language_server",
					"jsonls",
					"ts_ls",
					"html",
					"cssls",
					"gopls",
					"lua_ls",
					"marksman",
					"taplo",
					"angularls",
					"harper_ls",
					"pyright",
				},
			})

			mason_tool_installer.setup({
				ensure_installed = {
					-- "vale",
					"stylua",
					"prettierd",
					-- { "eslint_d", version = "13.1.2" },
					"goimports",
					"ruff",
					"clang-format",
					"js-debug-adapter",
					"debugpy",
					"codelldb", -- Rust debugging
					"delve", -- Go debugging
				},
			})
		end,
	},
}
