require("diffview").setup({
	enhanced_diff_h1 = true,
	view = {
		default = {
			layout = "diff2_horizontal",
		},
		merge_tool = {
			layout = "diff3_horizontal",
		},
	}
})

vim.keymap.set("n", "<leader>gd", function()
	if vim.g.diffview_open then
		vim.cmd("DiffviewClose")
		vim.g.diffview_open = false
	else
		vim.cmd("DiffviewOpen")
		vim.g.diffview_open = true
	end
end, { noremap = true, silent = true, nowait = true })
