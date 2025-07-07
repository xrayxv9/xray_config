return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local function my_on_attach(bufnr)
            local api = require("nvim-tree.api")

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- Remapping personnalisé
            vim.keymap.set("n", "<C-n>", api.fs.create, opts("Create"))
            vim.keymap.set("n", "<C-CR>", api.tree.change_root_to_node, opts("Change Root to Node"))

            -- Restaure le comportement par défaut de `Enter`
            vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
            vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
            vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open with mouse"))

            -- Remaps pour ajuster dynamiquement la largeur (NOUVELLE API)
            vim.keymap.set("n", "<C-Right>", function()
                local view = require("nvim-tree.view")
                if view.is_visible() then
                    local cur_width = view.get_view_width and view.get_view_width() or 30
                    local new_width = cur_width + 5
                    require("nvim-tree.api").tree.resize(new_width)
                end
            end, opts("Increase Width"))

            vim.keymap.set("n", "<C-Left>", function()
                local view = require("nvim-tree.view")
                if view.is_visible() then
                    local cur_width = view.get_view_width and view.get_view_width() or 30
                    local new_width = math.max(cur_width - 5, 10)
                    require("nvim-tree.api").tree.resize(new_width)
                end
            end, opts("Decrease Width"))
        end

        require("nvim-tree").setup({
            on_attach = my_on_attach,
            view = {
                side = "left",
                width = 30,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
                custom = { "*.o", "*.meta"},
            },
            git = {
                enable = true,
            },
        })

        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

        -- Switch focus entre nvim-tree et code (API à jour)
        local function toggle_focus()
            local view = require("nvim-tree.view")
            if view.is_visible() then
                if vim.api.nvim_get_current_win() == view.get_winnr() then
                    vim.cmd("wincmd l")
                else
                    vim.cmd("wincmd p")
                end
            end
        end

        vim.keymap.set("n", "<leader>c", toggle_focus, { desc = "Switch entre NvimTree et code" })
    end,
}
