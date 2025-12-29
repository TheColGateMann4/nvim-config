return
{
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", 
		},
		config = function()
			require("telescope").setup({});
			vim.keymap.set("n", "<C-p>", function()
				require('telescope.builtin').find_files({
					cwd = vim.fn.getcwd(),
					find_command = { "fd", "--type", "f", "--exclude", ".git" },
					layout_strategy = "horizontal",
				})
			end)
		end,
	},
}
