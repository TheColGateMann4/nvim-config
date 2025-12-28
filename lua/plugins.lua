return {
	{ 'hrsh7th/vim-vsnip' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'hrsh7th/cmp-nvim-lsp' },

	{ "catppuccin/nvim", name = "catppuccin" },

	{"fmoralesc/vim-tutor-mode"},

	{
		"utilyre/barbecue.nvim",
		dependencies = { "SmiteshP/nvim-navic" }
	},
	{ "nvim-lualine/lualine.nvim" },

	{ "simrat39/symbols-outline.nvim" },

	{ "lewis6991/gitsigns.nvim" },
	{ "lvimuser/lsp-inlayhints.nvim" },
	{"m4xshen/hardtime.nvim"},
	{
		"NStefan002/screenkey.nvim",
		lazy = false
	},
	{
		"ThePrimeagen/vim-be-good",
		cmd = "VimBeGood",
	},
	{
	  "AckslD/nvim-neoclip.lua",
	  dependencies = { "kkharji/sqlite.lua" },
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", 
		},
	},
	{ "nvim-telescope/telescope-dap.nvim"},
}
