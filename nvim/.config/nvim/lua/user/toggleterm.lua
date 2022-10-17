local status_ok, term = pcall(require, "toggleterm")
local keymap          = vim.keymap.set
local term_opts       = { buffer = 0 }
local opts            = { noremap = true, silent = true }

if not status_ok then
    return
end

local cfg = {
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.3
        end
    end,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = false,
    shading_factor = 2,
    start_in_insert = false,
    insert_mappings = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "single",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
}

local Terminal = require("toggleterm.terminal").Terminal
local lg = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _G.set_terminal_keymaps()
    keymap("t", "<esc>", [[<C-\><C-n>]], term_opts)
    keymap("t", "jk", [[<C-\><C-n>]], term_opts)
    keymap("t", "<C-h>", [[<Cmd>wincmd h<CR>]], term_opts)
    keymap("t", "<C-j>", [[<Cmd>wincmd j<CR>]], term_opts)
    keymap("t", "<C-k>", [[<Cmd>wincmd k<CR>]], term_opts)
    keymap("t", "<C-l>", [[<Cmd>wincmd l<CR>]], term_opts)
end

function _LAZYGIT_TOGGLE()
    lg:toggle()
end

vim.cmd([[
  autocmd! TermOpen term://* lua set_terminal_keymaps()
]])

keymap("n", "<leader>g", ":lua _LAZYGIT_TOGGLE()<CR>", opts)

term.setup(cfg)
