-- executing all files in /lua dir recursivly
local executeInFolder = function(path) 
	local config_path = vim.fn.stdpath("config") .. "\\lua\\"
	local scan = vim.fn.globpath(config_path .. path, "*.lua", false, true)

	for _, file in ipairs(scan) do
		local module = file
			:gsub(config_path, "") -- strip path
			:gsub("%.lua$", "") -- strip .lua extension
			:gsub("[/\\]", ".") -- change / and \\ to dots

		require(module)
	end
end

executeInFolder("env/")
executeInFolder("lazy/")
executeInFolder("depends/")
