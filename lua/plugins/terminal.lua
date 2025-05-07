return {
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({
            size = 20,
            open_mapping = [[<C-t>]], -- Raccourci pour ouvrir/fermer le terminal
            direction = "float",     -- Peut être "vertical", "horizontal", ou "float"
        })
    end,
}

