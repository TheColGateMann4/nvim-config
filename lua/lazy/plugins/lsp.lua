return 
{ 
	{
		'hrsh7th/nvim-cmp',
		lazy = false,
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),    -- next item
					["<C-p>"] = cmp.mapping.select_prev_item(),    -- previous item
					["<C-Space>"] = cmp.mapping.complete(),        -- trigger completion
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- confirm selection
					["<C-e>"] = cmp.mapping.abort(),               -- cancel completion
				}),
				sources = cmp.config.sources({
					{ 
						name = "nvim_lsp",
						entry_filter = function(entry)
							return not entry:get_completion_item().label:match("^•") and not entry:get_completion_item().deprecated
						end,
					},
					{ name = "vsnip" },
					{ name = "buffer" },
					{ name = "path" },
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
				experimental = { ghost_text = true },
				preselect = cmp.PreselectMode.Item,
				formatting = {
					format = function(entry, vim_item)
						return vim_item
					end,
				},
				view = {
					entries = {
						name = 'custom',
						selection_order = 'near_cursor'
					},
				},
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
				vim.lsp.handlers.signature_help, {
					border = "rounded",
					max_width = 80,
					max_height = 20,
					focusable = false,
				}
			)

			vim.keymap.set("n", "gd", vim.lsp.buf.declaration)
			vim.keymap.set("n", "gr", vim.lsp.buf.references)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation)


			local opts = { noremap = true, silent = true }

			vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
		end,
	},
	{
		'hrsh7th/cmp-nvim-lsp',
	},
	{
		'hrsh7th/cmp-vsnip',
	},
	{
		'hrsh7th/vim-vsnip',
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
	},
} 
