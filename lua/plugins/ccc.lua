return {
    'uga-rosa/ccc.nvim',
    config = function()
        -- Exemple de configuration de ccc.nvim
        local ccc = require("ccc")
        ccc.setup({
            -- Ajoute tes options ici si tu veux personnaliser le comportement
            highlighter = {
                auto_enable = true,
                lsp = true,
            },
        })
    end,
    event = "BufReadPre", -- Charge le plugin lors de l'ouverture d'un fichier
}

