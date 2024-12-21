return {
    'rafamadriz/friendly-snippets',  -- Plugin pour les snippets
    dependencies = {
        'L3MON4D3/LuaSnip',  -- Dépendance de LuaSnip pour les snippets
    },
    config = function()
        -- Charger LuaSnip
        local ls = require("luasnip")

        -- Charger les snippets depuis friendly-snippets
        require("luasnip.loaders.from_vscode").lazy_load()  -- Charge les snippets de friendly-snippets

        -- Configurer les raccourcis pour l'expansion des snippets
        vim.keymap.set('i', '<C-Space>', function() ls.expand_or_jump() end, { desc = 'Expand or jump in snippet' })
        vim.keymap.set('s', '<C-Space>', function() ls.expand_or_jump() end, { desc = 'Expand or jump in snippet' })
    end
}
