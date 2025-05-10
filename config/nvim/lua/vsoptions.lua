vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

vim.keymap.set('n', '<leader>al', function()
    vim.fn.VSCodeNotify('settings.cycle.lineNumbers')
end)

vim.keymap.set('n', '<leader>e', function()
    vim.fn.VSCodeNotify('workbench.view.explorer') -- Focus the explorer
end, { desc = 'Focus Explorer sidebar' })

vim.keymap.set('n', '<leader>E', function()
    vim.fn.VSCodeNotify('workbench.action.toggleSidebarVisibility') -- Focus the explorer
end, { desc = 'Focus Explorer sidebar' })
