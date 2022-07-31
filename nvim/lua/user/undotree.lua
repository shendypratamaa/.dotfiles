vim.g.undotree_RelativeTampstamp = 1
vim.g.undotree_ShortIndocators = 1
vim.g.undotree_HelpLine = 0
vim.g.undotree_WindowLayout = 3
vim.g.undotree_SplitWidth = 40
vim.g.undotree_DiffpanelHeight = 15
vim.g.undotree_SetFocusWhenToggle = 0

vim.cmd [[
 if has("persistent_undo")
   set hid
   set undodir=~/.cache/nvim/undodir
   set undofile
 endif
]]
