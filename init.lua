require("xray")
require('move').setup({})
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Q', 'q!', {})
vim.api.nvim_create_user_command('X', 'x', {})

vim.g.layout = vim.fn.system("setxkbmap -query | grep layout | awk '{print $2}' | cut -d',' -f2")
vim.g.layout = vim.trim(vim.g.layout)

if vim.g.layout == "us" then
	-- permet de se deplacer rapidement dans une ligne
	vim.keymap.set('i', '<C-4>', '<Esc>$i', { noremap = true, silent = true })
	vim.keymap.set('n', '<C-4>', '<Esc>$', { noremap = true, silent = true })
	vim.keymap.set('i', '<C-3>', '<Esc>^i', { noremap = true, silent = true })
	vim.keymap.set('n', '<C-3>', '<Esc>^', { noremap = true, silent = true })

	-- creer un main a la norme en C
	vim.keymap.set({'n', 'v', 'i'}, '<C-m>', '<Esc>:Stdheader<CR>i\n#include <unistd.h>\n\nint	main(int ac, char *av[])\n{\n(void)av;\n\tif (ac < 2)\n\t\twrite(1, "please give me an argument\\n", 27);\n\treturn (0);\n}', { noremap = true, silent = true })

	-- permet de mettre le header 42
	vim.api.nvim_set_keymap('n', '<leader>11', ':Stdheader<CR>', { noremap = true, silent = true })

else

	-- permet de se deplacer rapidement dans une ligne
	vim.keymap.set('i', '<C-\'>', '<Esc>$i', { noremap = true, silent = true })
	vim.keymap.set('n', '<C-\'>', '<Esc>$', { noremap = true, silent = true })
	vim.keymap.set('i', '<C-\">', '<Esc>^i', { noremap = true, silent = true })
	vim.keymap.set('n', '<C-\">', '<Esc>^', { noremap = true, silent = true })

	-- creer un main a la norme en C
	vim.keymap.set({'n', 'v', 'i'}, '<C-&>', '<Esc>:Stdheader<CR>i\n#include <unistd.h>\n\nint	main(int argc, char *argv[])\n{\n(void)argv;\n\tif (argc < 2)\n\t\twrite(1, "please give me an argument\\n", 27);\n\treturn (0);\n}', { noremap = true, silent = true })

	-- permet de mettre le header 42
	vim.api.nvim_set_keymap('n', '<leader>&&', ':Stdheader<CR>', { noremap = true, silent = true })
end

vim.keymap.set('i', '<C-S>', '<Esc>:w<CR>i', { noremap = true, silent = true})
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>i', { noremap = true, silent = true})
vim.keymap.set('n', '<C-S>', '<Esc>:w<CR>', { noremap = true, silent = true})
vim.keymap.set('n', '<C-S>', '<Esc>:w<CR>', { noremap = true, silent = true})


