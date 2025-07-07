vim.g.mapleader = " "

vim.keymap.set('n', '<C-b>', function()
  if vim.o.showtabline == 2 then
    vim.o.showtabline = 0
  else
    vim.o.showtabline = 2
  end
end, { noremap = true, silent = true, desc = "Toggle barbar tabline" })
