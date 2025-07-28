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
		local keymap = vim.keymap

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function()
				keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "LSP declaration" })

				keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "LSP code actions" })

				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })

				keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show line diagnosis" })

				keymap.set(
					"n",
					"K",
					'<cmd>lua vim.lsp.buf.hover({ border = "rounded" })<cr>',
					{ desc = "Show documentation for what is under cursor" }
				)

				keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })
			end,
		})

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		vim.diagnostic.config({
			jump = { float = true },
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
				if client and client:supports_method("textDocument/inlayHint") then
					vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
				end
			end,
		})

		-- Lua
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Both",
					},
					hint = {
						enable = true,
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")

		-- Angular
		vim.lsp.config("angularls", {
			cmd = cmd,
		})
		vim.lsp.enable("angularls")

		-- C/C++
		vim.lsp.config("clangd", {
			settings = {
				inlayHints = {
					Designators = true,
					Enabled = true,
					ParameterNames = true,
					DeducedTypes = true,
				},
			},
		})
		vim.lsp.enable("clangd")

		vim.lsp.config("csharp_ls", {})
		vim.lsp.enable("csharp_ls")

		-- CSS
		vim.lsp.config("cssls", {
			settings = {
				inlayHints = {
					Enabled = true,
				},
			},
		})
		vim.lsp.enable("cssls")

		-- Emmet
		vim.lsp.config("emmet_language_server", {
			filetypes = {
				"css",
				"eruby",
				"html",
				"javascript",
				"javascriptreact",
				"less",
				"sass",
				"scss",
				"pug",
				"typescriptreact",
			},
		})
		vim.lsp.enable("emmet_language_server")

		-- Go
		vim.lsp.config("gopls", {
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
		vim.lsp.enable("gopls")

		-- Harper (Grammar/Spell checker)
		vim.lsp.config("harper_ls", {
			settings = {
				["harper-ls"] = {
					userDictPath = "~/.config/harper-ls/dict.txt",
				},
			},
			filetypes = { "markdown", "text" },
		})
		vim.lsp.enable("harper_ls")

		-- HTML
		vim.lsp.config("html", {
			filetypes = { "html", "templ" },
			settings = {
				inlayHints = { Enabled = true },
			},
		})
		vim.lsp.enable("html")

		-- JSON
		vim.lsp.config("jsonls", {
			settings = {
				json = {
					validate = { enable = true },
				},
			},
		})
		vim.lsp.enable("jsonls")

		-- Markdown
		vim.lsp.config("marksman", {})
		vim.lsp.enable("marksman")

		-- PowerShell
		vim.lsp.config("powershell_es", {
			bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
		})
		vim.lsp.enable("powershell_es")

		--ruff
		vim.lsp.config("ruff", {
			init_options = {
				settings = {
					hover = true,
				},
			},
		})
		vim.lsp.enable("ruff")

		--based pyright
		vim.lsp.config("basedpyright", {
			settings = {
				basedpyright = {
					disableOrganizeImports = true,
					analysis = {
						typeCheckingMode = "off",
					},
				},
				python = {
					analysis = {
						-- Ignore all files for analysis to exclusively use Ruff for linting
						ignore = { "*" },
					},
				},
			},
		})
		vim.lsp.enable("basedpyright")

		-- Rust
		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {
					inlayHints = {
						chainingHints = true,
						typeHints = true,
						parameterHints = true,
						maxLength = 25,
						enumVariant = true,
					},
				},
			},
		})
		vim.lsp.enable("rust_analyzer")

		-- TOML
		vim.lsp.config("taplo", {})
		vim.lsp.enable("taplo")

		vim.lsp.config("ts_ls", {
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
				javascript = {
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
			vim.lsp.enable("ts_ls"),

			vim.lsp.config("tailwindcss", {
				settings = {
					tailwindCSS = {
						classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
						lint = {
							cssConflict = "warning",
							invalidApply = "error",
							invalidConfigPath = "error",
							invalidScreen = "error",
							invalidTailwindDirective = "error",
							invalidVariant = "error",
							recommendedVariantOrder = "warning",
						},
						validate = true,
					},
				},
			}),
			vim.lsp.enable("tailwindcss"),
		})
	end,
}
