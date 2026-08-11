require("conform").setup({
	format_on_save = { timeout_ms = 2000, lsp_format = "fallback" },
	formatters = {
		prettier = {
			args = function(_, ctx)
				local args = { "--stdin-filepath", "$FILENAME" }
				if ctx.filetype == "markdown" or ctx.filetype == "markdown.mdx" then
					vim.list_extend(args, { "--prose-wrap", "always", "--print-width", "100" })
				end
				return args
			end,
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "ruff_format" },
		rust = { "rustfmt", lsp_format = "fallback" },
		go = { "gofumpt", "goimports" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		astro = { lsp_format = "first" },
		html = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		["markdown.mdx"] = { "prettier" },
		toml = { "taplo" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		terraform = { "terraform_fmt" },
		tf = { "terraform_fmt" },
	},
})
