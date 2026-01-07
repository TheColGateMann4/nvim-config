return 
{
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ':TSUpdate'
	config = function()
            require('nvim-treesitter.configs').setup({
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        node_decremental = "grm",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["[f"] = "@function.inner",
                            ["[a"] = "@parameter.inner",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.inner",
                            ["[a"] = "@parameter.inner",
                        },
			goto_next_end = {
                            ["]F"] = "@function.outer",
                            ["]A"] = "@parameter.outer",
                        },
                        goto_previous_end = {
                            ["]F"] = "@function.outer",
                            ["]A"] = "@parameter.outer",
                        }
                    },
                },
                refactor = {
                    highlight_definitions = { enable = true },
                    smart_rename = {
                        enable = true,
                        keymaps = { smart_rename = "grr" },
                    },
                },
                playground = {
                    enable = true,
                },
            })
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-refactor',
            'nvim-treesitter/playground',
            'nvim-treesitter/nvim-treesitter-context',
        },
}
