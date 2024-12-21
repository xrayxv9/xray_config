return {
	{
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = { "c", "lua", "python" ,"css", "cpp", "javascript", "html" },
				auto_install = true,
				highlights = {
					enable = true,
				},
				indent = { enable = true },
			}
		end,
	}
}
