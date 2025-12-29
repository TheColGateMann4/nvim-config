return {
	"TimUntersberger/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "sindrets/diffview.nvim", lazy = false },

		"nvim-telescope/telescope.nvim",
	},
	lazy = false,
	cmd = "Neogit",
	keys = {
		{ "<M-g>", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
	},
	config = function()
		require("neogit").setup {
			integrations = {
				telescope = true,
				diffview = true,
			},
			disable_commit_confirmation = true,
			kind="replace",
		}
	end
}
