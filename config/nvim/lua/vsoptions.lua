vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

vim.keymap.set('n', '<leader>al', function()
    vim.fn.VSCodeNotify('settings.cycle.lineNumbers')
end, { desc = 'Change between relative and absolute line numbers' })

vim.keymap.set('n', '<leader>e', function()
    vim.fn.VSCodeNotify('workbench.view.explorer') -- Focus the explorer
end, { desc = 'Focus Explorer sidebar' })

vim.keymap.set('n', '<leader>d', function()
    vim.fn.VSCodeNotify('workbench.action.toggleSidebarVisibility') -- Focus the explorer
end, { desc = 'Toggle Explorer sidebar visibility' })

vim.keymap.set('n', '<leader>g', function()
    vim.fn.VSCodeNotify('multiCommand.lazygitFlow')
end, { desc = 'Open lazygit and auto-close terminal' })

vim.keymap.set('n', '<leader>t', function()
    vim.fn.VSCodeNotify('workbench.action.terminal.focus')
end, { desc = 'Focus terminal' })
