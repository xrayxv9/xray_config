return {
    "stevearc/oil.nvim",
    config = function()
        require("oil").setup({
            -- Options par défaut pour nvim-oil
            view_options = {
                show_hidden = true, -- Affiche les fichiers cachés
            },
            keymaps = {
                [_G.keybinds.oil.confirm] = "actions.select", -- Ouvrir un fichier ou dossier
                [_G.keybinds.oil.quit] = "actions.close", -- Quitter le menu
                [_G.keybinds.oil.refresh] = "actions.refresh", -- Actualiser la vue
            },
        })

        -- Map global pour ouvrir oil avec "-"
        vim.keymap.set("n", _G.keybinds.oil.open_oil, require("oil").open, { desc = "Open parent directory" })
    end,
}

