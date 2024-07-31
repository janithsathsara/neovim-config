return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Add to harpoon list" })
		vim.keymap.set("n", "<C-q>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle menu" })

		vim.keymap.set("n", "<C-h>", function()
			harpoon:list():select(1)
		end, { desc = "Select 1 from harpoon menu" })
		vim.keymap.set("n", "<C-g>", function()
			harpoon:list():select(2)
		end, { desc = "Select 2 from harpoon menu" })
		vim.keymap.set("n", "<C-c>", function()
			harpoon:list():select(3)
		end, { desc = "Select 3 from harpoon menu" })
		vim.keymap.set("n", "<C-n>", function()
			harpoon:list():select(4)
		end, { desc = "Select 4 from harpoon menu" })
		vim.keymap.set("n", "<leader><C-h>", function()
			harpoon:list():replace_at(1)
		end, { desc = "Replace the file at position 1" })
		vim.keymap.set("n", "<leader><C-g>", function()
			harpoon:list():replace_at(2)
		end, { desc = "Replace the file at position 2" })
		vim.keymap.set("n", "<leader><C-c>", function()
			harpoon:list():replace_at(3)
		end, { desc = "Replace the file at position 3" })
		vim.keymap.set("n", "<leader><C-n>", function()
			harpoon:list():replace_at(4)
		end, { desc = "Replace the file at position 4" })
	end,
}
