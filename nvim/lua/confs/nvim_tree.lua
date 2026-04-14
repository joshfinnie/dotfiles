local window_utils = require("utils.window")
local api = require("nvim-tree.api")
local barbar_api = require("barbar.api")

local DEFAULT_WIDTH = 30

local function inc_width()
	local width, _ = window_utils.winsize()
	local new_width = width + 10

	vim.cmd(string.format("NvimTreeResize %d", new_width))
end

local function dec_width()
	local width, _ = window_utils.winsize()

	local new_width = width - 10

	if new_width < DEFAULT_WIDTH then
		return
	end

	vim.cmd(string.format("NvimTreeResize %d", new_width))
end

require("nvim-tree").setup({
	auto_reload_on_write = true,
	hijack_cursor = true,
	update_focused_file = {
		enable = true,
	},
	sort_by = "name",
	filters = {
		custom = {
			".git",
		},
	},
	renderer = {
		highlight_opened_files = "name",
	},
	on_attach = function(bufnr)
		local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }
		vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts)
		vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts)
		vim.keymap.set("n", "r", api.tree.reload, opts)
		vim.keymap.set("n", "a", api.fs.create, opts)
		vim.keymap.set("n", "d", api.fs.remove, opts)
		vim.keymap.set("n", "m", api.fs.rename_sub, opts)
		vim.keymap.set("n", "y", api.fs.copy.relative_path, opts)
		vim.keymap.set("n", "Y", api.fs.copy.absolute_path, opts)
		vim.keymap.set("n", "C", api.tree.collapse_all, opts)
		vim.keymap.set("n", "K", api.node.show_info_popup, opts)
		vim.keymap.set("n", "o", api.node.open.edit, opts)
		vim.keymap.set("n", ">", inc_width, opts)
		vim.keymap.set("n", "<", dec_width, opts)
	end,
	view = {
		side = "left",
		adaptive_size = false,
		centralize_selection = true,
		width = DEFAULT_WIDTH,
	},
})

api.events.subscribe(api.events.Event.Resize, function(new_size)
	--[[@diagnostic disable-next-line: param-type-mismatch]]
	barbar_api.set_offset(new_size, "File Tree")
end)

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true })

-- Auto-open tree on startup (BufEnter fires after plugins are ready, no flash)
vim.api.nvim_create_autocmd("BufEnter", {
	once = true,
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0)
		local stats = vim.uv.fs_stat(bufname)

		if stats and stats.type == "directory" then
			-- Opened with a directory arg
			api.tree.open()
		elseif bufname == "" then
			-- No args: full screen tree, no empty buffer in barbar
			local buf = vim.api.nvim_get_current_buf()
			local win = vim.api.nvim_get_current_win()
			api.tree.open()
			vim.bo[buf].buflisted = false
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
			end
		end
	end,
})
