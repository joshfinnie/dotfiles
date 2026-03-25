return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			},
			presets = {
				operators = true,
				motions = true,
				text_objects = true,
				windows = true,
				nav = true,
				z = true,
				g = true,
			},
		},
		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
		},
		win = {
			border = "rounded",
			padding = { 1, 2 },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		-- Register leader key groups for better organization
		wk.add({
			{ "<leader>b", group = "Buffer" },
			{ "<leader>c", group = "Code" },
			{ "<leader>d", group = "Debug" },
			{ "<leader>e", desc = "Toggle NeoTree" },
			{ "<leader>g", group = "Git" },
			{ "<leader>l", group = "Line" },
			{ "<leader>r", group = "Rename" },
			{ "<leader>s", group = "Save/Split" },
			{ "<leader>t", group = "Toggle/Terminal" },
			{ "<leader>x", group = "Close" },
		})
	end,
}
