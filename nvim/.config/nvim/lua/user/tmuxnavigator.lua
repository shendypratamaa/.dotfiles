vim.g.tmux_navigator_no_mappings = 1
vim.g.tmux_navigator_save_on_switch = 2
vim.g.tmux_navigator_disable_when_zoomed = 1
vim.g.tmux_navigator_preserve_zoom = 1

local keymap = vim.keymap.set
local term_opts = { silent = true }

keymap("n", "<C-h>", ":TmuxNavigateLeft<CR>", term_opts)
keymap("n", "<C-j>", ":TmuxNavigateDown<CR>", term_opts)
keymap("n", "<C-k>", ":TmuxNavigateUp<CR>", term_opts)
keymap("n", "<C-l>", ":TmuxNavigateRight<CR>", term_opts)
