return {
	"mbbill/undotree",
	event = "InsertEnter",
	config = function()
		vim.keymap.set("n", _G.keybinds.undo_tree.ouvrir_fermer, vim.cmd.UndotreeToggle)
	end
}

