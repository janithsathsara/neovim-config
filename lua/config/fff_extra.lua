local M = {}

-- ─────────────────────────────────────────────────────────────
-- SHARED UI PRIMITIVES
-- ─────────────────────────────────────────────────────────────

---@class FffPickerOpts
---@field title       string          Title shown in the border
---@field items       string[]        Full list of display strings
---@field prompt      string?         Prompt prefix (default "  ")
---@field on_select   fun(item: string)    Called with the chosen display string
---@field on_preview  fun(buf: integer, item: string)?  Fill preview buffer

local ns = vim.api.nvim_create_namespace("fff_extra")

--- Open a floating picker window identical in style to fff.nvim.
--- Returns nothing; calls opts.on_select when the user presses <CR>.
---@param opts FffPickerOpts
local function open_picker(opts)
	local items = opts.items
	local title = opts.title or ""
	local prompt = opts.prompt or "  "
	local on_select = opts.on_select
	local on_preview = opts.on_preview

	if #items == 0 then
		vim.notify("[fff_extra] " .. title .. ": no items", vim.log.levels.WARN)
		return
	end

	-- ── dimensions ──────────────────────────────────────────────
	local ui = vim.api.nvim_list_uis()[1]
	local total_w = ui and ui.width or vim.o.columns
	local total_h = ui and ui.height or vim.o.lines

	local has_preview = on_preview ~= nil
	local win_w = math.floor(total_w * 0.80)
	local win_h = math.floor(total_h * 0.70)
	local win_row = math.floor((total_h - win_h) / 2)
	local win_col = math.floor((total_w - win_w) / 2)

	local list_w = has_preview and math.floor(win_w * 0.45) or win_w
	local prev_w = has_preview and (win_w - list_w - 1) or 0

	-- ── buffers ─────────────────────────────────────────────────
	local input_buf = vim.api.nvim_create_buf(false, true)
	local list_buf = vim.api.nvim_create_buf(false, true)
	local prev_buf = has_preview and vim.api.nvim_create_buf(false, true) or nil

	vim.bo[input_buf].buftype = "prompt"
	vim.bo[list_buf].modifiable = false
	vim.bo[list_buf].buftype = "nofile"

	if prev_buf then
		vim.bo[prev_buf].modifiable = false
		vim.bo[prev_buf].buftype = "nofile"
	end

	-- ── windows ─────────────────────────────────────────────────
	local border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

	-- input window (1 line, top of list column)
	local input_win = vim.api.nvim_open_win(input_buf, false, {
		relative = "editor",
		row = win_row,
		col = win_col,
		width = list_w,
		height = 1,
		style = "minimal",
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		title = " " .. title .. " ",
		title_pos = "center",
		zindex = 50,
	})

	-- list window (below input)
	local list_win = vim.api.nvim_open_win(list_buf, false, {
		relative = "editor",
		row = win_row + 3, -- input height (1) + border (2)
		col = win_col,
		width = list_w,
		height = win_h - 3,
		style = "minimal",
		border = { "╰", "─", "╯", "│", "╯", "─", "╰", "│" },
		zindex = 50,
	})

	-- preview window (right of list)
	local prev_win = nil
	if has_preview and prev_buf then
		prev_win = vim.api.nvim_open_win(prev_buf, false, {
			relative = "editor",
			row = win_row,
			col = win_col + list_w + 1,
			width = prev_w,
			height = win_h,
			style = "minimal",
			border = border_chars,
			title = "  preview ",
			title_pos = "right",
			zindex = 50,
		})
		vim.wo[prev_win].wrap = false
		vim.wo[prev_win].cursorline = false
		vim.wo[prev_win].number = true
	end

	vim.wo[list_win].cursorline = true
	vim.wo[list_win].number = false
	vim.wo[input_win].wrap = false

	-- ── state ───────────────────────────────────────────────────
	local query = ""
	local filtered = vim.deepcopy(items) -- currently displayed items
	local cursor = 1 -- 1-based index into filtered

	-- ── rendering helpers ────────────────────────────────────────
	local function render_list()
		vim.bo[list_buf].modifiable = true
		vim.api.nvim_buf_set_lines(list_buf, 0, -1, false, filtered)
		vim.bo[list_buf].modifiable = false

		-- move cursor
		local target = math.min(cursor, #filtered)
		if target >= 1 then
			vim.api.nvim_win_set_cursor(list_win, { target, 0 })
		end

		-- highlight match characters (simple: highlight query chars)
		vim.api.nvim_buf_clear_namespace(list_buf, ns, 0, -1)
		if query ~= "" then
			for i, line in ipairs(filtered) do
				local lower_line = line:lower()
				local lower_query = query:lower()
				local col = 1
				for qi = 1, #lower_query do
					local ch = lower_query:sub(qi, qi)
					local found = lower_line:find(ch, col, true)
					if found then
						vim.api.nvim_buf_add_highlight(list_buf, ns, "IncSearch", i - 1, found - 1, found)
						col = found + 1
					end
				end
			end
		end
	end

	local function render_preview()
		if not prev_buf or not on_preview or #filtered == 0 then
			return
		end
		local item = filtered[cursor] or ""
		vim.bo[prev_buf].modifiable = true
		vim.api.nvim_buf_set_lines(prev_buf, 0, -1, false, {})
		on_preview(prev_buf, item)
		vim.bo[prev_buf].modifiable = false
	end

	local function filter_items(q)
		if q == "" then
			filtered = vim.deepcopy(items)
			return
		end
		local lower_q = q:lower()
		local scored = {}
		for _, item in ipairs(items) do
			local lower_item = item:lower()
			-- fuzzy: every character of query must appear in order
			local pos = 1
			local ok = true
			for i = 1, #lower_q do
				local ch = lower_q:sub(i, i)
				local found = lower_item:find(ch, pos, true)
				if not found then
					ok = false
					break
				end
				pos = found + 1
			end
			if ok then
				-- score: prefer items where query appears as a contiguous substring
				local consecutive_bonus = lower_item:find(lower_q, 1, true) and 100 or 0
				scored[#scored + 1] = { item = item, score = consecutive_bonus }
			end
		end
		table.sort(scored, function(a, b)
			return a.score > b.score
		end)
		filtered = vim.tbl_map(function(x)
			return x.item
		end, scored)
	end

	-- ── close helper ─────────────────────────────────────────────
	local closed = false
	local function close_all()
		if closed then
			return
		end
		closed = true
		-- stop insert mode / prompt cleanly
		pcall(vim.api.nvim_win_close, input_win, true)
		pcall(vim.api.nvim_win_close, list_win, true)
		if prev_win then
			pcall(vim.api.nvim_win_close, prev_win, true)
		end
		pcall(vim.api.nvim_buf_delete, input_buf, { force = true })
		pcall(vim.api.nvim_buf_delete, list_buf, { force = true })
		if prev_buf then
			pcall(vim.api.nvim_buf_delete, prev_buf, { force = true })
		end
	end

	-- ── initial render ───────────────────────────────────────────
	render_list()
	render_preview()

	-- ── focus input & start prompt ───────────────────────────────
	vim.api.nvim_set_current_win(input_win)
	vim.fn.prompt_setprompt(input_buf, prompt)

	-- called on every keystroke in the input buffer
	vim.fn.prompt_setcallback(input_buf, function(line)
		-- <CR> with content selects; empty <CR> selects current cursor item
		local item = filtered[cursor]
		if item then
			close_all()
			vim.schedule(function()
				on_select(item)
			end)
		end
	end)

	-- watch input changes for live filtering
	vim.api.nvim_buf_attach(input_buf, false, {
		on_lines = function()
			if closed then
				return true
			end
			vim.schedule(function()
				if closed then
					return
				end
				-- get text after the prompt prefix
				local lines = vim.api.nvim_buf_get_lines(input_buf, 0, -1, false)
				local raw = lines[1] or ""
				query = raw:gsub("^" .. vim.pesc(prompt), "")
				cursor = 1
				filter_items(query)
				render_list()
				render_preview()
			end)
		end,
	})

	-- ── keymaps on list buffer (navigate without leaving input) ──
	-- We focus input but still need list nav; use <C-j>/<C-k>/<C-d> in insert mode
	local function move(delta)
		if #filtered == 0 then
			return
		end
		cursor = math.max(1, math.min(#filtered, cursor + delta))
		render_list()
		render_preview()
	end

	local imap = function(key, fn)
		vim.keymap.set("i", key, fn, { buffer = input_buf, nowait = true, silent = true })
	end

	imap("<C-j>", function()
		move(1)
	end)
	imap("<C-k>", function()
		move(-1)
	end)
	imap("<Down>", function()
		move(1)
	end)
	imap("<Up>", function()
		move(-1)
	end)
	imap("<C-d>", function()
		move(5)
	end)
	imap("<C-u>", function()
		move(-5)
	end)
	imap("<C-s>", function() -- horizontal split
		local item = filtered[cursor]
		if item then
			close_all()
			vim.schedule(function()
				on_select(item, "split")
			end)
		end
	end)
	imap("<C-v>", function() -- vertical split
		local item = filtered[cursor]
		if item then
			close_all()
			vim.schedule(function()
				on_select(item, "vsplit")
			end)
		end
	end)
	imap("<Esc>", function()
		close_all()
	end)
	imap("<C-c>", function()
		close_all()
	end)

	-- enter insert mode
	vim.cmd("startinsert")
end

-- ─────────────────────────────────────────────────────────────
-- PICKER 1 – RECENT FILES  (:FFFRecent)
-- ─────────────────────────────────────────────────────────────

---Open a picker over `v:oldfiles`, filtered to files that exist on disk.
---Supports <C-s> / <C-v> for splits.
function M.recent_files()
	-- merge oldfiles with currently open buffers so nothing is missed
	local seen = {}
	local all = {}

	-- open buffers first (most relevant)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) then
			local name = vim.api.nvim_buf_get_name(buf)
			if name ~= "" and vim.fn.filereadable(name) == 1 and not seen[name] then
				seen[name] = true
				all[#all + 1] = name
			end
		end
	end

	-- then oldfiles
	for _, f in ipairs(vim.v.oldfiles or {}) do
		if vim.fn.filereadable(f) == 1 and not seen[f] then
			seen[f] = true
			all[#all + 1] = f
		end
	end

	-- display relative paths
	local cwd = vim.fn.getcwd() .. "/"
	local display = vim.tbl_map(function(f)
		return f:find(cwd, 1, true) == 1 and f:sub(#cwd + 1) or f
	end, all)

	-- reverse map display → full path
	local path_for = {}
	for i, d in ipairs(display) do
		path_for[d] = all[i]
	end

	open_picker({
		title = " Recent Files ",
		items = display,
		prompt = "  ",
		on_select = function(item, mode)
			local path = path_for[item] or item
			if mode == "split" then
				vim.cmd("split " .. vim.fn.fnameescape(path))
			elseif mode == "vsplit" then
				vim.cmd("vsplit " .. vim.fn.fnameescape(path))
			else
				vim.cmd("edit " .. vim.fn.fnameescape(path))
			end
		end,
		on_preview = function(buf, item)
			local path = path_for[item] or item
			if vim.fn.filereadable(path) ~= 1 then
				return
			end
			local lines = {}
			local f = io.open(path, "r")
			if f then
				local n = 0
				for line in f:lines() do
					lines[#lines + 1] = line
					n = n + 1
					if n >= 200 then
						break
					end -- cap preview at 200 lines
				end
				f:close()
			end
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
			-- set filetype for syntax highlighting
			local ext = path:match("%.([^./]+)$") or ""
			pcall(vim.api.nvim_buf_set_option, buf, "filetype", ext)
		end,
	})
end

-- ─────────────────────────────────────────────────────────────
-- PICKER 2 – KEYMAPS  (:FFFKeymaps)
-- ─────────────────────────────────────────────────────────────

---Open a picker over all active keymaps (normal mode by default).
---Selecting a mapping executes it in the current buffer.
---@param mode? string  vim mode letter, default "n"
function M.keymaps(mode)
	mode = mode or "n"

	local maps = vim.api.nvim_get_keymap(mode)
	-- also include buffer-local maps of the calling buffer
	local buf_maps = vim.api.nvim_buf_get_keymap(0, mode)
	vim.list_extend(maps, buf_maps)

	if #maps == 0 then
		vim.notify("[fff_extra] No keymaps found for mode: " .. mode, vim.log.levels.WARN)
		return
	end

	-- build display lines: "  <lhs>  │  <desc or rhs>"
	local items = {}
	local map_for = {} -- display string → keymap table

	for _, m in ipairs(maps) do
		local lhs = m.lhs or ""
		local desc = m.desc ~= "" and m.desc or (m.rhs or "[expr]")
		-- truncate long rhs
		if #desc > 60 then
			desc = desc:sub(1, 57) .. "…"
		end
		local line = string.format("%-20s  │  %s", lhs, desc)
		items[#items + 1] = line
		map_for[line] = m
	end

	-- sort alphabetically by lhs
	table.sort(items)

	open_picker({
		title = string.format(" Keymaps [%s] ", mode),
		items = items,
		prompt = "  ",
		on_select = function(item)
			local m = map_for[item]
			if not m then
				return
			end
			-- execute the mapping's rhs, or call its Lua callback
			if m.callback then
				m.callback()
			elseif m.rhs and m.rhs ~= "" then
				local keys = vim.api.nvim_replace_termcodes(m.rhs, true, false, true)
				vim.api.nvim_feedkeys(keys, "n", false)
			else
				vim.notify("[fff_extra] Keymap has no executable rhs", vim.log.levels.INFO)
			end
		end,
		on_preview = function(buf, item)
			local m = map_for[item]
			if not m then
				return
			end
			local lines = {
				"Mode    : " .. (m.mode or "?"),
				"LHS     : " .. (m.lhs or ""),
				"RHS     : " .. (m.rhs or "[Lua callback]"),
				"",
				"Desc    : " .. (m.desc or "(none)"),
				"",
				"Buffer  : " .. (m.buffer ~= 0 and "local (buf " .. m.buffer .. ")" or "global"),
				"Silent  : " .. tostring(m.silent == 1),
				"Noremap : " .. tostring(m.noremap == 1),
				"Expr    : " .. tostring(m.expr == 1),
			}
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
		end,
	})
end

-- ─────────────────────────────────────────────────────────────
-- PICKER 3 – HELP TAGS  (:FFFHelp)
-- ─────────────────────────────────────────────────────────────

---Open a picker over all installed help tags.
---Selecting a tag opens it with :help.
function M.help()
	-- collect tags from all help directories in runtimepath
	local tags = {}
	local seen = {}

	local rtps = vim.api.nvim_get_runtime_file("doc/tags", true)
	for _, tagfile in ipairs(rtps) do
		local f = io.open(tagfile, "r")
		if f then
			for line in f:lines() do
				-- tag files: "<tag>\t<file>\t<pattern>"
				local tag = line:match("^([^\t]+)")
				if tag and not tag:match("^!") and not seen[tag] then
					seen[tag] = true
					tags[#tags + 1] = tag
				end
			end
			f:close()
		end
	end

	if #tags == 0 then
		vim.notify("[fff_extra] No help tags found", vim.log.levels.WARN)
		return
	end

	table.sort(tags)

	open_picker({
		title = " Help Tags ",
		items = tags,
		prompt = "  ",
		on_select = function(item)
			vim.cmd("help " .. vim.fn.fnameescape(item))
		end,
		on_preview = function(buf, item)
			-- Show the first ~50 lines of the tag's help section
			local ok, lines = pcall(function()
				local tmp = vim.api.nvim_create_buf(false, true)
				-- silently open help into a scratch buffer via redir trick
				local saved = vim.o.more
				vim.o.more = false
				-- get the helpfile path for this tag
				local hpath = vim.fn.globpath(vim.o.runtimepath, "doc/" .. item:match("[^/]+") .. ".txt", false, true)
				vim.o.more = saved

				-- just show the tag name; full rendering would require actually opening the help buf
				local preview_lines = {
					"  " .. item,
					"",
					"  Press <CR> to open in a help window.",
					"",
				}

				-- try to extract the section from the tags file
				for _, tagfile in ipairs(vim.api.nvim_get_runtime_file("doc/tags", true)) do
					local f = io.open(tagfile, "r")
					if f then
						for tline in f:lines() do
							local t, file, _ = tline:match("^([^\t]+)\t([^\t]+)\t")
							if t == item and file then
								-- find the help file
								local help_dir = tagfile:match("(.+)/[^/]+$")
								local help_path = help_dir .. "/" .. file
								local hf = io.open(help_path, "r")
								if hf then
									local n = 0
									local found = false
									for hl in hf:lines() do
										-- find the tag marker
										if not found and hl:find("*" .. vim.pesc(item) .. "*", 1, false) then
											found = true
										end
										if found then
											preview_lines[#preview_lines + 1] = hl
											n = n + 1
											if n >= 60 then
												break
											end
										end
									end
									hf:close()
								end
								break
							end
						end
						f:close()
					end
					if #preview_lines > 10 then
						break
					end
				end

				vim.api.nvim_buf_delete(tmp, { force = true })
				return preview_lines
			end)

			if ok then
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
			end
		end,
	})
end

-- ─────────────────────────────────────────────────────────────
-- USER COMMANDS  (optional convenience)
-- ─────────────────────────────────────────────────────────────

vim.api.nvim_create_user_command("FFFRecent", function()
	M.recent_files()
end, { desc = "fff recent files" })
vim.api.nvim_create_user_command("FFFKeymaps", function(o)
	M.keymaps(o.args ~= "" and o.args or nil)
end, { nargs = "?", desc = "fff keymaps [mode]" })
vim.api.nvim_create_user_command("FFFHelp", function()
	M.help()
end, { desc = "fff help tags" })

return M
