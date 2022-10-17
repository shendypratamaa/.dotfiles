local window_ok, window = pcall(require, "windows")

if not window_ok then
  return
end

vim.o.winwidth     = 20
vim.o.winminwidth  = 20
vim.o.winheight    = 1
vim.o.winminheight = 1
vim.o.equalalways  = true

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<c-w>-", ":WindowsMaximizeVertically<CR>", opts)
vim.keymap.set("n", "<c-w>\\", ":WindowsMaximizeHorizontally<CR>", opts)
vim.keymap.set("n", "<c-w>=", ":WindowsEqualize<CR>", opts)

local cfg = {
  ignore = {
    buftype = { "quickfix", "Outline", "Trouble" },
    filetype = {
      "NvimTree",
      "Outline",
      "undotree",
      "tsplayground",
      "qf",
      "toggleterm",
    },
  },
  animation = {
    enable = true,
    duration = 100,
    fps = 30,
    easing = "in_out_sine",
  },
}

window.setup(cfg)
