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
