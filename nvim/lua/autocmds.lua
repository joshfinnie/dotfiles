-- Ensure TSX/JSX files are detected correctly
vim.filetype.add({
	extension = {
		tsx = "typescriptreact",
		jsx = "javascriptreact",
	},
})
