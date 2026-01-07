local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "objc", "objcpp","h", "hpp", "hh", "hxx" },
	callback = function(args)
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
				"--clang-tidy",
				"--completion-style=detailed",
				"--header-insertion=iwyu",
				"--compile-commands-dir=" .. vim.fn.getcwd()
			},
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
