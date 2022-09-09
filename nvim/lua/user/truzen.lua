local zen_ok, zen = pcall(require, 'true-zen')

if not zen_ok then
  return
end

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', 'zx', ':TZAtaraxis<CR>', opts)

zen.setup {}
