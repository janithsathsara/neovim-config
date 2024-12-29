-- Set up an autocmd to update the window title whenever the buffer changes
vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost", "VimEnter" }, {
    callback = function()
        local file_name = vim.fn.expand('%:t')
        -- If no file is open, show "nvim"
        if file_name == '' then
            vim.o.titlestring = 'nvim'
        else
            -- You can customize this format
            vim.o.titlestring = string.format(file_name)
        end
    end,
})

-- Enable title setting
vim.o.title = true
