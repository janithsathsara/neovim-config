--require("luasnip.session.snippet_collection").clear_snippets "javascriptreact"

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

-- Add these snippets only for JavaScript/JSX files
ls.add_snippets("javascriptreact", {

	-- useState snippet
	s(
		"usn",
		fmt(
			[[
    const [{}, set{}] = useState({});
  ]],
			{
				i(1, "state"),
				f(function(args)
					return (args[1][1]:gsub("^%l", string.upper))
				end, { 1 }),
				i(2, "initialValue"),
			}
		)
	),

	-- useEffect snippet
	s(
		"ue",
		fmt(
			[[
    useEffect(() => {{
      {}
    }}, [{}]);
  ]],
			{
				i(1, "// effect"),
				i(2, "dependencies"),
			}
		)
	),
})
