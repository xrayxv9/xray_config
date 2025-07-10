local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"

-- downloads lazyvim if it doesn't exists

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("xray.remap")
require("xray.set")
require("lazy").setup("plugins", {
	change_detection = {
		notify = false;
	}
})
require("xray.theme_picker")


vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Shows what has been copied when doing yy',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.o.clipboard = "unnamedplus"
vim.o.updatetime = 400

vim.diagnostic.config({
  virtual_text = false,  -- ne pas afficher inline
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    show_header = true,
    source = "always",
    border = "rounded",
    focusable = false,
  },
})

-- Affiche le popup d'erreur LSP quand le curseur reste sur une ligne avec erreur
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end
})

