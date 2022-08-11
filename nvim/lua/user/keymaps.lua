local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

-- Resize with arrows
keymap("n", "<C-w>k", ":resize +5<CR>", opts)
keymap("n", "<C-w>j", ":resize -5<CR>", opts)
keymap("n", "<C-w>l", ":vertical resize -5<CR>", opts)
keymap("n", "<C-w>h", ":vertical resize +5<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- split panes
keymap("n", "ss", ":sv<CR>", opts)
keymap("n", "sv", ":vs<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
keymap("v", "p", '"_dP', opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- extras --
keymap("n", "wq", ":bd<CR>", term_opts)

-- undo-tree
keymap("n", "<C-p>", ":UndotreeToggle<CR>", opts)

-- Fix-behave
keymap("n", "mm", "zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "J", "mzJ`z", opts)

-- harpoon
keymap("n", "]a", ":lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "]w", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)

-- Tmux-navigatior
keymap("n", "<C-h>", ":TmuxNavigateLeft<CR>", term_opts)
keymap("n", "<C-j>", ":TmuxNavigateDown<CR>", term_opts)
keymap("n", "<C-k>", ":TmuxNavigateUp<CR>", term_opts)
keymap("n", "<C-l>", ":TmuxNavigateRight<CR>", term_opts)

vim.g.tmux_navigator_no_mappings = 1
vim.g.tmux_navigator_save_on_switch = 2
vim.g.tmux_navigator_disable_when_zoomed = 1
vim.g.tmux_navigator_preserve_zoom = 1

-- sources
keymap("n", "]s", ":luafile %<CR>", opts)
keymap("n", "<C-r>", ":nohls<CR>", opts)
keymap("n", "<leader>f", ":Format<CR><cmd>bufdo e<CR>", opts)

-- markdown preview
keymap("n", "<C-s>", ":MarkdownPreviewToggle<CR>", opts)

-- true zen
keymap("n", "zx", ":TZAtaraxis<CR>", opts)

-- vim-jsx--import
keymap("n", "gi", ":JsFileImport<CR>", opts)
keymap("n", "gI", ":JsFileImportList<CR>", opts)
keymap("n", "gd", ":JsGotoDefinition<CR>", opts)
keymap("n", "gP", ":PromptJsFileImport<CR>", opts)
keymap("n", "gS", ":SortJsFileImport<CR>", opts)
keymap("n", "gf", ":JsFixImport<CR>", opts)

-- telescope
keymap("n", "]f", ":lua require('user.telescope').custom_themes()<CR>", opts)
keymap("n", "]ff", ":lua require('telescope.builtin').find_files()<CR>", opts)
keymap("n", "]b", ":lua require('telescope.builtin').buffers()<CR>", opts)
keymap("n", "]r", ":lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "]t", ":lua require('telescope.builtin').help_tags()<CR>", opts)
keymap("n", "]n", ":Telescope file_browser<CR>", opts)
keymap("n", "]g", ":Telescope keymaps<CR>", opts)
