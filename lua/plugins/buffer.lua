return {
    {
        "akinsho/bufferline.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- Pour des icônes
        config = function()
            -- Setup de bufferline
            require("bufferline").setup({
                options = {
                    show_buffer_icons = true,
                    separator_style = "slant", -- Séparateurs inclinés
                    diagnostics = "nvim_lsp", -- Affichage des diagnostics LSP
                    always_show_bufferline = false, -- Masque la barre quand il n'y a qu'un seul buffer
                }
            })

            -- Mappage pour naviguer entre les buffers avec Ctrl + Flèche droite et gauche
            vim.api.nvim_set_keymap("n", "<C-Right>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })  -- Aller au buffer suivant
            vim.api.nvim_set_keymap("n", "<C-Left>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })  -- Aller au buffer précédent

            -- Fermer un buffer avec Ctrl+W sans confirmation et passer au suivant
            vim.api.nvim_set_keymap("n", "<C-w>", ":bdelete!<CR>:BufferLineCycleNext<CR>", { noremap = true, silent = true })
        end,
    },
}

