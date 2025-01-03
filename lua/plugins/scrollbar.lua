return {
    'petertriho/nvim-scrollbar',
    config = function()
        require('scrollbar').setup({
            handle = {
                color = "#FF5733", -- Couleur personnalisée pour la barre
            },
            marks = {
                Search = { color = "#FFD700" }, -- Marque les résultats de recherche
            },
        })
    end,
}
