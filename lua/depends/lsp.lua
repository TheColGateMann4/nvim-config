local root = vim.fs.dirname(vim.fs.find({".clangd", ".git"}, { upward = true })[1])
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "objc", "objcpp" },
    callback = function()
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
