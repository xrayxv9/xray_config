return {
  "nvim-telescope/telescope.nvim",
  config = function()
    local builtin = require('telescope.builtin')

    -- Clés de raccourcis existantes
    vim.keymap.set('n', vim.g.keybinds.telescope.see_files, builtin.find_files, {})

    -- Configuration de Telescope avec ripgrep pour la recherche
    require('telescope').setup{
      defaults = {
        -- Configuration de ripgrep pour la recherche dans les fichiers
        vimgrep_arguments = {
          'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column',
          '--smart-case'
        },
        -- Exclure certains dossiers de la recherche, par exemple node_modules, .git
        file_ignore_patterns = { "node_modules", ".git/*", "*.min.js", "*.lock" },
      },
    }

    -- Lier le raccourci Ctrl+f à la fonction live_grep avec Telescope
    vim.keymap.set('n', vim.g.keybinds.telescope.ctrl_f, '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
  end
}
