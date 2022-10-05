---@diagnostic disable: missing-parameter
local window_ok, window = pcall(require, "windows")

if not window_ok then
  return
end

vim.o.winwidth     = 10
vim.o.winminwidth  = 10
vim.o.winminheight = 1
vim.o.equalalways  = true

local opts = { noremap = true, silent = true}

vim.keymap.set('n', '<c-w>-',':WindowsMaximizeVertically<CR>', opts)
vim.keymap.set('n', '<c-w>\\',':WindowsMaximizeHorizontally<CR>', opts)
vim.keymap.set('n', '<c-w>=',':WindowsEqualize<CR>', opts)

local cfg = {
  animation = {
    enable = true,
    duration = 300,
    fps = 60,
    easing = "in_out_sine",
  },
}

window.setup(cfg)
