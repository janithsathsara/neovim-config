return {
	"ThePrimeagen/harpoon",
	lazy = true,
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("harpoon"):setup()
	end,
	keys = {
		{
			"<leader>a",
			function()
				require("harpoon"):list():add()
			end,
			"n",
			desc = "Add to harpoon list",
		},
		{
			"<C-q>",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			"n",
			desc = "Toggle menu",
		},
		{
			"<C-h>",
			function()
				require("harpoon"):list():select(1)
			end,
			"n",
			desc = "Select 1 from harpoon menu",
		},
		{
			"<C-g>",
			function()
				require("harpoon"):list():select(2)
			end,
			"n",
			desc = "Select 2 from harpoon menu",
		},
		{
			"<C-c>",
			function()
				require("harpoon"):list():select(3)
			end,
			"n",
			desc = "Select 3 from harpoon menu",
		},
		{
			"<C-n>",
			function()
				require("harpoon"):list():select(4)
			end,
			"n",
			desc = "Select 4 from harpoon menu",
		},
		{
			"<leader><C-h>",
			function()
				require("harpoon"):list():replace_at(1)
			end,
			"n",
			desc = "Replace the file at position 1",
		},
		{
			"<leader><C-g>",
			function()
				require("harpoon"):list():replace_at(2)
			end,
			"n",
			desc = "Replace the file at position 2",
		},
		{
			"<leader><C-c>",
			function()
				require("harpoon"):list():replace_at(3)
			end,
			"n",
			desc = "Replace the file at position 3",
		},
		{
			"<leader><C-n>",
			function()
				require("harpoon"):list():replace_at(4)
			end,
			"n",
			desc = "Replace the file at position 4",
		},
	},
}
