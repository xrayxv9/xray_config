return {
    'numToStr/Comment.nvim',
    config = function()
        -- Initialisation du plugin
        require('Comment').setup()

		vim.keymap.set('n', '<C-\\>', '<CMD>lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Toggle comment for current line' })
        vim.keymap.set('i', '<C-\\>', '<CMD>lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Toggle comment for current line' })
        vim.keymap.set('v', '<C-\\>', '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Toggle comment for selected block' })
    end
}

