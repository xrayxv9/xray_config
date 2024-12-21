##NVIM CONFIG

### DOWNLOAD

```console
git clone https://github.com/xrayxv9/xray_config ~/.config/nvim

```

### MAIN SHORTCUT

Before anything, we will refer to space as <leader>, then
here are the most important shortcuts:

<leader e>  :   opens the tree

<leader ff> :   opens the telescope

<->         :   opens the current directory

<C-\>       :   opens/close a terminal

<C-/>       :   in normal mode comments a line
                in visual mode comments all the selected line

<Alt-arrows>:   Move the selected line (only up and down arrows works)

### LITTLE THINGS TO CHANGE

If you want to change the theme you can see all the themes on here:
```https://github.com/folke/tokyonight.nvim```

the do the command:
```console
cd ~/.config/nvim/lua/plugins
nvim tokyo.lua
```
and change the line 6:
```lua
vim.cmd[[colorscheme tokyonight-night]]
to 
vim.cmd[[colorscheme tokyonight-<desired-theme>]]
```
