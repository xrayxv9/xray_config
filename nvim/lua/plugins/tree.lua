return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- Icônes pour les fichiers
    },
    config = function()
        require("nvim-tree").setup({
            view = {
                side = "left", -- Affiche l'arbre sur le côté gauche
                width = 30,    -- Largeur de la fenêtre
            },
            renderer = {
                group_empty = true, -- Groupe les dossiers vides
            },
            filters = {
                dotfiles = false, -- Affiche les fichiers cachés (.git, etc.)
            },
            git = {
                enable = true, -- Affiche l'état Git
            },
        })

        -- Mapping pour ouvrir/fermer l'explorateur de fichiers
        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

        -- Fonctions pour ajuster la largeur de l'explorateur
        local function increase_width()
            local view = require("nvim-tree.view")
            if view.is_visible() then
                local width = require("nvim-tree.view").View.width
                require("nvim-tree.view").View.width = width + 5 -- Augmente de 5 colonnes
                view.resize() -- Applique la nouvelle largeur
            end
        end

        local function decrease_width()
            local view = require("nvim-tree.view")
            if view.is_visible() then
                local width = require("nvim-tree.view").View.width
                require("nvim-tree.view").View.width = math.max(width - 5, 10) -- Diminue de 5 colonnes, minimum 10
                view.resize() -- Applique la nouvelle largeur
            end
        end

        -- Remaps pour ajuster dynamiquement la largeur
        vim.keymap.set("n", "<C-Right>", increase_width, { desc = "Agrandir la largeur de NvimTree" })
        vim.keymap.set("n", "<C-Left>", decrease_width, { desc = "Réduire la largeur de NvimTree" })
    end,
}

