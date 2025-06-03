return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"rafamadriz/friendly-snippets",
			{ "L3MON4D3/LuaSnip", version = "v2.*" },
		},
		---@module 'blink.cmp'
		opts = {
			fuzzy = {
				implementation = "lua",
				prebuilt_binaries = {
					download = true,
					-- force_version = "v1.0.0",
				},
			},
			keymap = {
				preset = "default",
				["<C-y>"] = { "select_and_accept" },

				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },

				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },

				["<C-n>"] = { "snippet_forward", "fallback" },
				["<C-p>"] = { "snippet_backward", "fallback" },
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			snippets = { preset = "luasnip" },
			sources = {
				default = { "lsp", "snippets", "path", "buffer" },
				per_filetype = {
					sql = { "snippets", "dadbod", "buffer" },
				},

				providers = {
					lsp = {
						name = "lsp",
						enabled = true,
						module = "blink.cmp.sources.lsp",
						score_offset = 100, -- the higher the number, the higher the priority
					},
					path = {
						name = "Path",
						module = "blink.cmp.sources.path",
						score_offset = 40,
						opts = {
							trailing_slash = false,
							label_trailing_slash = true,
							get_cwd = function(context)
								return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
							end,
							show_hidden_files_by_default = true,
						},
					},
					buffer = {
						name = "Buffer",
						module = "blink.cmp.sources.buffer",
						score_offset = 45,
					},
					snippets = {
						name = "snippets",
						module = "blink.cmp.sources.snippets",
						enabled = true,
						max_items = 8,
						min_keyword_length = 2,
						score_offset = 95,
					},
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				},
			},

			completion = {
				keyword = { range = "prefix" },
				menu = {
					auto_show = true,
				},
				documentation = { auto_show = true },
			},
			signature = {
				enabled = true,
				window = {
					show_documentation = true,
				},
			},

			cmdline = {
				enabled = true,
				completion = {
					menu = {
						auto_show = true,
					},
				},
				keymap = { preset = "inherit" },
			},
		},
		opts_extend = { "sources.default" },
	},
	{
		--I can add friendly snippets directly into blink. That is a bit hard, so luasnip can add them more easily as below
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Extend JavaScript files to also use Angular snippets
			require("luasnip").filetype_extend("jsonc", { "angular" })

			-- You might also want to extend TypeScript files
			require("luasnip").filetype_extend("typescript", { "angular" })

			-- And HTML files for Angular templates
			require("luasnip").filetype_extend("html", { "angular" })
		end,
	},
}
