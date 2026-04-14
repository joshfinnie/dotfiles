local configs = require("confs.lsp.servers").configs

local M = {
	enabled_servers = {},
}

function M.must_install_list()
	local servers = {}
	for name, _ in pairs(configs) do
		table.insert(servers, name)
	end
	return servers
end

function M.enable_lsp(name)
	local config = configs[name]

	if config == nil then
		return
	end

	if M.enabled_servers[name] then
		return
	end

	vim.lsp.config[name] = config
	vim.lsp.enable(name)
	M.enabled_servers[name] = true
end

return M
