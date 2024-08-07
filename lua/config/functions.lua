-- -- Function to close all buffers and show the greeter
-- local function close_all_buffers_and_show_greeter()
--     for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
--         vim.api.nvim_buf_delete(bufnr, { force = true })
--     end
--     -- Assuming you are using a plugin like 'alpha-nvim' for the greeter
--     vim.cmd("Alpha")
-- end
--
-- -- Key mapping to close all buffers and show the greeter
-- vim.api.nvim_set_keymap('n', '<leader>C', '<cmd>lua close_all_buffers_and_show_greeter()<CR>',
--     { noremap = true, silent = true })

-- Function to close the current buffer and open Alpha if it's the last buffer
-- local function close_buffer_and_show_greeter()
--     local listed_buffers = vim.fn.getbufinfo({ buflisted = 1 })
--     if #listed_buffers == 1 then
--         -- Close the current buffer and open Alpha
--         vim.cmd('bdelete')
--         vim.cmd('Alpha')
--     else
--         -- Close the current buffer only
--         vim.cmd('bdelete')
--     end
-- end
--
-- -- Key mapping to close the current buffer and possibly show the greeter
-- vim.keymap.set('n', '<leader>c', close_buffer_and_show_greeter,
--     { desc = "close current buffer and show greeter if last buffer" })


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





--NOTE:vim
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- asldkjfalsj lkasdkjflas jdt
-- adskjflasdjfla llasdj flasdj
