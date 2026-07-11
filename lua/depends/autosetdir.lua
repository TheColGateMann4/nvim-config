local targetPath = vim.fn.fnamemodify(vim.fn.argv(0), ":p:h")

if vim.startswith(targetPath, "oil://") then 
	targetPath = require("oil").get_current_dir()
end

if targetPath == nil or targetPath == "" then
	targetPath = vim.loop.cwd()
end

print(vim.fn.expand(targetPath))
print(targetPath)

vim.cmd.cd(vim.fn.expand(targetPath))
