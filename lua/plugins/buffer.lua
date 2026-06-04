return {
  "romgrk/barbar.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("barbar").setup({})

    vim.api.nvim_set_keymap("n", _G.keybinds.buffer_file.move_right, "<Cmd>BufferNext<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", _G.keybinds.buffer_file.move_left, "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", _G.keybinds.buffer_file.close, "<Cmd>BufferClose<CR>", { noremap = true, silent = true })
  end,
}
