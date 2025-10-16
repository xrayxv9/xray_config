return {
    'numToStr/Comment.nvim',
    config = function()
        -- Initialisation du plugin
        require('Comment').setup()

        -- Remapping pour commenter une ligne en mode normal
		vim.keymap.set('n', _G.keybinds.comment.comment, '<CMD>lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Toggle comment for current line' })
        vim.keymap.set('i', _G.keybinds.comment.comment, '<CMD>lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Toggle comment for current line' })

        -- Remapping pour commenter une sélection en mode visuel
        vim.keymap.set('v', _G.keybinds.comment.comment, '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Toggle comment for selected block' })
    end
}

