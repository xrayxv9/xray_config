return {
    'rafamadriz/friendly-snippets',
    dependencies = {
        'L3MON4D3/LuaSnip',
    },
    config = function()
		require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load()
    end
}


