vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

vim.o.relativenumber = true
vim.o.updatetime = 150

if vim.g.neovide then
	vim.g.neovide_input_use_logo = true
end
