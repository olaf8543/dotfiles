return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },

    config = function()
        require('telescope').load_extension('fzf')

        local layout_config = {
            vertical = {
                width = 0.85,
            },
            horizontal = {
                preview_width = 0.6,
            }
        }

        require('telescope').setup{
            defaults = {
                mappings = {
                    i = {
                        ["<C-h>"] = "which_key"
                    }
                },
                layout_config = layout_config
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            }
        }

        --dynamic layout function: changes layout based on window width
        local dynamic_layout = function ()
            local window_threshold = 120
            local win_width = vim.fn.winwidth(0)

            return win_width > window_threshold and "horizontal" or "vertical"
        end


        vim.keymap.set('n', '<leader>f', function()
            local opts = {
                layout_strategy = dynamic_layout(),
            }
            require('telescope.builtin').find_files(opts)
        end)

        vim.keymap.set('n', '<leader>F', function()
            local opts = {
                layout_strategy = dynamic_layout(),
                cwd = "~",
                hidden = true,
            }
            require('telescope.builtin').find_files(opts)
        end)

        vim.keymap.set('n', '<leader>af', function()
            local opts = {
                layout_strategy = dynamic_layout(),
            }
            require('telescope.builtin').help_tags(opts)
        end)
    end,
}
