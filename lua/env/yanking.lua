-- setting yank register to system clipboard
vim.opt.clipboard = "unnamedplus"

-- setting changind and deleting to not copy to register
vim.keymap.set({ "n", "v" }, "d", '"_d')
vim.keymap.set({ "n", "v" }, "c", '"_c')
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("v", "p", '"_dP')

-- setting yanking so it doesn't cancel selection
vim.keymap.set("v", "y", function()
	vim.cmd("normal! y")
	vim.cmd("normal! gv")
end, { noremap = true, silent = true })
