return {
	{
		"mason-org/mason.nvim",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			-- import mason
			local mason = require("mason")

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

			-- mason_lspconfig.setup({
			-- 	-- List of servers for mason to install
			-- 	ensure_installed = {},
			-- })

			mason_tool_installer.setup({
				ensure_installed = {
					--lsp servers
					"angular-language-server",
					"clangd",
					"csharp-language-server",
					"css-lsp",
					"emmet-language-server",
					"gopls",
					"harper-ls",
					"html-lsp",
					"json-lsp",
					"lua-language-server",
					"marksman",
					"powershell-editor-services",
					"basedpyright",
					"ruff",
					"rust-analyzer",
					"taplo",
					"typescript-language-server",
					-- tools
					-- { "eslint_d", version = "13.1.2" },
					"clang-format",
					"codelldb", -- Rust debugging
					"debugpy",
					"delve", -- Go debugging
					"goimports",
					"js-debug-adapter",
					"prettierd",
					"stylua",
				},
			})
		end,
	},
}
