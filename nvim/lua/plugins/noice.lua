return {
  "folke/noice.nvim",
  event = "VeryLazy",  -- Charge le plugin une fois que l'événement VeryLazy se produit
  config = function()
    require("noice").setup({
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,  -- Nécessite hrsh7th/nvim-cmp
        },
      },
      presets = {
        bottom_search = true, -- Utiliser une commande classique en bas pour la recherche
        command_palette = true, -- Positionner le cmdline et popupmenu ensemble
        long_message_to_split = true, -- Les messages longs seront envoyés dans un split
        inc_rename = false, -- Active le dialogue d'entrée pour inc-rename.nvim
        lsp_doc_border = false, -- Ajouter une bordure aux documents de survol et à l'aide de signature
      },
      -- Ajouter une route pour filtrer les messages "written"
      routes = {
        {
          filter = {
            event = "msg_show", -- Filtrer les messages affichés
            kind = "",
            find = "written", -- Rechercher les messages contenant "written"
          },
          opts = { skip = true }, -- Ignorer ces messages
        },
      },
    })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",  -- Dépendance nécessaire pour Noice
    "rcarriga/nvim-notify",  -- Dépendance optionnelle pour les notifications (si utilisé)
  },
}

