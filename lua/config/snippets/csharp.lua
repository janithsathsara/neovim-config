-- require("luasnip.session.snippet_collection").clear_snippets("elixir")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("cs", {
	s("cproperty", fmt("public {} {} {{get; set;}}", { i(1, "Type"), i(2) })),
	s(
		"cclass",
		fmt(
			[[public class {} {{
                public {}() {{
                    {}
                }}
    
                {}
            }}]],
			{
				i(1, "ClassName"),
				rep(1), -- Repeats the first input (class name) in constructor
				i(2), -- Cursor position for constructor body
				i(3), -- Cursor position for class members)),
			}
		)
	),
})
