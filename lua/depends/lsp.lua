local function find_root(start)

	local markers = {
		"compile_commands.json",
		".clangd",
		"README.md",
		"LICENSE",
		".git",
	}

	local found = vim.fs.find(markers, {
		upward = true,
		path = start,
	})[1]

	if not found then
		return start
	end

	local dir = vim.fs.dirname(vim.fs.abspath(found))

	return dir
end

local function clangd_running(root)
	for _, client in pairs(vim.lsp.get_clients({ name = "clangd" })) do
		if client.config.root_dir == root then
			return true
		end
	end
	return false
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	pattern = { "c", "cpp", "objc", "objcpp" },
	callback = function(args)
		local file = vim.api.nvim_buf_get_name(args.buf)
		if file == "" then return end

		local file_dir = vim.fs.dirname(file)
		local root = find_root(file_dir)

		if clangd_running(root) then return end
		if vim.fn.executable("clangd") == 0 then
			vim.notify("clangd not found in PATH!", vim.log.levels.ERROR)
			return
		end

		vim.lsp.start({
			name = "clangd",
			cmd = {
				"clangd",
				"--background-index",
				"--log=verbose",
				"--compile-commands-dir=" .. root, 
				"--query-driver=C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/**/bin/Hostx64/x64/cl.exe",
				"--fallback-style=llvm",
			},
			root_dir = root,
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				require("lsp-inlayhints").on_attach(client, bufnr)

				vim.api.nvim_create_autocmd("CursorHoldI", {
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.signature_help()
					end,
				})
			end,
		})
	end,
})
