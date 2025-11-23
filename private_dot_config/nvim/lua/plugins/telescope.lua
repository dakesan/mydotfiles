return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local actions = require('telescope.actions')
        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        -- In insert mode: open selection in a split / vsplit / tab
                        ['<C-s>'] = actions.file_split,
                        ['<C-v>'] = actions.file_vsplit,
                        ['<C-t>'] = actions.select_tab,
                    },
                },
            },
        })

        local builtin = require('telescope.builtin')
        -- Keymaps: change these to your preferred leader combos
        vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope: Find files' })
        vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Telescope: Live grep' })
        vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope: Buffers' })
        vim.keymap.set('n', '<leader>F', builtin.find_files, { desc = 'Telescope: Find files (cwd)' })
    end,
}
