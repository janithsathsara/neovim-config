return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		main = "ibl",
		config = function()
			require("ibl").setup({
				indent = {
					highlight = "IblIndent",
				},
				scope = {
					enabled = true,
					show_start = true,
					show_end = false,
					highlight = "IblScope",
					include = {
						node_type = {
							["*"] = {
								"arguments",
								"argument_list",
								"block",
								"bracket",
								"declaration",
								"field",
								"formal_parameters",
								"function",
								"function_definition",
								"if_statement",
								"for_statement",
								"while_statement",
								"repeat_statement",
								"do_statement",
								"switch_statement",
								"case_statement",
								"try_statement",
								"catch_clause",
								"import",
								"list",
								"method",
								"object",
								"operation",
								"parameter",
								"parameters",
								"statement_block",
								"subscript",
								"table",
								"type",
								"var",
								"array",
								"jsx_element",
								"jsx_fragment",
							},
						},
					},
				},
			})
		end,
	},
}
