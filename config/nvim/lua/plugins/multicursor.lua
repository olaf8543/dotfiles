return {
    'vscode-neovim/vscode-multi-cursor.nvim',
    event = 'VeryLazy',
    cond = vim.g.vscode,
    config = function()
        require('vscode-multi-cursor').setup({
            -- Whether to set default mappings
            default_mappings = false,
            -- If set to true, only multiple cursors will be created without multiple selections
            no_selection = false
        })
        local cursors = require('vscode-multi-cursor')

        local k = vim.keymap.set
        k({ 'n', 'x' }, '<leader>mc', cursors.create_cursor, { expr = true, desc = 'Create cursor' })
        k({ 'n' }, '<leader>mx', cursors.cancel, { desc = 'Cancel/Clear all cursors' })
        k({ 'n', 'x' }, '<leader>mi', cursors.start_left, { desc = 'Start cursors on the left' })
        k({ 'n', 'x' }, '<leader>mI', cursors.start_left_edge, { desc = 'Start cursors on the left edge' })
        k({ 'n', 'x' }, '<leader>ma', cursors.start_right, { desc = 'Start cursors on the right' })
        k({ 'n', 'x' }, '<leader>mA', cursors.start_right, { desc = 'Start cursors on the right' })
        k({ 'n' }, '<leader>[', cursors.prev_cursor, { desc = 'Goto prev cursor' })
        k({ 'n' }, '<leader>]', cursors.next_cursor, { desc = 'Goto next cursor' })
        k('n', '<leader>ml', '<leader>mciw*<Cmd>nohl<CR>', { remap = true })
    end,
}
