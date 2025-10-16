return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        -- local api = require("nvim-tree.api")
		Deleted_files = {}
		Opened = false
            -- vim.keymap.set("n", _G.keybinds.tree.create_file, api.fs.create, opts("Create"))
		vim.keymap.set("n", _G.keybinds.tree.ouvrir_fermer, "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

        require("nvim-tree").setup({
			on_attach = function(buf)
				local api = require('nvim-tree.api')
				api.config.mappings.default_on_attach(buf)

				local function create_folder(full_name)
					vim.fn.mkdir(full_name, "p")
				end

				local function create_file()
					local file = api.tree.get_node_under_cursor()
					local path = vim.fn.fnamemodify(file.absolute_path, ":h")
					local value = vim.fn.input(file.type .. "  : ")
					local full_name
					if file.type == "directory" then
						full_name = file.absolute_path .. "/" .. value
					else
						full_name = path .. "/" .. value
					end

					if value:sub(-1) == '/' then
						create_folder(full_name)
						return false
					end
					if vim.fn.filereadable(full_name) or vim.fn.isdirectory(full_name) then
						local new_file = io.open(full_name, "w")
						if new_file then
							new_file:close()
						else
							print("Error while creating the file !")
						end
					else
						print("This name is already in use")
					end
				end

				local function delete_modify()
					local file = api.tree.get_node_under_cursor()
					local result = vim.fn.input("Do you really want to remove this file ? (y/n): ")
					if result == 'y' or result == 'Y' then
						table.insert(Deleted_files, file.absolute_path)
						os.rename(file.absolute_path, file.absolute_path .. ".deleted")
					else
						return false
					end
				end

				local function undo_delete()
					if next(Deleted_files) == nil then
						print("Nothing to undo")
						return false
					else
						os.rename(Deleted_files[#Deleted_files] .. ".deleted", Deleted_files[#Deleted_files])
						table.remove(Deleted_files, #Deleted_files)
					end
				end
				vim.keymap.set('n', _G.keybinds.tree.delete_file, delete_modify, { buffer = buf })
				vim.keymap.set('n', _G.keybinds.tree.undo, undo_delete, { buffer = buf })
				vim.keymap.set('n', _G.keybinds.tree.create_file, create_file, { buffer = buf })
				vim.keymap.set('n', _G.keybinds.tree.switch_tabs, function ()
					if api.tree.is_visible() then
						for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
							if vim.api.nvim_get_current_buf() == buffer then
								vim.cmd("wincmd p")
								return true
							end
						end
						vim.cmd("NvimTreeFocus")
					end
				end)
			end,
            view = { side = "left", width = 30 },
            renderer = { group_empty = true },
            filters = { dotfiles = false, custom = { "*.o", "*.meta"} },
            git = { enable = true },
        })
    end,
}
