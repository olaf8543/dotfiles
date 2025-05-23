return {
    'olivercederborg/poimandres.nvim',
    lazy = false,
    priority = 1000,
    cond = not vim.g.vscode,
    config = function()
        require('poimandres').setup {
            -- leave this setup function empty for default config
            -- or refer to the configuration section
            -- for configuration options
            disable_background = true, -- disable background
        }
    end,

    -- optionally set the colorscheme within lazy config
    --     init = function()
    --         vim.cmd("colorscheme poimandres")
    --     end
}
