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
