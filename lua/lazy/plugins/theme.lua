return
{
	"catppuccin/nvim", 
	name = "catppuccin",
	config = function() 
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = false,
			term_colors = true,
			integrations = {
				treesitter = true,
				lsp = true,
				cmp = true,
				gitsigns = true,
				telescope = true,
			},
		})
	end,
}
