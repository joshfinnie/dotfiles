vim.pack.add({
	-- Icons
	{
		src = "https://github.com/nvim-tree/nvim-web-devicons",
		version = "40e9d5a6cc3db11b309e39593fc7ac03bb844e38",
	},

	-- Telescope
	{
		src = "https://github.com/nvim-lua/plenary.nvim",
		version = "v0.1.4",
	},
	{
		src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
		version = "6fea601bd2b694c6f2ae08a6c6fab14930c60e2c",
	},
	{
		src = "https://github.com/nvim-telescope/telescope.nvim",
		version = "v0.2.1",
	},
	{
		src = "https://github.com/nvim-telescope/telescope-ui-select.nvim",
		version = "6e51d7da30bd139a6950adf2a47fda6df9fa06d2",
	},

	-- Treesitter
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "539abf6da5ee8702e37b82cc953131dadd570da2",
	},

	-- File tree
	{
		src = "https://github.com/nvim-tree/nvim-tree.lua",
		version = "v1.16.0",
	},

	-- Git stuff
	{
		src = "https://github.com/sindrets/diffview.nvim",
		version = "4516612fe98ff56ae0415a259ff6361a89419b0a",
	},
	{
		src = "https://github.com/lewis6991/gitsigns.nvim",
		version = "v2.1.0",
	},
	{
		src = "https://github.com/tpope/vim-fugitive",
		version = "3b753cf8c6a4dcde6edee8827d464ba9b8c4a6f0",
	},

	-- Barbar
	{
		src = "https://github.com/romgrk/barbar.nvim",
		version = "539d73def39c9172b4d4d769f14090e08f37b29d",
	},

	-- Toggle term
	{
		src = "https://github.com/akinsho/toggleterm.nvim",
		version = "9a88eae817ef395952e08650b3283726786fb5fb",
	},

	-- LSP
	{
		src = "https://github.com/mason-org/mason.nvim",
		version = "v2.2.1",
	},
	{
		src = "https://github.com/mason-org/mason-lspconfig.nvim",
		version = "v2.1.0",
	},

	-- Formatting
	{ src = "https://github.com/stevearc/conform.nvim" },

	-- Autocompletion
	{
		src = "https://github.com/rafamadriz/friendly-snippets",
		version = "6cd7280adead7f586db6fccbd15d2cac7e2188b9",
	},
	{
		src = "https://github.com/saghen/blink.cmp",
		version = "v1.10.2",
	},

	-- Lualine
	{
		src = "https://github.com/nvim-lualine/lualine.nvim",
		version = "8811f3f3f4dc09d740c67e9ce399e7a541e2e5b2",
	},

	-- Colorschemes
	{
		src = "https://github.com/rose-pine/neovim",
		version = "cf2a288696b03d0934da713d66c6d71557b5c997",
	},

	-- Misc.
	{
		src = "https://github.com/rcarriga/nvim-notify",
		version = "v3.15.0",
	},
	{ src = "https://github.com/wuelnerdotexe/vim-astro" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/folke/trouble.nvim" },

	-- Noice (enhanced UI)
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/folke/noice.nvim" },

	-- Flash (motion)
	{ src = "https://github.com/folke/flash.nvim" },

	-- Fidget (LSP progress)
	{ src = "https://github.com/j-hui/fidget.nvim" },

	-- Autopairs
	{ src = "https://github.com/windwp/nvim-autopairs" },

	-- Todo comments
	{ src = "https://github.com/folke/todo-comments.nvim" },

	-- Colorizer
	{ src = "https://github.com/norcalli/nvim-colorizer.lua" },

	-- DAP (debugging)
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/jay-babu/mason-nvim-dap.nvim" },

	-- Linting
	{ src = "https://github.com/mfussenegger/nvim-lint" },
})

require("confs/barbar")
require("confs/colorscheme")
require("confs/conform")
require("confs/diffview")
require("confs/nvim_tree")
require("confs/telescope")
require("confs/toggleterm")
require("confs/trouble")
require("confs/vim_astro")
require("confs/which_key")

require("confs.lsp.setup")

require("confs/treesitter")
require("confs/lualine")
require("confs/gitsigns")
require("confs/noice")
require("confs/flash")
require("confs/fidget")
require("confs/misc")
require("confs/dap")
require("confs/lint")
