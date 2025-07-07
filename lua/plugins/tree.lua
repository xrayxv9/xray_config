return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local api = require("nvim-tree.api")

        local function my_on_attach(bufnr)
            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            vim.keymap.set("n", "<C-n>", api.fs.create, opts("Create"))
            vim.keymap.set("n", "<C-CR>", api.tree.change_root_to_node, opts("Change Root to Node"))
            vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
            vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
            vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open with mouse"))
            vim.keymap.set("n", "<C-Right>", function()
                if api.tree.is_visible() then api.tree.resize("+5") end
            end, opts("Increase Width"))
            vim.keymap.set("n", "<C-Left>", function()
                if api.tree.is_visible() then api.tree.resize("-5") end
            end, opts("Decrease Width"))
        end

        require("nvim-tree").setup({
            on_attach = my_on_attach,
            view = { side = "left", width = 30 },
            renderer = { group_empty = true },
            filters = { dotfiles = false, custom = { "*.o", "*.meta"} },
            git = { enable = true },
        })

        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

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
                    vim.cmd.quit()
                end
            end
        })
    end,
}
