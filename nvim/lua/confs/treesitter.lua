local parsers = {
	"astro", "lua", "python", "javascript", "typescript", "tsx",
	"vimdoc", "vim", "regex", "terraform", "sql", "dockerfile",
	"toml", "json", "go", "gitignore", "graphql", "yaml",
	"make", "cmake", "markdown", "markdown_inline", "bash",
	"css", "html", "rust",
}

local ok, configs = pcall(require, "nvim-treesitter.configs")
if ok then
	configs.setup({
		ensure_installed = parsers,
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
	})
else
	require("nvim-treesitter").setup({
		ensure_installed = parsers,
		auto_install = true,
	})
end
