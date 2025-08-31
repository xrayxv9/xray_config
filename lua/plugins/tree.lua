return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local api = require("nvim-tree.api")
        local uv = vim.loop

        -- Table pour stocker les fichiers "soft deleted" durant la session
        local soft_deleted_files = {}

        -- Déplace le fichier dans une corbeille temporaire (dans le dossier de données Neovim)
        local function move_to_trash(path)
            local trash_dir = vim.fn.stdpath('data') .. '/nvim_tree_trash'
            vim.fn.mkdir(trash_dir, "p")
            local filename = vim.fn.fnamemodify(path, ':t')
            local dest = trash_dir .. '/' .. filename
            -- Renomme le fichier vers la corbeille
            uv.fs_rename(path, dest)
            table.insert(soft_deleted_files, {orig = path, trash = dest})
        end

        -- Soft delete: déplace le fichier au lieu de le supprimer vraiment
        local function soft_delete(node)
            move_to_trash(node.absolute_path)
            vim.notify("Fichier deplacer dans la corbeille", vim.log.levels.INFO)
        end

        -- Restaure tous les fichiers déplacés (soft undelete)
        local function restore_soft_deleted()
            for _, file in ipairs(soft_deleted_files) do
                -- S'il n'y a pas de conflit, restaure le fichier
                if not uv.fs_stat(file.orig) and uv.fs_stat(file.trash) then
                    uv.fs_rename(file.trash, file.orig)
                end
            end
            -- Vide la liste
            soft_deleted_files = {}
            vim.notify("Tous les fichiers soft-deleted ont été restaurés.", vim.log.levels.INFO)
        end

        -- Supprime définitivement les fichiers de la corbeille temporaire
        local function finalize_soft_delete()
            for _, file in ipairs(soft_deleted_files) do
                if uv.fs_stat(file.trash) then
                    uv.fs_unlink(file.trash)
                end
            end
            soft_deleted_files = {}
        end

        local function my_on_attach(bufnr)
            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- Ouvre/crée un fichier ou dossier
            vim.keymap.set("n", "<C-n>", api.fs.create, opts("Create"))
            -- Change la racine de l'arbre
            vim.keymap.set("n", "<C-CR>", api.tree.change_root_to_node, opts("Change Root to Node"))
            -- Ouvre le fichier/dossier sélectionné
            vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
            vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open with mouse"))
            -- Renomme le fichier/dossier sélectionné
            vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
            -- Soft delete à la place de la suppression réelle
            vim.keymap.set("n", "d", function()
                local node = api.tree.get_node_under_cursor()
                if node and node.absolute_path then
                    soft_delete(node)
                end
            end, opts("Soft Delete (déplaçable/cancelable tant que Neovim n'est pas quitté)"))
            -- Restaure les fichiers soft deleted (undo général)
            vim.keymap.set("n", "u", restore_soft_deleted, opts("Undo all soft deleted"))
        end

        require("nvim-tree").setup({
            on_attach = my_on_attach,
            view = { side = "left", width = 30 },
            renderer = { group_empty = true },
            filters = { dotfiles = false, custom = { "*.o", "*.meta"} },
            git = { enable = true },
        })

        -- Toggle l'explorateur de fichiers
        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

        -- Fonction pour switcher le focus entre NvimTree et le code
        local function toggle_focus()
            if api.tree.is_visible() then
                local curwin = vim.api.nvim_get_current_win()
                local tree_win = nil
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
                    if bufname:match("NvimTree_") then
                        tree_win = win
                        break
                    end
                end
                if tree_win and curwin == tree_win then
                    vim.cmd("wincmd l")
                elseif tree_win then
                    vim.api.nvim_set_current_win(tree_win)
                else
                    api.tree.focus()
                end
            end
        end

        vim.keymap.set("n", "<leader>c", toggle_focus, { desc = "Switch entre NvimTree et code" })

        -- Ferme NvimTree si c'est la dernière fenêtre ouverte
        vim.api.nvim_create_autocmd("BufEnter", {
            nested = true,
            callback = function()
                local api = require("nvim-tree.api")
                if #vim.api.nvim_list_wins() == 1 and api.tree.is_visible() then
                    finalize_soft_delete() -- suppression définitive à la fermeture de Neovim
                    vim.cmd.quit()
                end
            end
        })

        -- Si tu veux supprimer définitivement à chaque fermeture de Neovim (pas juste nvim-tree)
        vim.api.nvim_create_autocmd("VimLeavePre", {
            callback = function()
                finalize_soft_delete()
            end
        })
    end,
}
