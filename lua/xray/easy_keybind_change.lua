local show_cathegories
local json = require("xray.dkjson")

local HOME = os.getenv("HOME")
local PATH = HOME .. "/.local/share/nvim/keybinds.json"


local function change_datas()
	local file = io.open(PATH, "w")

	if file then
		local encoded_contents = json.encode(_G.keybinds)
		file:write(encoded_contents)
		file:close()
		return true
	else
		return false
	end
end


local function check_doubles(command)
	for index, _ in pairs(_G.keybinds) do
		for index2, _ in pairs(_G.keybinds[index]) do
			if _G.keybinds[index][index2] == command then
				return nil
			end
		end
	end
	return true
end


local function change_mapping(cat)
	local picker = require('telescope.pickers')
	local finder = require('telescope.finders')
	local conf = require('telescope.config')
	local actions = require('telescope.actions')
	local actions_state = require('telescope.actions.state')
	local cathegories = {}

	for index, _ in pairs(_G.keybinds[cat]) do
		table.insert(cathegories, index)
	end

	picker.new({},{
		prompt_title = ("change cathegorie"),
		finder = finder.new_table {
			results = cathegories
		},
		sorter = conf.values.generic_sorter({}),

		attach_mappings = function (_, _)
			actions.select_default:replace(function (prompt)
				local selection = actions_state.get_selected_entry()
				local val =vim.fn.input("Enter new shortcut (Control = <C>, leader = ' ' max 2 touches)")
				local result = check_doubles(val)
				if result == nil then
					vim.notify("There is a double, you can check here : ~/.local/share/nvim/keybinds.json")
				else
					_G.keybinds[cat][selection[1]] = val
					change_datas()
				end
				show_cathegories()
			end)
			return true
		end,
	}):find()
end

show_cathegories = function ()
	local picker = require('telescope.pickers')
	local finder = require('telescope.finders')
	local conf = require('telescope.config')
	local actions = require('telescope.actions')
	local actions_state = require('telescope.actions.state')
	local cathegories = {}

	for index, _ in pairs(_G.keybinds) do
		table.insert(cathegories, index)
	end

	picker.new({},{
		prompt_title = ("change cathegory"),
		finder = finder.new_table {
			results = cathegories
		},
		sorter = conf.values.generic_sorter({}),

		attach_mappings = function (_, _)
			actions.select_default:replace(function (prompt)
				local selection = actions_state.get_selected_entry()
				change_mapping(selection[1])
			end)
			return true
		end,
	}):find()
end

vim.api.nvim_create_user_command("Keybinds", show_cathegories, {})
vim.keymap.set("n", "<c-.>", ":Keybinds<cr>", { desc = "shortcuts (leader = space)" })
