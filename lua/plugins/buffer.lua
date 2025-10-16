return {
  "romgrk/barbar.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function() vim.g.barbar_auto_setup = true end,
  config = function()
    require("barbar").setup({})
    -- Affiche automatiquement la tabline seulement s'il y a plus d'un buffer

    -- Mappings typiques :
    vim.api.nvim_set_keymap("n", _G.keybinds.buffer_file.move_right, "<Cmd>BufferNext<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", _G.keybinds.buffer_file.move_left, "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", _G.keybinds.buffer_file.close, "<Cmd>BufferClose<CR>", { noremap = true, silent = true })
  end,

	vim.keymap.set('n', _G.keybinds.buffer_file.hide_show, function()
	  if vim.o.showtabline == 2 then
		vim.o.showtabline = 0
	  else
		vim.o.showtabline = 2
	  end
	end, { noremap = true, silent = true, desc = "Toggle barbar tabline" })
}
