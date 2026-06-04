_G.keybinds= require("xray.easy_remap").read_datas()
require("xray")
require('move').setup({})

vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Q', 'q!', {})
vim.api.nvim_create_user_command('X', 'x', {})

local name = io.popen("/usr/bin/mktemp -d")
if name then
	vim.g.tmpFile = name:read("*a")
	name:close()
end

vim.api.nvim_create_autocmd("QuitPre", {
	callback = function ()
		for _, files in pairs(Deleted_files) do
			if vim.fn.filereadable(files) or vim.fn.isdirectory(files) then
				vim.fn.delete(files .. ".deleted", "rf")
			end
		end
		vim.cmd("NvimTreeClose")
	end,
})

-- permet de mettre le header 42
vim.api.nvim_set_keymap('n', _G.keybinds.fourty_two.header, ':Stdheader<CR>', { noremap = true, silent = true })

vim.keymap.set('i', '<C-S>', '<Esc>:w<CR>i<right>', { noremap = true, silent = true})
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>i<right>', { noremap = true, silent = true})
vim.keymap.set('n', '<C-S>', '<Esc>:w<CR>', { noremap = true, silent = true})
vim.keymap.set('n', '<C-S>', '<Esc>:w<CR>', { noremap = true, silent = true})

vim.keymap.set('i', '<C-Del>', '<Esc>dwi<right>', { noremap = true, silent = true})
vim.keymap.set('n', '<C-Del>', 'dw', { noremap = true, silent = true})
