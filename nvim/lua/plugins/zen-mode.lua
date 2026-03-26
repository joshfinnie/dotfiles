return {
	{
		"folke/twilight.nvim",
		opts = {},
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = {
			{ "<leader>z", "<cmd>ZenMode<CR>", desc = "Toggle Zen Mode" },
		},
		dependencies = { "folke/twilight.nvim" },
		opts = {
			window = {
				width = 0.75,
			},
			plugins = {
				twilight = { enabled = true },
				options = {
					wrap = true,
				},
			},
			on_open = function()
				vim.diagnostic.enable(false)
			end,
			on_close = function()
				vim.diagnostic.enable(true)
			end,
		},
	},
}
