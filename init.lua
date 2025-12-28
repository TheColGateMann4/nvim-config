vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

vim.o.number = true
vim.o.relativenumber = true

vim.o.updatetime = 150

if vim.g.neovide then
  vim.g.neovide_input_use_logo = true
end

vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

local project_root = vim.fn.getcwd() .. '/..'

local root = vim.fs.dirname(vim.fs.find({".clangd", ".git"}, { upward = true })[1])

local cmp = require("cmp")

cmp.setup({
       mapping = cmp.mapping.preset.insert({
	["<leader>["] = cmp.mapping.complete(),
    	["<leader>]"] = cmp.mapping.confirm({ select = true }),
      }),
sources = cmp.config.sources({
    { 
      name = "nvim_lsp",
      entry_filter = function(entry)
           return not entry:get_completion_item().label:match("^•") and not entry:get_completion_item().deprecated
      end,
    },
    { name = "buffer" },
    { name = "path" },
    { name = "nvim_lua" },
  }),
  window = {
      completion = cmp.config.window.bordered({
      side_padding = 1,
      winhighlight = "Normal:Normal,FloatBorder:Normal",
      col_offset = 0,
      row_offset = 1,
    }),
    documentation = cmp.config.window.bordered({
      col_offset = 0,
      row_offset = 1,
    }),
  },
  experimental = {
    ghost_text = false,
  },
  preselect = cmp.PreselectMode.Item,
  formatting = {
    format = function(entry, vim_item)
      return vim_item
    end,
  },
  view = {
    entries = { name = 'custom', selection_order = 'near_cursor' },
  },
})

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
                "--compile-commands-dir=" .. "C:/Projects/Teleios Engine",
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
vim.cmd[[colorscheme catppuccin]]
require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = false,
    term_colors = true,
    integrations = {
        treesitter = true,
        lsp = true,
        cmp = true,
        gitsigns = true,
        telescope = true,
    },
})



vim.keymap.set("n", "<C-p>", function()
  require('telescope.builtin').find_files({
    cwd = vim.fn.getcwd(),
    find_command = { "fd", "--type", "f", "--exclude", ".git" },
    layout_strategy = "horizontal",
  })
end)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = "rounded",
    max_width = 80,
    max_height = 20,
    focusable = false,
  }
)

require("barbecue").setup({
  theme = "catppuccin",
  symbols = {
    separator = ">",
  },
})

require('gitsigns').setup()

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

require("hardtime").setup()

vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)


local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "v" }, "d", '"_d')
vim.keymap.set({ "n", "v" }, "c", '"_c')
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("v", "p", '"_dP')

vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

vim.keymap.set("v", "y", function()
  vim.cmd("normal! y")
  vim.cmd("normal! gv")
end, { noremap = true, silent = true })
