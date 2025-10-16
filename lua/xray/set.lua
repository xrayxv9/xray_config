-- put the numbers to the left plus the relative numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- put the right tab size
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- put correctly the indents
vim.opt.smartindent = true

-- when doing a word search in the file, the searched word won't remain highlighted
vim.opt.hlsearch = false

-- highlight the line where you are
vim.opt.cursorline = true

-- Allors to undo even when the file was closed
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = (os.getenv("HOME") or os.getenv("USERPROFILE")) .. "/.vim/undodir"
vim.opt.undofile = true

-- The screen will scroll from 35% of the screen
vim.opt.scrolloff = math.floor(vim.o.lines * 0.35)

-- make the cursor blink
vim.opt.guicursor = "n-v-c:block-blinkwait700-blinkoff400-blinkon250,i:ver25-blinkwait700-blinkoff400-blinkon250"

vim.o.clipboard = "unnamedplus"

vim.opt.mouse = "a"

_G.toggle_focus = function()
  local api = require("nvim-tree.api")
  if api.tree.is_visible() then
    local curwin = vim.api.nvim_get_current_win()
    local tree_win = nil
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
      if bufname:match("NvimTree_") then
        tree_win = win
        break
      end
    end
    if tree_win and curwin == tree_win then
      vim.cmd("wincmd l")
    elseif tree_win then
      vim.api.nvim_set_current_win(tree_win)
    else
      api.tree.focus()
    end
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd("NvimTreeToggle")
		_G.toggle_focus()
	end
})
