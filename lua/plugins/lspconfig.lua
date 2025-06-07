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
		local lspconfig = require("lspconfig")

		local mason_lspconfig = require("mason-lspconfig")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "LSP declaration" }) -- go to declaration

				keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "LSP code actions" }) -- see available code actions, in visual mode will apply to selection

				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" }) -- smart rename

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

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.supports_method("textDocument/inlayHint") then
					vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
				end
			end,
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
								callSnippet = "Both",
							},
							hint = {
								enable = true,
								arrayIndex = "Auto",
								await = true,
								paramName = "All",
								paramType = true,
								semicolon = "SameLine",
								setType = true,
							},
						},
					},
				})
			end,
			["rust_analyzer"] = function()
				--     require("rust-tools").setup {}
				require("lspconfig").rust_analyzer.setup({
					settings = {
						["rust-analyzer"] = {
							inlayHints = {
								chainingHints = true,
								typeHints = true,
								parameterHints = true,
								maxLength = 25,
								enumVariant = true,
								-- parameterHints = {
								--   mode = "PlainText",
								-- },
							},
						},
					},
				})
			end,
			["clangd"] = function()
				require("lspconfig").clangd.setup({
					settings = {
						inlayHints = {
							Designators = true,
							Enabled = true,
							ParameterNames = true,
							DeducedTypes = true,
						},
					},
				})
			end,
			["angularls"] = function()
				lspconfig["angularls"].setup({
					root_dir = require("lspconfig.util").root_pattern("angular.json", "project.json", ".git"),
				})
			end,
			["gopls"] = function()
				require("lspconfig").gopls.setup({
					settings = {
						gopls = {
							hints = {
								rangeVariableTypes = true,
								parameterNames = true,
								constantValues = true,
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								functionTypeParameters = true,
							},
						},
					},
				})
			end,
			["ts_ls"] = function()
				require("lspconfig").ts_ls.setup({
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayVariableTypeHintsWhenTypeMatchesName = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				})
			end,
		})
	end,
}
