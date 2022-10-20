vim.g.undotree_RelativeTimestamp = 1
vim.g.undotree_ShortIndocators = 1
vim.g.undotree_HelpLine = 0
vim.g.undotree_WindowLayout = 1
vim.g.undotree_SplitWidth = 35
vim.g.undotree_DiffpanelHeight = 15
vim.g.undotree_SetFocusWhenToggle = 1

vim.cmd([[
 if has("persistent_undo")
   set hid
   set undodir=~/.cache/nvim/undodir
   set undofile
 endif
]])

vim.keymap.set( "n", "<C-p>", ":UndotreeToggle<CR>", { noremap = true, silent = true })
