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

			vim.keymap.set("n", "<C-l>", function()
				require("telescope.builtin").live_grep({
					cwd = vim.fn.getcwd(),
					additional_args = function()
						return { "--hidden", "--glob", "!.git/*" }
					end,
					layout_strategy = "horizontal",
				})
			end)
			vim.keymap.set("n", "<C-f>", function()
				require("telescope.builtin").live_grep({
					cwd = vim.fn.expand("%:p:h"),
					additional_args = function()
						return { "--hidden", "--glob", "!.git/*" }
					end,
					layout_strategy = "horizontal",
				})
			end)
		end,
	},
}
