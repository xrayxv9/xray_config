local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"

-- downloads lazyvim if it doesn't exists

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.lsp.config("lua_ls",{
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "system" }
			},
			workspace = {
				library = {
					[vim.fn.expand("~/.config/nvim/nvim-api")] = true,
				},
				checkThirdParty = false,
			}
		}
	}
})


vim.opt.rtp:prepend(lazypath)

require("xray.remap")
-- require("xray.easy_remap").save_datas()
vim.g.keybinds = require("xray.easy_remap").read_datas()
require("xray.set")
require("lazy").setup({
    { import = "plugins" },
    { import = "plugins.themes" },
}, {
    change_detection = {
        notify = false,
    },
})
require("xray.theme_picker")
require("xray.help_page")


vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Shows what has been copied when doing yy',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.o.clipboard = "unnamedplus"
vim.o.updatetime = 400


vim.diagnostic.config({
	virtual_text = false,  -- ne pas afficher inline
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		focusable = true,
		show_header = true,
		source = "always",
		border = "rounded",
	},
	signs = {
		text ={
			  [vim.diagnostic.severity.ERROR] = "🔴",
			  [vim.diagnostic.severity.WARN]  = "🟠",
			  [vim.diagnostic.severity.INFO]  = "🔵",
			  [vim.diagnostic.severity.HINT]  = "🟢",
		},
	},
})

-- Affiche le popup d'erreur LSP quand le curseur reste sur une ligne avec erreur
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end
})


local norminette_state_file = vim.fn.stdpath("data") .. "/norminette_state.txt"

local function read_norminette_state()
  local f = io.open(norminette_state_file, "r")
  if f then
    local state = f:read("*l")
    f:close()
    return state == "1"
  end
  return true -- actif par défaut
end

local function write_norminette_state(state)
  local f = io.open(norminette_state_file, "w")
  if f then
    f:write(state and "1" or "0")
    f:close()
  end
end

vim.g.norminette_active = read_norminette_state()

if vim.g.norminette_active then
	vim.cmd(":NorminetteEnable")
else
	vim.cmd(":NorminetteDisable")
end

vim.keymap.set("n", vim.g.keybinds.fourty_two.norminette_enable, function()
  vim.g.norminette_active = not vim.g.norminette_active
  write_norminette_state(vim.g.norminette_active)
  if vim.g.norminette_active then
		vim.cmd(":NorminetteEnable")
		print("Norminette activée")
  else
		vim.cmd(":NorminetteDisable")
    print("Norminette désactivée")
  end
end, { desc = "Toggle norminette42.nvim" })

