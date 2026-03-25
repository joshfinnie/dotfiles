return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
	config = function()
		require("diffview").setup({
			enhanced_diff_hl = true,
			view = {
				default = {
					layout = "diff2_horizontal",
				},
				merge_tool = {
					layout = "diff3_horizontal",
				},
			},
		})
	end,
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git Diff View" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Git File History" },
		{ "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close Diff View" },
	},
}
