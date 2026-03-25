-- Start in netrw instead of alpha dashboard
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("InitNetrw", { clear = true }),
	callback = function()
		if vim.fn.expand("%") == "" then
			vim.cmd("edit .")
		end
	end,
})

-- Ensure TSX/JSX files are detected correctly
vim.filetype.add({
	extension = {
		tsx = "typescriptreact",
		jsx = "javascriptreact",
	},
})
