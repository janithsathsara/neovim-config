---@diagnostic disable: missing-fields
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import blink.cmp plugin

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				-- local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				-- keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP references" }) -- show definition, references

				keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "LSP declaration" }) -- go to declaration

				-- keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", { desc = "LSP definitions" }) -- show lsp definitions

				-- keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", { desc = "LSP implementations" }) -- show lsp implementations

				-- keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "LSP type definitions" }) -- show lsp type definitions

				keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "LSP code actions" }) -- see available code actions, in visual mode will apply to selection

				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" }) -- smart rename

				-- keymap.set("n", "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnosis" }) -- show  diagnostics for file

				keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show line diagnosis" }) -- show diagnostics for line

				keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" }) -- jump to previous diagnostic in buffer

				keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" }) -- jump to next diagnostic in buffer

				keymap.set(
					"n",
					"K",
					'<cmd>lua vim.lsp.buf.hover({ border = "rounded" })<cr>',
					{ desc = "Show documentation for what is under cursor" }
				) -- show documentation for what is under cursor

				keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" }) -- mapping to restart lsp if necessary
			end,
		})

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		vim.diagnostic.config({
			virtual_text = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = signs.Error,
					[vim.diagnostic.severity.WARN] = signs.Warn,
					[vim.diagnostic.severity.HINT] = signs.Hint,
					[vim.diagnostic.severity.INFO] = signs.Info,
				},
			},
		})
		mason_lspconfig.setup({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
			-- ["pylsp"] = function()
			-- 	lspconfig["pylsp"].setup({
			-- 		settings = {
			-- 			pylsp = {
			-- 				plugins = {
			-- 					pylsp_black = { enabled = false },
			-- 					pylsp_mypy = { enabled = false },
			-- 					pylsp_isort = { enabled = false },
			-- 					pyflakes = { enabled = false },
			-- 					autopep8 = { enabled = false },
			-- 					pycodestyle = { enabled = false },
			-- 					yapf = { enabled = false },
			-- 				},
			-- 			},
			-- 		},
			-- 	})
			-- end,
			["angularls"] = function()
				lspconfig["angularls"].setup({
					root_dir = require("lspconfig.util").root_pattern("angular.json", "project.json", ".git"),
				})
			end,
		})
	end,
}
