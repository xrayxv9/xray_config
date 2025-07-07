local all_themes = {
  "tokyonight-night", "tokyonight-storm", "tokyonight-day", "tokyonight-moon",
  "catppuccin", "catppuccin-macchiato", "catppuccin-mocha", "catppuccin-frappe", "catppuccin-latte",
  "kanagawa", "kanagawa-wave", "kanagawa-dragon", "kanagawa-lotus",
  "flexoki-dark", "flexoki-light",
  "gruvbox", "gruvbox-light",
  "oxocarbon",
  "moonfly",
  "cyberdream",
  "onedark", "onedark_vivid", "onedark_dark", "onelight", -- variantes onedarkpro
  "onenord",
}

local light_themes = {
  "catppuccin-latte",
  "tokyonight-day",
  "kanagawa-lotus",
  "flexoki-light",
  "gruvbox-light",
  "cyberdream-light",
  "onelight", -- variante claire onedarkpro
}

local dark_themes = {
  "tokyonight-night", "tokyonight-storm", "tokyonight-moon",
  "catppuccin", "catppuccin-macchiato", "catppuccin-mocha", "catppuccin-frappe",
  "kanagawa", "kanagawa-wave", "kanagawa-dragon",
  "flexoki-dark",
  "gruvbox",
  "oxocarbon",
  "moonfly",
  "cyberdream",
  "onedark_vivid", "onedark_dark", -- variantes sombres onedarkpro
	"onenord",
}

local function set_theme(colorscheme)
  vim.cmd.colorscheme(colorscheme)
  local config = vim.fn.stdpath("config") .. "/theme.txt"
  local file = io.open(config, "w")
  if file then
    file:write(colorscheme)
    file:close()
  end
end

local function pick_theme(themes, prompt)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = prompt or "Choisis ton thème",
    finder = finders.new_table { results = themes },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      local previewed = nil
      local function preview()
        local selection = action_state.get_selected_entry()
        if selection and selection[1] ~= previewed then
          pcall(vim.cmd.colorscheme, selection[1])
          previewed = selection[1]
        end
      end
      -- Preview sur flèches (insert + normal)
      map("i", "<Down>", function() require("telescope.actions").move_selection_next(prompt_bufnr); preview() end)
      map("i", "<Up>", function() require("telescope.actions").move_selection_previous(prompt_bufnr); preview() end)
      map("n", "<Down>", function() require("telescope.actions").move_selection_next(prompt_bufnr); preview() end)
      map("n", "<Up>", function() require("telescope.actions").move_selection_previous(prompt_bufnr); preview() end)

      -- Valider le choix
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then set_theme(selection[1]) end
      end)
      return true
    end,
  }):find()
end

vim.api.nvim_create_user_command("ThemePicker", function() pick_theme(all_themes, "Choisis ton thème") end, {})
vim.api.nvim_create_user_command("ThemePickerLight", function() pick_theme(light_themes, "Thèmes lumineux") end, {})
vim.api.nvim_create_user_command("ThemePickerDark", function() pick_theme(dark_themes, "Thèmes sombres") end, {})

vim.keymap.set("n", "<leader>a", ":ThemePicker<CR>", { desc = "Menu de sélection de thème" })
vim.keymap.set("n", "<leader>l", ":ThemePickerLight<CR>", { desc = "Thèmes lumineux" })
vim.keymap.set("n", "<leader>d", ":ThemePickerDark<CR>", { desc = "Thèmes sombres" })

-- Recharge le dernier thème choisi APRES que LazyVim ait chargé les plugins
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    local config = vim.fn.stdpath("config") .. "/theme.txt"
    local file = io.open(config, "r")
    if file then
      local theme = file:read("*l")
      if theme then
        pcall(function() vim.cmd.colorscheme(theme) end)
      end
      file:close()
    end
  end,
})

local function set_theme(colorscheme)
  vim.cmd.colorscheme(colorscheme)
  local config = vim.fn.stdpath("config") .. "/theme.txt"
  local file = io.open(config, "w")
  if file then
    file:write(colorscheme)
    file:close()
  end
end

local function pick_theme(themes, prompt)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = prompt or "Choisis ton thème",
    finder = finders.new_table { results = themes },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      local previewed = nil
      local function preview()
        local selection = action_state.get_selected_entry()
        if selection and selection[1] ~= previewed then
          pcall(vim.cmd.colorscheme, selection[1])
          previewed = selection[1]
        end
      end
      -- Preview sur flèches (insert + normal)
      map("i", "<Down>", function() require("telescope.actions").move_selection_next(prompt_bufnr); preview() end)
      map("i", "<Up>", function() require("telescope.actions").move_selection_previous(prompt_bufnr); preview() end)
      map("n", "<Down>", function() require("telescope.actions").move_selection_next(prompt_bufnr); preview() end)
      map("n", "<Up>", function() require("telescope.actions").move_selection_previous(prompt_bufnr); preview() end)

      -- Valider le choix
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then set_theme(selection[1]) end
      end)
      return true
    end,
  }):find()
end

vim.api.nvim_create_user_command("ThemePicker", function() pick_theme(all_themes, "Choisis ton thème") end, {})
vim.api.nvim_create_user_command("ThemePickerLight", function() pick_theme(light_themes, "Thèmes lumineux") end, {})
vim.api.nvim_create_user_command("ThemePickerDark", function() pick_theme(dark_themes, "Thèmes sombres") end, {})

vim.keymap.set("n", "<leader>a", ":ThemePicker<CR>", { desc = "Menu de sélection de thème" })
vim.keymap.set("n", "<leader>l", ":ThemePickerLight<CR>", { desc = "Thèmes lumineux" })
vim.keymap.set("n", "<leader>d", ":ThemePickerDark<CR>", { desc = "Thèmes sombres" })

-- Recharge le dernier thème choisi APRES que LazyVim ait chargé les plugins
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    local config = vim.fn.stdpath("config") .. "/theme.txt"
    local file = io.open(config, "r")
    if file then
      local theme = file:read("*l")
      if theme then
        pcall(function() vim.cmd.colorscheme(theme) end)
      end
      file:close()
    end
  end,
})
