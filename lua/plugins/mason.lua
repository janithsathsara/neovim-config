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
					"bash-language-server",
					"clangd",
					"csharp-language-server",
					"css-lsp",
					"emmet-language-server",
					"gopls",
					"harper-ls",
					"hyprls",
					"html-lsp",
					"json-lsp",
					"lua-language-server",
					"marksman",
					"basedpyright",
					"ruff",
					"rust-analyzer",
					"taplo",
					"tinymist",
					"typescript-language-server",
					"yaml-language-server",
					-- tools
					"eslint_d",
					"beautysh",
					"clang-format",
					"codelldb", -- Rust debugging
					"debugpy",
					"delve", -- Go debugging
					"goimports",
					"oxlint",
					"js-debug-adapter",
					"prettierd",
					"shellcheck", -- Bash linter
					"stylua",
					"typstyle",
				},
			})
		end,
	},
}
