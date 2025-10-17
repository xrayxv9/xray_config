return {
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({
            size = 20,
            open_mapping = [[<C-t>]], -- Terminal flottant
            direction = "float",
        })

        -- Terminal type "bottom" (comme VS Code)
        local Terminal = require("toggleterm.terminal").Terminal
        local bottom_term = Terminal:new({
            direction = "horizontal", -- split horizontal (en bas)
        })

        -- Keymap pour ouvrir/fermer le terminal "bottom" avec <C-o>
        vim.api.nvim_set_keymap("n", _G.keybinds.terminal.vs_terminal, "<cmd>lua require('toggleterm.terminal').Terminal:new({direction='horizontal'}):toggle()<CR>", { noremap = true, silent = true })

		vim.api.nvim_create_user_command("VsTerminal", function()
		  require('toggleterm.terminal').Terminal:new({direction='horizontal'}):toggle()
		end, {})
    end,
}
