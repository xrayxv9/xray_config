local json = require("xray.dkjson")

local HOME = os.getenv("HOME")
local PATH = HOME .. "/.local/share/nvim/keybinds.json"
local json_file = {}

json_file.save_datas = function ()
	local file = io.open(PATH, "w")

	if file then
		local content = {
			color_scheme = {
				light = '<leader>l',
				dark = '<leader>d',
				all = '<leader>a '
			},
			fourty_two = {
				header = '<leader>11',
				main = '<C-m>',
				norminette_enable = '<C-n>',
			},
			buffer_file = {
				move_right = '<C-Right>',
				move_left = '<C-Left>',
				close = '<C-w>',
				hide_show = '<C-b>',
			},
			comment = {
				comment = '<c-\\>',
			},
			lsp = {
				move_bot = '<Down>',
				move_up = '<Up>',
				confirm = '<C-y>',
				secondary_confirm = '<CR>',
			},
			move_line = {
				move_line_up_visual = '<A-Up>',
				move_line_down_visual = '<A-Down>',
				move_line_up_normal = '<A-Up>',
				move_line_down_normal = '<A-Downp>',
			},
			oil = {
				quit = 'q',
				confirm = '<CR>',
				open_oil = '-',
				refresh = '<C-r>',
			},
			telescope = {
				see_files = '<leader>ff',
				ctrl_f = '<C-f>',
			},
			terminal = {
				pop_up = '<C-t>',
				vs_terminal = '<C-o>',
			},
			tree = {
				ouvrir_fermer = '<leader>e',
				switch_tabs = '<leader>c',
				rename_file = 'r',
				delete_file = 'd',
				undo = 'u',
				create_file = 'n',
				confirm = '<CR>'
			},
			undo_tree = {
				ouvrir_fermer = '<leader>u',
			},
		}
		local encoded_contents = json.encode(content)
		file:write(encoded_contents)
		file:close()
		return true
	else
		return false
	end
end

json_file.read_datas = function ()
	local file = io.open(PATH, "r")

	if file then
		local encoded_result = file:read("a")
		local content = json.decode(encoded_result)
		file:close()
		return content, encoded_result
	else
		json_file.save_datas()
		return json_file.read_datas()
	end
end

return json_file
