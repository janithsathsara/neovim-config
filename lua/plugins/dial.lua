return {
	"monaqa/dial.nvim",
	lazy = true,
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			default = {
				augend.integer.alias.decimal,
				augend.integer.alias.hex,
				augend.constant.alias.bool,
				augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
				augend.constant.new({ elements = { "True", "False" }, word = true, cyclic = true }),
				augend.date.alias["%Y-%m-%d"],
				augend.date.alias["%Y/%m/%d"],
				augend.date.alias["%m/%d/%Y"],
				augend.constant.alias.en_weekday_full,
				augend.constant.alias.en_weekday,
				augend.constant.new({
					elements = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" },
					word = true,
					cyclic = true,
				}),
				augend.constant.new({
					elements = {
						"January",
						"February",
						"March",
						"April",
						"May",
						"June",
						"July",
						"August",
						"September",
						"October",
						"November",
						"December",
					},
					word = true,
					cyclic = true,
				}),

				augend.constant.new({ elements = { "AM", "PM" }, word = true, cyclic = true }),
				augend.semver.alias.semver,
				augend.hexcolor.new({ case = "lower" }),
			},
		})
	end,
	keys = {
		{
			"<C-a>",
			function()
				require("dial.map").manipulate("increment", "normal")
			end,
			mode = "n",
			desc = "Increment",
		},
		{
			"<C-x>",
			function()
				require("dial.map").manipulate("decrement", "normal")
			end,
			mode = "n",
			desc = "Decrement",
		},
		{
			"g<C-a>",
			function()
				require("dial.map").manipulate("increment", "gnormal")
			end,
			mode = "n",
			desc = "g Increment",
		},
		{
			"g<C-x>",
			function()
				require("dial.map").manipulate("decrement", "gnormal")
			end,
			mode = "n",
			desc = "g Decrement",
		},
		{
			"<C-a>",
			function()
				require("dial.map").manipulate("increment", "visual")
			end,
			mode = "x",
			desc = "Increment",
		},
		{
			"<C-x>",
			function()
				require("dial.map").manipulate("decrement", "visual")
			end,
			mode = "x",
			desc = "Increment",
		},
		{
			"g<C-a>",
			function()
				require("dial.map").manipulate("increment", "gvisual")
			end,
			mode = "x",
			desc = "Increment",
		},
		{
			"g<C-x>",
			function()
				require("dial.map").manipulate("decrement", "gvisual")
			end,
			mode = "x",
			desc = "Increment",
		},
	},
}
