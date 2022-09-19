local harpoon_ok, harpoon = pcall(require, 'harpoon')

if not harpoon_ok then
  return
end

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', ']a', ":lua require('harpoon.mark').add_file()<CR>", opts)
keymap('n', ']w', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)

harpoon.setup {
  menu = {
    width = vim.api.nvim_win_get_width(0) / 4,
  },
}
