-- Organize shortcuts by category
local my_shortcuts = {
  {
    category = "Telescope",
    name = "File preview",
    key = _G.keybinds.telescope.see_files,
    desc = "Shows a preview of all the files in the current directory",
    action = function() require('telescope.builtin').find_files() end,
  },
  {
    category = "Telescope",
    name = "Live Grep",
    key = _G.keybinds.telescope.ctrl_f,
    desc = "Finds a word in all the files on the current directory (ripgrep is needed)",
    action = function() require('telescope.builtin').live_grep() end,
  },
  {
    category = "Tree",
    name = "Tree Toggle",
    key = _G.keybinds.tree.ouvrir_fermer,
    desc = "Opens / Closes the nvim-tree file explorer",
    action = function() vim.cmd("NvimTreeToggle") end,
  },
	{
		category = "Tree",
		name = "Create file",
		key = _G.keybinds.tree.create_file,
		desc = "Creates a new file on the Tree",
	    action = nil,
	},
	{
		category = "Tree",
		name = "Safe remove",
		key = _G.keybinds.delete_file,
		desc = "Removes a file on the Tree",
		action = nil,
	},
	{
		category = "Tree",
		name = "Safe remove undo",
		key = _G.keybinds.tree.undo,
		desc = "Undo a safe removal of a file",
		action = nil,
	},
	{
		category = "Tree",
		name = "Rename",
		key = _G.keybinds.tree.rename_file,
		desc = "Rename a file on the tree",
		action = nil,
	},
	{
		category = "Tree",
		name = "Switch",
		key = _G.keybinds.tree.switch_tabs,
		desc = "Switches from code to Tree and vis versa",
		action = nil,
	},
	{
		category = "Oil",
		name = "Open oil",
		key = _G.keybinds.oil.open_oil,
		desc = "Opens a file that acts like a normal file but impact your hierarchie",
		action = function () vim.cmd("Oil") end,
	},
	{
		category = "Themes",
		name = "All Themes",
		key = _G.keybinds.color_scheme.all,
		desc = "Opens the menu to change through all the themes available",
		action = function () vim.cmd("ThemePicker") end,
	},
	{
		category = "Themes",
		name = "Light Themes",
		key = _G.keybinds.color_scheme.light,
		desc = "Opens the menu to change through all light themes available",
		action = function () vim.cmd("ThemePickerLight") end,
	},
	{
		category = "Themes",
		name = "Dark Themes",
		key = _G.keybinds.color_scheme.dark,
		desc = "Opens the menu to change through all Dark themes available",
		action = function () vim.cmd("ThemePickerDark") end,
	},
	{
		category = "Terminal",
		name = "basic",
		key = _G.keybinds.terminal.pop_up,
		desc = "Opens a terminal on the center of the sceen",
		action = function () vim.cmd("ToggleTerm") end,
	},
	{
		category = "Terminal",
		name = "Vs Terminal",
		key = _G.keybinds.terminal.vs_terminal,
		desc = "Opens a terminal on the botom of the screen like VsCode",
		action = function () vim.cmd("VsTerminal") end
	},
	{
		category = "Opened File",
		name = "Show files",
		key = _G.keybinds.buffer_file.hide_show,
		desc = "Shows all the currently opened buffers",
		action = nil
	},
	{
		category = "Opened File",
		name = "Change file Right",
		key = _G.keybinds.buffer_file.right,
		desc = "switch to the right file",
		action = nil
	},
	{
		category = "Opened File",
		name = "Change file Left",
		key = _G.keybinds.buffer_file.right,
		desc = "switch to the left file",
		action = nil
	},
	{
		category = "Opened File",
		name = "Close file",
		key = _G.keybinds.buffer_file.close,
		desc = "On normal mode, close the current file",
		action = nil
	},
	{
		category = "42",
		name = "header",
		key = _G.keybinds.fourty_two.header,
		desc = "put the 42 Header",
		action = nil
	},
	{
		category = "42",
		name = "norm",
		key = _G.keybinds.fourty_two.norminette_enable,
		desc = "stops the norminette from running",
		action = nil
	},
	{
		category = "other",
		name = "comment",
		key = _G.keybinds.comment.comment,
		desc = "comments the current line.s",
		action = nil
	},
	{
		category = "other",
		name = "autocomplete",
		key = _G.keybinds.lsp.confirm .. " " .. _G.keybinds.lsp.secondary_confirm,
		desc = "autocomplete depending on the currently selected one",
		action = nil
	},
	{
		category = "42",
		name = "main",
		key = _G.keybinds.fourty_two.main,
		desc = "Creates a main in C with argc, argv and norm friendly",
		action = nil
	}
}

-- Helper: get all unique categories
local function get_categories()
  local cats, seen = {}, {}
  for _, s in ipairs(my_shortcuts) do
    if s.category and not seen[s.category] then
      table.insert(cats, s.category)
      seen[s.category] = true
    end
  end
  table.sort(cats)
  return cats
end

-- Show shortcuts picker for a given category
local function show_shortcuts_picker_for_category(category)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local shortcuts = {}
  for _, s in ipairs(my_shortcuts) do
    if s.category == category then table.insert(shortcuts, s) end
  end

  pickers.new({}, {
    prompt_title = ("Shortcuts: %s (leader = space)"):format(category),
    finder = finders.new_table {
      results = shortcuts,
      entry_maker = function(entry)
        return {
          value = entry,
          display = function(item)
            return string.format("%-18s", item.value.name)
          end,
          ordinal = entry.name .. " " .. entry.key .. " " .. entry.desc,
        }
      end
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection and selection.value and selection.value.action then
          selection.value.action()
        end
      end)
      return true
    end,
    previewer = require("telescope.previewers").new_buffer_previewer {
      define_preview = function(self, entry, status)
        local lines = {}
        table.insert(lines, "Name       : " .. entry.value.name)
        table.insert(lines, "Shortcut   : " .. entry.value.key)
        table.insert(lines, "Description: " .. entry.value.desc)
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
      end
    },
  }):find()
end

-- Top-level picker: select the category first
local function show_category_picker()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local categories = get_categories()

  pickers.new({}, {
    prompt_title = "Shortcuts Categories (leader = space)",
    finder = finders.new_table { results = categories },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          show_shortcuts_picker_for_category(selection[1])
        end
      end)
      return true
    end,
  }):find()
end

vim.api.nvim_create_user_command("ShortcutsPalette", show_category_picker, {})

vim.keymap.set("n", "<C-h>", ":ShortcutsPalette<CR>", { desc = "Shortcuts (leader = space)" })
