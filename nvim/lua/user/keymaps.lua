local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.keymap.set

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
keymap('n', '<C-n>', ':NvimTreeToggle<CR>', opts)

-- Resize with arrows
keymap('n', '<C-w>k', ':resize +5<CR>', opts)
keymap('n', '<C-w>j', ':resize -5<CR>', opts)
keymap('n', '<C-w>l', ':vertical resize -5<CR>', opts)
keymap('n', '<C-w>h', ':vertical resize +5<CR>', opts)

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- split panes
keymap('n', 'ss', ':sv<CR>', opts)
keymap('n', 'sv', ':vs<CR>', opts)

-- Insert --
-- Press jk fast to enter
keymap('i', 'jk', '<ESC>', opts)

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Visual Block --
-- Move text up and down
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)
keymap('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
keymap('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)
keymap('v', 'p', '"_dP', opts)

-- Terminal --
-- Better terminal navigation
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

-- extras --
keymap('n', 'wq', ':bd<CR>', term_opts)
keymap('n', ']s', ':luafile %<CR>', opts)
keymap('n', '<C-r>', ':nohls<CR>', opts)
keymap('n', '<leader>f', ':Format<CR>', opts)

-- Fix-behave
keymap('n', 'mm', 'zz', opts)
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)
keymap('n', 'J', 'mzJ`z', opts)
