return {
    'numToStr/Comment.nvim',
    config = function()
        -- Initialisation du plugin
        require('Comment').setup()

        -- Remapping pour commenter une ligne en mode normal
		vim.keymap.set({ 'n', 'v', 'i' }, _G.keybinds.comment.comment, '<CMD>lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Toggle comment for current line' })
    end
}

