_G.keybinds= require("xray.easy_remap").read_datas()
require("xray")
require('move').setup({})

vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Q', 'q!', {})
vim.api.nvim_create_user_command('X', 'x', {})

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

vim.keymap.set('n', '<CR>', 'i', { noremap = true, silent = true });
-- permet de se deplacer rapidement dans une ligne
vim.keymap.set('i', '<C-4>', '<Esc>$i', { noremap = true, silent = true })
vim.keymap.set('n', '<C-4>', '<Esc>$', { noremap = true, silent = true })
vim.keymap.set('i', '<C-6>', '<Esc>^i', { noremap = true, silent = true })
vim.keymap.set('n', '<C-6>', '<Esc>^', { noremap = true, silent = true })


-- creer un main a la norme en C
vim.keymap.set('n', _G.keybinds.fourty_two.main, '<Esc>:Stdheader<CR>i\n#include <unistd.h>\n\nint	main(int argc, char *argv[])\n{\n(void)argv;\n\tif (argc < 2)\n\t\twrite(1, "please give me an argument\\n", 27);\n\treturn (0);\n}', { noremap = true, silent = true })

-- permet de mettre le header 42
vim.api.nvim_set_keymap('n', _G.keybinds.fourty_two.header, ':Stdheader<CR>', { noremap = true, silent = true })

vim.keymap.set('i', '<C-S>', '<Esc>:w<CR>i', { noremap = true, silent = true})
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>i', { noremap = true, silent = true})
vim.keymap.set('n', '<C-S>', '<Esc>:w<CR>', { noremap = true, silent = true})
vim.keymap.set('n', '<C-S>', '<Esc>:w<CR>', { noremap = true, silent = true})

vim.api.nvim_create_autocmd('VimEnter', {
	callback = function ()
		vim.cmd("NvimTreeToggle")
		vim.cmd("SwitchTabs")
	end
})


