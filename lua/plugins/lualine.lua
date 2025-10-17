return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
			},
			  sections = {
				lualine_a = {'mode'},
				lualine_b = {'branch', 'diagnostics'},
				lualine_c = {'filename'},
				lualine_x = {'filetype'},
				lualine_z = {'location'}
			},
		})
	end,
}
