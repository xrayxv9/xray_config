return {
  "romgrk/barbar.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function() vim.g.barbar_auto_setup = false end,
  config = function()
    require("barbar").setup({})
    -- Affiche automatiquement la tabline seulement s'il y a plus d'un buffer
    vim.o.showtabline = 1

    -- Mappings typiques :
    vim.api.nvim_set_keymap("n", "<C-Right>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<C-Left>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<C-w>", "<Cmd>BufferClose<CR>", { noremap = true, silent = true })
  end,
}
