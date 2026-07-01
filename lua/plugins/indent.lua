return {
	{
		"saghen/blink.indent",
		lazy = true,
		--- @module 'blink.indent'
		--- @type blink.indent.Config
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			require("blink.indent").setup({
				-- filetypes where scopes are closed by dedenting, such as python and yaml
				-- set to true to treat all filetypes this way
				dedent_scoped_filetypes = { include_defaults = true },
				blocked = {
					-- default: 'terminal', 'quickfix', 'nofile', 'prompt'
					buftypes = { include_defaults = true },
					-- default: 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'gitcommit', 'dashboard', ''
					filetypes = { include_defaults = true },
				},
				mappings = {
					-- which lines around the scope are included for 'ai': 'top', 'bottom', 'both', or 'none'
					border = "both",
					-- set to '' to disable
					-- textobjects (e.g. `y2ii` to yank current and outer scope)
					object_scope = "ii",
					object_scope_with_border = "ai",
					-- motions
					goto_top = "[i",
					goto_bottom = "]i",
				},
				static = {
					enabled = true,
					char = "▎",
					whitespace_char = nil, -- inherits from `vim.opt.listchars:get().space` when `nil` (see `:h listchars`)
					priority = 1,
					-- specify multiple highlights here for rainbow-style indent guides
					-- highlights = { 'BlinkIndentRed', 'BlinkIndentOrange', 'BlinkIndentYellow', 'BlinkIndentGreen', 'BlinkIndentViolet', 'BlinkIndentCyan' },
					highlights = { "BlinkIndent" },
				},
				scope = {
					enabled = true, -- highlight highest level of indentation on the current line
					indent_at_cursor = false, -- clamp to indent level of cursor
					char = "▎",
					priority = 1000,
					-- set this to a single highlight, such as 'BlinkIndent' to disable rainbow-style indent guides
					-- highlights = { 'BlinkIndentScope' },
					-- optionally add: 'BlinkIndentRed', 'BlinkIndentCyan', 'BlinkIndentYellow', 'BlinkIndentGreen'
					highlights = { "BlinkIndentOrange", "BlinkIndentViolet", "BlinkIndentBlue" },
					-- enable to show underlines on the line above the current scope
					underline = {
						enabled = false,
						-- optionally add: 'BlinkIndentRedUnderline', 'BlinkIndentCyanUnderline', 'BlinkIndentYellowUnderline', 'BlinkIndentGreenUnderline'
						highlights = { "BlinkIndentOrangeUnderline", "BlinkIndentVioletUnderline", "BlinkIndentBlueUnderline" },
					},
				},
			})
		end,
		opts = {},
	},
	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	event = {
	-- 		"BufReadPre",
	-- 		"BufNewFile",
	-- 	},
	-- 	main = "ibl",
	-- 	config = function()
	-- 		require("ibl").setup({
	-- 			indent = {
	-- 				highlight = "IblIndent",
	-- 			},
	-- 			scope = {
	-- 				enabled = true,
	-- 				show_start = true,
	-- 				show_end = false,
	-- 				highlight = "IblScope",
	-- 				include = {
	-- 					node_type = {
	-- 						["*"] = {
	-- 							"arguments",
	-- 							"argument_list",
	-- 							"block",
	-- 							"bracket",
	-- 							"declaration",
	-- 							"field",
	-- 							"formal_parameters",
	-- 							"function",
	-- 							"function_definition",
	-- 							"if_statement",
	-- 							"for_statement",
	-- 							"while_statement",
	-- 							"repeat_statement",
	-- 							"do_statement",
	-- 							"switch_statement",
	-- 							"case_statement",
	-- 							"try_statement",
	-- 							"catch_clause",
	-- 							"import",
	-- 							"list",
	-- 							"method",
	-- 							"object",
	-- 							"operation",
	-- 							"parameter",
	-- 							"parameters",
	-- 							"statement_block",
	-- 							"subscript",
	-- 							"table",
	-- 							"type",
	-- 							"var",
	-- 							"array",
	-- 							"jsx_element",
	-- 							"jsx_fragment",
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
