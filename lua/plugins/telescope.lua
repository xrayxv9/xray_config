return {
	"nvim-telescope/telescope.nvim",
	config = function()
	local builtin = require('telescope.builtin')
		vim.keymap.set('n', _G.keybinds.telescope.see_files, builtin.find_files, {})
		require('telescope').setup{
		defaults = {
			vimgrep_arguments = {
				'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column',
				'--smart-case'
			},
			file_ignore_patterns = { "node_modules", ".git/*", "*.min.js", "*.lock" },
			},
		}

		vim.keymap.set('n', _G.keybinds.telescope.ctrl_f, '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
	end
}
