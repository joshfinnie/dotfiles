return {
	"wuelnerdotexe/vim-astro",
	ft = "astro",
	init = function()
		-- Enable TypeScript/TSX syntax highlighting
		vim.g.astro_typescript = "enable"
	end,
}
