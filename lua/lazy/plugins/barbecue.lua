return 
{
	"utilyre/barbecue.nvim",
	dependencies = { "SmiteshP/nvim-navic" },
	config = function()
		require("barbecue").setup({
			theme = "catppuccin",
			symbols = {
				separator = ">",
			},
		})
	end,
}
