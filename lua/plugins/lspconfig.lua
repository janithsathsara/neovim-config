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

				keymap.set("n", "K", function()
					vim.lsp.buf.hover({ border = "rounded" })
				end, { desc = "Show documentation for what is under cursor" })

				keymap.set("n", "<leader>rs", "<CMD>LspRestart<CR>", { desc = "Restart LSP" })
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
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
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
		local function has_angular_root()
			local found = vim.fs.find("angular.json", { upward = true, vim.uv.cwd() })
			return #found > 0
		end

		vim.lsp.config("angularls", {
			-- cmd = cmd,
			cmd = {
				"ngserver",
				"--stdio",
				"--tsProbeLocations",
				"node_modules/typescript/lib",
				"--ngProbeLocations",
				"node_modules/@angular/language-service",
			},
		})
		if has_angular_root() then
			vim.lsp.enable("angularls")
		end
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
				"typescript",
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
			-- filetypes = { "markdown", "text" },
		})

		local isHarperEnabled = false

		function EnableHarper()
			if isHarperEnabled then
				local harper_clients = vim.lsp.get_clients({ name = "harper_ls" })
				for _, harper_client in ipairs(harper_clients) do
					vim.lsp.stop_client(harper_client.id)
				end
				isHarperEnabled = false
				print("harper disabled")
			else
				vim.lsp.enable("harper_ls")
				isHarperEnabled = true
				print("harper enabled")
			end
		end

		vim.keymap.set("n", "<leader>lh", function()
			EnableHarper()
		end, { desc = "Enable Harper" })

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
			filetypes = { "json", "jsonc" },
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

			vim.lsp.config("tinymist", {
				cmd = { "tinymist" },

				filetypes = { "typst" },
				settings = {
					formatterMode = "typstyle",
					inlayHints = {
						Designators = true,
						Enabled = true,
						ParameterNames = true,
						DeducedTypes = true,
					},
					exportPdf = "onType",

					semanticTokens = "disable",
				},
				linting = { enabled = true },
			}),
			vim.lsp.enable("tinymist"),

			-- Set up formatting via LSP for Typst files
			-- vim.api.nvim_create_autocmd("BufWritePre", {
			-- 	pattern = "*.typ",
			-- 	callback = function()
			-- 		vim.lsp.buf.format({ async = false })
			-- 	end,
			-- }),
		})
	end,
}
