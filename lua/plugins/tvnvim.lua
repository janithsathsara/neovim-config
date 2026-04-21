local function tv_binary()
	local ok, tv = pcall(require, "tv")
	if ok and tv and tv.config and tv.config.current and tv.config.current.tv_binary then
		return tv.config.current.tv_binary
	end
	return "tv"
end

local function open_tv_channels()
	require("tv").tv_channels()
end

local function direct_tv(channel)
	require("tv").tv_channel(channel)
end

local function launch_lines(lines, opts, on_select)
	opts = opts or {}

	if not lines or #lines == 0 then
		vim.notify(opts.empty_message or "No results", vim.log.levels.WARN, { title = opts.title or "tv.nvim" })
		return
	end

	local binary = tv_binary()
	if vim.fn.executable(binary) ~= 1 then
		vim.notify("tv binary not found: " .. binary, vim.log.levels.ERROR, { title = "tv.nvim" })
		return
	end

	local tmp = vim.fn.tempname()
	vim.fn.writefile(lines, tmp)

	local buf = vim.api.nvim_create_buf(false, true)
	local width = math.max(70, math.floor(vim.o.columns * 0.85))
	local height = math.max(12, math.floor(vim.o.lines * 0.75))
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		style = "minimal",
		border = "rounded",
		width = width,
		height = height,
		row = row,
		col = col,
		title = opts.title or " tv.nvim ",
		title_pos = "center",
	})

	local cmd = {
		binary,
		"--no-remote",
		"--no-status-bar",
		"--source-command",
		"cat " .. vim.fn.shellescape(tmp),
	}
	if opts.input and opts.input ~= "" then
		table.insert(cmd, "--input")
		table.insert(cmd, opts.input)
	end

	vim.fn.termopen(cmd, {
		on_exit = function(_, _)
			vim.schedule(function()
				local output = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
				local selected = {}
				for _, line in ipairs(output) do
					line = vim.trim(line)
					if line ~= "" then
						selected[#selected + 1] = line
					end
				end

				pcall(vim.fn.delete, tmp)
				pcall(vim.api.nvim_win_close, win, true)

				if #selected == 0 then
					return
				end

				if on_select then
					on_select(selected)
				end
			end)
		end,
	})

	vim.cmd("startinsert")
end

local function collect_keymaps()
	local lines = {}
	local seen = {}
	local modes = { "n", "v", "x", "s", "o", "i", "c", "t" }

	local function add_map(map, mode, scope)
		local lhs = vim.trim(map.lhs or "")
		if lhs == "" then
			return
		end

		local rhs = map.rhs
		if not rhs or rhs == "" then
			rhs = map.callback and "<lua callback>" or "<unmapped>"
		end

		local desc = map.desc and vim.trim(map.desc) or ""
		rhs = tostring(rhs):gsub("\t", " ")
		desc = desc:gsub("\t", " ")

		local line = table.concat({ mode, scope, lhs, rhs, desc }, "\t")
		if not seen[line] then
			seen[line] = true
			lines[#lines + 1] = line
		end
	end

	for _, mode in ipairs(modes) do
		for _, map in ipairs(vim.api.nvim_get_keymap(mode)) do
			add_map(map, mode, "global")
		end
		for _, map in ipairs(vim.api.nvim_buf_get_keymap(0, mode)) do
			add_map(map, mode, "buffer")
		end
	end

	table.sort(lines)
	return lines
end

local function collect_diagnostics()
	local lines = {}

	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) then
			local file = vim.api.nvim_buf_get_name(bufnr)
			if file ~= "" then
				for _, diag in ipairs(vim.diagnostic.get(bufnr)) do
					local severity = vim.diagnostic.severity[diag.severity] or tostring(diag.severity)
					local message = vim.trim((diag.message or ""):gsub("\n", " "))
					lines[#lines + 1] = string.format("%s\t%d\t%d\t%s\t%s", file, diag.lnum + 1, diag.col + 1, severity, message)
				end
			end
		end
	end

	table.sort(lines)
	return lines
end

local function collect_help_topics()
	local topics = {}
	local seen = {}

	for _, topic in ipairs(vim.fn.getcompletion("", "help")) do
		if topic ~= "" and not seen[topic] then
			seen[topic] = true
			topics[#topics + 1] = topic
		end
	end

	table.sort(topics)
	return topics
end

-- local function collect_buffers()
-- 	local lines = {}
--
-- 	for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
-- 		local name = buf.name ~= "" and buf.name or "[No Name]"
-- 		lines[#lines + 1] = string.format("%d\t%s\t%s", buf.bufnr, name, buf.hidden and "hidden" or "listed")
-- 	end
--
-- 	table.sort(lines)
-- 	return lines
-- end
--
-- local function collect_config_files()
-- 	local lines = {}
-- 	local config_dir = vim.fn.stdpath("config")
-- 	for _, path in ipairs(vim.fn.globpath(config_dir, "**/*", false, true)) do
-- 		if vim.fn.filereadable(path) == 1 then
-- 			lines[#lines + 1] = path
-- 		end
-- 	end
-- 	table.sort(lines)
-- 	return lines
-- end
--
-- local function git_root()
-- 	local cwd = vim.fn.getcwd()
-- 	local found = vim.fs.find(".git", { upward = true, path = cwd })
-- 	if #found > 0 then
-- 		return vim.fs.dirname(found[1])
-- 	end
-- 	return nil
-- end
--
-- local function collect_git_status()
-- 	local root = git_root()
-- 	if not root then
-- 		return {}
-- 	end
--
-- 	local lines = {}
-- 	for _, line in ipairs(vim.fn.systemlist({ "git", "-C", root, "status", "--short", "--untracked-files=all" })) do
-- 		line = vim.trim(line)
-- 		if line ~= "" then
-- 			lines[#lines + 1] = line
-- 		end
-- 	end
-- 	table.sort(lines)
-- 	return lines, root
-- end
--
-- local function collect_qf_items(loclist)
-- 	local list = loclist and vim.fn.getloclist(0) or vim.fn.getqflist()
-- 	local lines = {}
-- 	for _, item in ipairs(list or {}) do
-- 		local file = item.filename or (item.bufnr and item.bufnr > 0 and vim.api.nvim_buf_get_name(item.bufnr)) or ""
-- 		if file ~= "" then
-- 			lines[#lines + 1] = string.format("%s\t%d\t%d\t%s", file, item.lnum or 1, item.col or 1, vim.trim(item.text or ""))
-- 		end
-- 	end
-- 	return lines
-- end

local function collect_command_history()
	local lines = {}
	local last = vim.fn.histnr("cmd")
	for i = 1, last do
		local cmd = vim.trim(vim.fn.histget("cmd", i) or "")
		if cmd ~= "" then
			lines[#lines + 1] = cmd
		end
	end
	table.sort(lines)
	return lines
end

local function open_selected_keymaps(entries)
	vim.fn.setreg("+", table.concat(entries, "\n"))
	vim.notify(string.format("Copied %d keymap(s)", #entries), vim.log.levels.INFO, { title = "tv.nvim" })
end

local function open_selected_diagnostic(entry)
	local file, lnum, col = entry:match("^(.-)\t(%d+)\t(%d+)\t")
	if not file then
		return
	end

	lnum = tonumber(lnum) or 1
	col = tonumber(col) or 1
	vim.cmd("edit +" .. lnum .. " " .. vim.fn.fnameescape(file))
	pcall(vim.api.nvim_win_set_cursor, 0, { lnum, math.max(col - 1, 0) })
	pcall(vim.cmd, "normal! zz")
end

local function open_selected_help(entry)
	local topic = vim.trim(entry or "")
	if topic == "" then
		return
	end

	vim.api.nvim_cmd({ cmd = "help", args = { topic } }, {})
end

-- local function open_selected_buffer(entry)
-- 	local bufnr = tonumber((entry or ""):match("^(%d+)") )
-- 	if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
-- 		vim.api.nvim_set_current_buf(bufnr)
-- 	end
-- end
--
-- local function open_selected_config_file(entry)
-- 	entry = vim.trim(entry or "")
-- 	if entry ~= "" then
-- 		vim.cmd("edit " .. vim.fn.fnameescape(entry))
-- 	end
-- end
--
-- local function open_selected_git_status(entry)
-- 	local root = git_root()
-- 	if not root then
-- 		return
-- 	end
--
-- 	local path = entry and entry:gsub("^..%s+", "") or ""
-- 	path = path:gsub("^.*%-%>%s*", "")
-- 	if path ~= "" then
-- 		vim.cmd("edit " .. vim.fn.fnameescape(vim.fs.joinpath(root, vim.trim(path))))
-- 	end
-- end
--
-- local function open_selected_qf(entry)
-- 	local file, lnum, col = entry:match("^(.-)\t(%d+)\t(%d+)\t")
-- 	if not file then
-- 		return
-- 	end
--
-- 	lnum = tonumber(lnum) or 1
-- 	col = tonumber(col) or 1
-- 	vim.cmd("edit +" .. lnum .. " " .. vim.fn.fnameescape(file))
-- 	pcall(vim.api.nvim_win_set_cursor, 0, { lnum, math.max(col - 1, 0) })
-- 	pcall(vim.cmd, "normal! zz")
-- end

local function open_selected_cmd_history(entry)
	entry = vim.trim(entry or "")
	if entry ~= "" then
		vim.api.nvim_input(":" .. entry)
	end
end

local function open_neovim_keymaps()
	launch_lines(collect_keymaps(), {
		title = "Neovim keymaps",
		empty_message = "No keymaps found",
	}, open_selected_keymaps)
end

-- local function open_neovim_buffers()
-- 	launch_lines(collect_buffers(), {
-- 		title = "Buffers",
-- 		empty_message = "No buffers found",
-- 	}, open_selected_buffer)
-- end
--
-- local function open_neovim_config_files()
-- 	launch_lines(collect_config_files(), {
-- 		title = "Config files",
-- 		empty_message = "No config files found",
-- 	}, open_selected_config_file)
-- end
--
-- local function open_neovim_git_status()
-- 	local lines, root = collect_git_status()
-- 	launch_lines(lines, {
-- 		title = "Git status",
-- 		empty_message = root and "No git changes" or "Not a git repo",
-- 	}, open_selected_git_status)
-- end
--
-- local function open_neovim_qflist()
-- 	launch_lines(collect_qf_items(false), {
-- 		title = "Quickfix list",
-- 		empty_message = "Quickfix empty",
-- 	}, open_selected_qf)
-- end
--
-- local function open_neovim_loclist()
-- 	launch_lines(collect_qf_items(true), {
-- 		title = "Location list",
-- 		empty_message = "Location list empty",
-- 	}, open_selected_qf)
-- end

local function open_neovim_cmd_history()
	launch_lines(collect_command_history(), {
		title = "Command history",
		empty_message = "No command history",
	}, open_selected_cmd_history)
end

local function open_neovim_diagnostics()
	launch_lines(collect_diagnostics(), {
		title = "Neovim diagnostics",
		empty_message = "No diagnostics found",
	}, function(entries)
		open_selected_diagnostic(entries[1])
	end)
end

local function open_neovim_help()
	launch_lines(collect_help_topics(), {
		title = "Neovim help",
		empty_message = "No help topics found",
	}, function(entries)
		open_selected_help(entries[1])
	end)
end

return {
	"alexpasmantier/tv.nvim",
	lazy = true,
	cmd = "Tv",
	keys = {
		{ "<leader>tv", open_tv_channels, desc = "TV channels" },
		{
			"<leader>ff",
			function()
				require("tv").tv_channel("files")
			end,
			desc = "Find files",
		},
		{
			"<leader>fw",
			function()
				require("tv").tv_channel("text")
			end,
			desc = "Grep text",
		},
		{
			"<leader>sw",
			function()
				require("tv").tv_channel("text", vim.fn.expand("<cword>"))
			end,
			desc = "Grep word",
		},
		{
			"<leader>fr",
			function()
				direct_tv("recent-files")
			end,
			desc = "Recent files",
		},
		{
			"<leader>fd",
			function()
				direct_tv("dirs")
			end,
			desc = "Directories",
		},
		{
			"<leader>fe",
			function()
				direct_tv("env")
			end,
			desc = "Environment",
		},
		{
			"<leader>sh",
			function()
				direct_tv("bash-history")
			end,
			desc = "Shell history",
		},
		{
			"<leader>fm",
			function()
				direct_tv("man-pages")
			end,
			desc = "Man pages",
		},
		{
			"<leader>ft",
			function()
				direct_tv("todo-comments")
			end,
			desc = "Todo comments",
		},
		-- { "<leader>fg", function() direct_tv("git-files") end, desc = "Git files" },
		-- { "<leader>gb", function() direct_tv("git-log") end, desc = "Git log" },
		{ "<leader>sc", open_neovim_cmd_history, desc = "Command history" },
		{ "<leader>fk", open_neovim_keymaps, desc = "Keymaps" },
		{ "<leader>sd", open_neovim_diagnostics, desc = "Diagnostics" },
		{ "<leader>fh", open_neovim_help, desc = "Help files" },
	},
	config = function()
		require("tv").setup({})
	end,
}
