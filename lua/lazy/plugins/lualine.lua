return 
{
	"nvim-lualine/lualine.nvim",
	dependencies = {"catppuccin/nvim"},
	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin",
				globalstatus = true,
				section_separators = { left = "", right = "" },
				component_separators = { left = " | ", right = " | " },
			},
			sections = {
				lualine_a = {
					{ "mode", fmt = function(str) return "[" .. str .. "]" end }
				},
				lualine_b = {
					{ "branch", icon = "" },
					"diff",
				},
				lualine_c = {
					{
						"filename",
						path = 1,
						symbols = {
							modified = " *",
							readonly = " [ro]",
						},
					},
				},
				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = {
							error = "E:",
							warn  = "W:",
							info  = "I:",
							hint  = "H:",
						},
					},
					"encoding",
					"filetype",
				},
				lualine_y = {
					"progress",
				},
				lualine_z = {
					"location",
				},
			},
		})
	end,
}
