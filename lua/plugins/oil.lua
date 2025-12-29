return {
	'stevearc/oil.nvim',
	opts = {},
	lazy = false,
	opts = {
		columns = {
			"icon",
			"permissions",
			"size",
			"mtime",
		},
		watch_for_changes = false,
		keymaps = {
			["<M-k>"] = "actions.parent",
			["<M-j>"] = "actions.select",
			["<M-u>"] = "actions.refresh",
			["<M-y>"] = "actions.yank_entry",
		},
		view_options = {
			show_hidden = true,
			case_insensitive = true,
			sort = {
				{ "type", "asc" },
				{ "name", "asc" },
			},
		},
	},
	config = function(_, opts)
		require("oil").setup(opts)
		vim.keymap.set("n", "<M-e>", require("oil").open, { desc = "Open Oil file explorer" })
	end,
}
