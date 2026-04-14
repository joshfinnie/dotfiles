local utils = require("confs.lsp.utils")
local configs = require("confs.lsp.servers").configs

require("mason").setup()

require("mason-lspconfig").setup({
	automatically_enable = false,
	ensure_installed = utils.must_install_list(),
})

require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<S-Tab>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "select_next", "fallback" },
		["<CR>"] = { "select_and_accept", "fallback" },
	},
	completion = { documentation = { auto_show = true } },
})

local auto_cmd_group_lsp = vim.api.nvim_create_augroup("UserLspConfig", {})

for server, config in pairs(configs) do
	if config.filetypes ~= nil and #config.filetypes > 0 then
		vim.api.nvim_create_autocmd("FileType", {
			group = auto_cmd_group_lsp,
			pattern = config.filetypes,
			callback = function()
				utils.enable_lsp(server)
			end,
		})
	end
end

vim.diagnostic.config({
	float = { border = "single" },
	underline = true,
	virtual_text = false,
	virtual_lines = false,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = auto_cmd_group_lsp,
	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local opts = { buffer = bufnr }

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)

		if client and client.supports_method("textDocument/documentHighlight") then
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

		if client and client.supports_method("textDocument/inlayHint") then
			vim.keymap.set("n", "<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
			end, opts)
		end
	end,
})

local attached_clients = {}

vim.api.nvim_create_autocmd("LspProgress", {
	callback = function(ev)
		local value = ev.data.params.value

		if not value then
			return
		end

		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		if client == nil then
			return
		end

		if attached_clients[client.name] ~= nil and attached_clients[client.name] then
			return
		end

		if value.kind == "end" then
			attached_clients[client.name] = true
		end
	end,
})
