return {
    "stevearc/oil.nvim",
    config = function()
        require("oil").setup({
            -- Options par défaut pour nvim-oil
            view_options = {
                show_hidden = true, -- Affiche les fichiers cachés
            },
            keymaps = {
                [vim.g.keybinds.oil.open_oil] = "actions.parent", -- Permet de revenir au dossier parent
                [vim.g.keybinds.oil.confirm] = "actions.select", -- Ouvrir un fichier ou dossier
                [vim.g.keybinds.oil.quit] = "actions.close", -- Quitter le menu
                [vim.g.keybinds.oil.refresh] = "actions.refresh", -- Actualiser la vue
            },
        })

        -- Map global pour ouvrir oil avec "-"
        vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
    end,
}

