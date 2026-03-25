return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local ok, configs = pcall(require, "nvim-treesitter.configs")
		if ok then
			-- Old API (nvim-treesitter with configs module)
			configs.setup({
				ensure_installed = {
					"astro",
					"lua",
					"python",
					"javascript",
					"typescript",
					"tsx",
					"vimdoc",
					"vim",
					"regex",
					"terraform",
					"sql",
					"dockerfile",
					"toml",
					"json",
					"go",
					"gitignore",
					"graphql",
					"yaml",
					"make",
					"cmake",
					"markdown",
					"markdown_inline",
					"bash",
					"css",
					"html",
					"rust",
				},
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		else
			-- New API (minimal nvim-treesitter)
			require("nvim-treesitter").setup({})
		end
	end,
}
