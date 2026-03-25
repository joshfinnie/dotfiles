return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", config = true },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"nvimtools/none-ls.nvim",
		"nvimtools/none-ls-extras.nvim",
		"jay-babu/mason-null-ls.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "j-hui/fidget.nvim", opts = { text = { spinner = "dots" } } },
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup()

		require("mason-tool-installer").setup({
			ensure_installed = {
				-- LSPs
				"astro-language-server",
				"pyright",
				"gopls",
				"ts-ls",
				"lua-language-server",
				"terraform-ls",
				"rust-analyzer",
				"json-lsp",
				"yamlls",
				"marksman",

				-- Formatters / Linters
				"black",
				"ruff",
				"stylua",
				"prettier",
				"eslint_d",
				"gofumpt",
				"goimports",
				"golangci-lint",
				"tflint",
				"markdownlint-cli2",
				"markdown-toc",
				"yamllint",
				"shfmt",
				"taplo",
			},
			run_on_start = true,
			auto_update = true,
			debounce_hours = 24,
		})

		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		require("mason-null-ls").setup({
			ensure_installed = {
				"black",
				"ruff",
				"stylua",
				"prettier",
				"eslint_d",
				"gofumpt",
				"goimports",
				"golangci-lint",
				"tflint",
				"markdownlint-cli2",
				"markdown-toc",
				"yamllint",
				"shfmt",
				"taplo",
				"rustfmt",
			},
			automatic_installation = true,
		})

		local on_save = null_ls.methods.DIAGNOSTICS_ON_SAVE

		local sources = {
			-- Python
			formatting.black,
			require("none-ls.diagnostics.ruff").with({ method = on_save }),

			-- Lua
			formatting.stylua,

			-- JS/TS/HTML/CSS/Markdown
			formatting.prettier.with({
				extra_args = function(params)
					if params.ft == "markdown" or params.ft == "markdown.mdx" then
						return { "--prose-wrap", "always", "--print-width", "100" }
					end
					return {}
				end,
			}),
			require("none-ls.diagnostics.eslint_d").with({
				method = on_save,
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
				condition = function(utils)
					return utils.root_has_file({
						".eslintrc",
						".eslintrc.js",
						".eslintrc.cjs",
						".eslintrc.json",
						".eslintrc.yaml",
						".eslintrc.yml",
						"eslint.config.js",
						"eslint.config.mjs",
						"eslint.config.cjs",
					})
				end,
			}),

			-- Go
			formatting.gofumpt,
			formatting.goimports,
			diagnostics.golangci_lint.with({ method = on_save }),

			-- Terraform
			formatting.terraform_fmt,

			-- Markdown
			diagnostics.markdownlint_cli2.with({ method = on_save }),

			-- YAML
			diagnostics.yamllint.with({ method = on_save }),

			-- Shell
			formatting.shfmt,
		}

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		null_ls.setup({
			sources = sources,
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		local servers = {
			astro = {},
			pyright = {
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
							typeCheckingMode = "basic",
						},
					},
				},
			},
			gopls = {},
			ts_ls = { filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } },
			lua_ls = {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim", "require" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
						format = {
							enable = false,
						},
					},
				},
			},
			terraformls = {},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
						checkOnSave = { command = "clippy" },
					},
				},
			},
			jsonls = {},
			yamlls = {},
			marksman = {},
		}

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
			callback = function(args)
				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client then
					return
				end

				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
				end

				map("gd", vim.lsp.buf.definition, "Goto Definition")
				map("gr", vim.lsp.buf.references, "Goto References")
				map("gI", vim.lsp.buf.implementation, "Goto Implementation")
				map("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
				map("<leader>rn", vim.lsp.buf.rename, "Rename")
				map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
				map("gD", vim.lsp.buf.declaration, "Goto Declaration")

				if client.supports_method("textDocument/documentHighlight") then
					local highlight_augroup = vim.api.nvim_create_augroup("LspHighlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = bufnr,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = bufnr,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})
				end

				if client.supports_method("textDocument/inlayHint") then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(
							not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
							{ bufnr = bufnr }
						)
					end, "Toggle Inlay Hints")
				end
			end,
		})

		local mason_lspconfig = require("mason-lspconfig")

		for server_name, server in pairs(servers) do
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			vim.lsp.config(server_name, server)
		end

		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
		})
	end,
}
