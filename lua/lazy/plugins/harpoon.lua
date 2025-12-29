return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	lazy = false,
	config = function()
		local harpoon = require("harpoon")
		harpoon.setup({
			global_settings = {
				save_on_toggle = true,
				save_on_change = true,
				excluded_filetypes = { "harpoon" },
			},
		})

		local list = harpoon:list()
		local ui = harpoon.ui

		vim.keymap.set("n", "<M-a>", function() list:add() end)
		vim.keymap.set("n", "<M-q>", function() ui:toggle_quick_menu(list) end)
		vim.keymap.set("n", "<M-1>", function() list:select(1) end)
		vim.keymap.set("n", "<M-2>", function() list:select(2) end)
		vim.keymap.set("n", "<M-3>", function() list:select(3) end)
		vim.keymap.set("n", "<M-4>", function() list:select(4) end)
		vim.keymap.set("n", "<M-5>", function() list:select(5) end)
		vim.keymap.set("n", "<M-6>", function() list:select(6) end)
		vim.keymap.set("n", "<M-7>", function() list:select(7) end)
		vim.keymap.set("n", "<M-8>", function() list:select(8) end)
		vim.keymap.set("n", "<M-9>", function() list:select(9) end)
		vim.keymap.set("n", "<M-0>", function() list:select(10) end)
	end,
}
