--NOTE: zen mode

local isZenModeOn = false

function toggleZenMode()
	if isZenModeOn then
		vim.opt.laststatus = 2
		vim.opt.signcolumn = "yes"
	else
		vim.opt.laststatus = 0
		vim.opt.signcolumn = "no"
	end
	isZenModeOn = not isZenModeOn
end

vim.keymap.set("n", "<leader>uz", toggleZenMode, { desc = "Toggle zen Mode" })

--NOTE:Auto fold for a filetype
-- vim.api.nvim_create_autocmd("FileType",{
--     pattern = "markdown",
--     callback = function ()
--         vim.opt_local.foldlevel = 0
--     end,
-- })

--NOTE:commenting
-- function toggleComment()
-- 	local mode = vim.api.nvim_get_mode().mode
-- 	if mode == "n" then
-- 		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("gcc", true, false, true), "n", false)
-- 	elseif mode == "v" then
-- 		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("gc", true, false, true), "x", false)
-- 	else
-- 		return nil
-- 	end
-- end
--
-- vim.keymap.set({ "n", "v" }, "<leader>/", toggleComment, { desc = "Toggle comment" })
-- let key = nvim_replace_termcodes("<C-o>", v:true, v:false, v:true)
-- call nvim_feedkeys(key, 'n', v:false)

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

--NOTE:vim
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
