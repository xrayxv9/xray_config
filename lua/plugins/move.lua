return {
    'fedepujol/move.nvim',
    event = "InsertEnter",
	config = function ()
        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', vim.g.keybinds.move_line.move_line_down_normal, ':MoveLine(1)<CR>', opts)
        vim.keymap.set('n', vim.g.keybinds.move_line.move_line_up_normal, ':MoveLine(-1)<CR>', opts)
        vim.keymap.set('v', vim.g.keybinds.move_line.move_line_down_visual, ':MoveBlock(1)<CR>', opts)
        vim.keymap.set('v', vim.g.keybinds.move_line.move_line_up_visual, ':MoveBlock(-1)<CR>', opts)
    end
}
