return {
    "stevearc/oil.nvim",
    config = function()
        require("oil").setup({
            -- Options par défaut pour nvim-oil
            view_options = {
                show_hidden = true, -- Affiche les fichiers cachés
            },
            keymaps = {
                ["-"] = "actions.parent", -- Permet de revenir au dossier parent
                ["<CR>"] = "actions.select", -- Ouvrir un fichier ou dossier
                ["q"] = "actions.close", -- Quitter le menu
                ["<C-r>"] = "actions.refresh", -- Actualiser la vue
            },
        })

        -- Map global pour ouvrir oil avec "-"
        vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
    end,
}

