local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("markdown", {
    s("mt", fmt("| {} | {} |\n{}", { i(1), i(2), i(0) })),
    s("mn", fmt("* [ ] {}", { i(1) })),
})
