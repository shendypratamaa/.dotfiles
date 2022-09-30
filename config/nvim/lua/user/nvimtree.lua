local nvimtree_ok, nvimtree = pcall(require, "nvim-tree")
local nvim_tree_config = require "nvim-tree.config"

if not nvimtree_ok then
  return
end

local keymap = vim.keymap.set
local tree_cb = nvim_tree_config.nvim_tree_callback

keymap("n", "<C-n>", ":NvimTreeToggle<cr>", { noremap = true, silent = true })

local cfg = {
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  hijack_cursor = true,
  renderer = {
    root_folder_modifier = ":t",
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local _width = screen_w * 0.7
        local _height = screen_h * 0.5
        local width = math.floor(_width)
        local height = math.floor(_height)
        local center_y = ((vim.opt.lines:get() - _height) / 2)
          - vim.opt.cmdheight:get()
        local center_x = (screen_w - _width) / 2
        local layouts = {
          center = {
            anchor = "NW",
            relative = "editor",
            border = "single",
            row = center_y,
            col = center_x,
            width = width,
            height = height,
          },
        }
        return layouts.center
      end,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * 0.7)
    end,
    height = function()
      return math.floor((vim.opt.lines:get() - vim.opt.cmdheight:get()) * 0.5)
    end,
    mappings = {
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
        { key = "u", action = "dir_up" },
      },
    },
  },
}

nvimtree.setup(cfg)
