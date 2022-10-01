local bqf_ok, bqf = pcall(require, "bqf")

if not bqf_ok then
  vim.notify(" 🤖 not working properly", "error", {
    title = "Quickfix info",
    timeout = 2000,
  })
  return
end

local keymap = vim.keymap.set
local opts = { silent = true }
local fn = vim.fn

function _G.qftf(info)
  local items
  local ret = {}
  if info.quickfix == 1 then
    items = fn.getqflist({id = info.id, items = 0}).items
  else
    items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
  end
  local limit = 31
  local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
  local validFmt = '%s │%5d:%-3d│%s %s'
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local fname = ''
    local str
    if e.valid == 1 then
      if e.bufnr > 0 then
        fname = fn.bufname(e.bufnr)
          if fname == '' then
            fname = '[No Name]'
          else
            fname = fname:gsub('^' .. vim.env.HOME, '~')
          end
          -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
          if #fname <= limit then
            fname = fnameFmt1:format(fname)
          else
            fname = fnameFmt2:format(fname:sub(1 - limit))
          end
      end
      local lnum = e.lnum > 99999 and -1 or e.lnum
      local col = e.col > 999 and -1 or e.col
      local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
      str = validFmt:format(fname, lnum, col, qtype, e.text)
    else
      str = e.text
    end
    table.insert(ret, str)
  end
  return ret
end

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'

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
