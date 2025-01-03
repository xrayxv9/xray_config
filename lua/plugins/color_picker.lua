return {
    'KabbAmine/vCoolor.vim',
    config = function()
        -- Spécifie l'outil externe si nécessaire
        vim.g.vcoolor_tool = "gcolor2" -- Change selon l'outil disponible
    end,
    cmd = "VCoolor", -- Charge uniquement avec :VCoolor
    keys = {
        { "<leader>vc", ":VCoolor<CR>", desc = "Ouvrir vCoolor Color Picker" },
    },
}
