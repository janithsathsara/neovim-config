-- local ls = require("luasnip")

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/config/snippets/*.lua", true)) do
	loadfile(ft_path)()
end

-- In your main config file, replace the immediate require with:
-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "LazyLoad",
-- 	callback = function(event)
-- 		if event.data == "LuaSnip" then
-- 			local ls = require("luasnip")
-- 			for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/config/snippets/*.lua", true)) do
-- 				loadfile(ft_path)()
-- 			end
-- 		end
-- 	end,
-- })
