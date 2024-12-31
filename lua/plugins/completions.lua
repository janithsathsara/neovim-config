local LuaSnip_version = "v2.2.0"
return {
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"rafamadriz/friendly-snippets",
			{ "L3MON4D3/LuaSnip", version = LuaSnip_version },
		},
		version = "*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			fuzzy = {
				prebuilt_binaries = {
					force_version = "v0.8.2", -- This is important for downloading preebuilt libraries
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

			snippets = {
				expand = function(args)
					require("luasnip").lsp_expand(args)
				end,
				active = function(filter)
					if filter and filter.direction then
						return require("luasnip").jumpable(filter.direction)
					end
					return require("luasnip").in_snippet()
				end,
				jump = function(direction)
					require("luasnip").jump(direction)
				end,
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			sources = {
				default = { "lsp", "path", "luasnip", "buffer", "snippets" },
				providers = {
					lsp = {
						name = "lsp",
						enabled = true,
						module = "blink.cmp.sources.lsp",
						score_offset = 100, -- the higher the number, the higher the priority
					},
					luasnip = {
						name = "luasnip",
						enabled = true,
						async = true,
						module = "blink.cmp.sources.luasnip",
						score_offset = 90, -- the higher the number, the higher the priority
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
						name = "Snippets",
						module = "blink.cmp.sources.snippets",
						score_offset = 89,
					},
				},
			},

			completion = {
				keyword = { range = "prefix" },
				menu = {
					auto_show = true,
				},
				documentation = { auto_show = true },
			},
			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},
}
