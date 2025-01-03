return {
    'yamatsum/nvim-cursorline',
    config = function()
        require('nvim-cursorline').setup({
            cursorline = {
                enable = true, -- Active la surbrillance de la ligne
                timeout = 500, -- Délai avant l'apparition
                number = false, -- Pas besoin de mettre en évidence les numéros
            },
            cursorword = {
                enable = true, -- Mots sous le curseur
                min_length = 3, -- Mots de longueur minimum 3
                hl = { underline = true }, -- Ajoute un soulignement
            },
        })
    end,
}

