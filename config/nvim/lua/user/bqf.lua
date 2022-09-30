local bqf_ok, bqf = pcall(require, "bqf")

if not bqf_ok then
  vim.notify(" 🤖 not working properly", "error", {
    title = "Quickfix info",
    timeout = 2000,
  })
  return
end

local keymap      = vim.keymap.set
local opts        = { silent = true }

local toggle_qf = function()
  local qf_open = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_open = true
    end
  end
  if qf_open == true then
    vim.cmd "cclose"
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd "copen"
  end
end

keymap("n", "]e", function() toggle_qf() end, opts)

local cfg = {
  auto_enable        = true,
  auto_resize_height = true,
  preview = {
    win_height   = 12,
    win_vheight  = 12,
    delay_syntax = 50,
    border_chars = {
      "┃",
      "┃",
      "━",
      "━",
      "┏",
      "┓",
      "┗",
      "┛",
      "█",
    },
    show_title = true,
    should_preview_cb = function(bufnr)
      local ret     = true
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local fsize   = vim.fn.getfsize(bufname)
      if fsize > 100 * 1024 then
        ret = false
      end
      return ret
    end,
  },
  func_map = {
    drop        = "o",
    openc       = "O",
    split       = "<C-s>",
    tabdrop     = "<C-t>",
    tabc        = "",
    ptogglemode = "z,",
  },
  filter = {
    fzf = {
      extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" },
    },
  },
}

bqf.setup(cfg)
