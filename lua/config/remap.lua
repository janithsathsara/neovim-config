vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>q", "<Cmd>q<CR>", { desc = "Exit" })
vim.keymap.set("n", "<leader>w", "<Cmd>w<CR>", { desc = "Save" })

vim.keymap.set("n", "<leader>m", "GVgg")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

--NOTE:packages
vim.keymap.set("n", "<leader>pl", "<Cmd>Lazy<CR>")
vim.keymap.set("n", "<leader>pm", "<Cmd>Mason<CR>")

--NOTE:commenting
-- vim.keymap.set("n", "<leader>/",  function()
--             return require("Comment.api").call(
--               "toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
--               "g@$"
--             )()
--           end,{desc = "Toggle comment line"})
-- expr = true,
-- silent = true,
-- desc = "Toggle comment line",

-- maps.x["<Leader>/"] = {
--   "<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>",
--   desc = "Toggle comment",
-- }
