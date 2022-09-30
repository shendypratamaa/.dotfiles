local treehop_ok, treehop = pcall(require, "tsht")
local keymap = vim.keymap.set
local opts = { silent = true }

if not treehop_ok then
  return
end

local M = {}

local config_hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }
local move = { side = "start" }
local mode = { "n", "v", "o", "x" }

keymap(mode, "vn", ":lua require('tsht').nodes()<CR>", opts)

function M.setup()
  treehop.config.hint_keys = config_hint_keys
  treehop.move = move
end

return M
