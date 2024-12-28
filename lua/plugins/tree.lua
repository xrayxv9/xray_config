return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- Icônes pour les fichiers
    },
    config = function()
        -- Fonction qui définit les remappings
        local function my_on_attach(bufnr)
            local api = require("nvim-tree.api")
            local view = require("nvim-tree.view")

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- Remapping personnalisé
            vim.keymap.set("n", "<C-n>", api.fs.create, opts("Create"))
            vim.keymap.set("n", "<C-CR>", api.tree.change_root_to_node, opts("Change Root to Node"))

            -- Restaure le comportement par défaut de `Enter`
            vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
            vim.keymap.set("n", "o", api.node.open.edit, opts("Open")) -- Optionnel : o comme alias
            vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open with mouse"))

            -- Remaps pour ajuster dynamiquement la largeur
            vim.keymap.set("n", "<C-Right>", function()
                if view.is_visible() then
                    local width = view.View.width
                    view.View.width = width + 5 -- Augmente de 5 colonnes
                    view.resize()
                end
            end, opts("Increase Width"))

            vim.keymap.set("n", "<C-Left>", function()
                if view.is_visible() then
                    local width = view.View.width
                    view.View.width = math.max(width - 5, 10) -- Diminue de 5 colonnes, minimum 10
                    view.resize()
                end
            end, opts("Decrease Width"))
        end

        require("nvim-tree").setup({
            on_attach = my_on_attach, -- Attache les remaps personnalisés
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

        -- Fonction pour basculer entre `nvim-tree` et la fenêtre de code
        local function toggle_focus()
            local view = require("nvim-tree.view")
            if view.is_visible() then
                if vim.api.nvim_get_current_win() == view.get_winnr() then
                    -- Si `nvim-tree` est actif, passe à la fenêtre de code
                    vim.cmd("wincmd l")
                else
                    -- Sinon, passe à `nvim-tree`
                    vim.cmd("wincmd p")
                end
            end
        end

        -- Mapping pour basculer avec `<leader>c`
        vim.keymap.set("n", "<leader>c", toggle_focus, { desc = "Switch entre NvimTree et code" })
    end,
}

