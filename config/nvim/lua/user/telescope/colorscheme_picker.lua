---@diagnostic disable: missing-parameter, unused-local
local action_state = require "telescope.actions.state"
local actions      = require "telescope.actions"
local pickers      = require "telescope.pickers"
local finders      = require "telescope.finders"
local sorters      = require "telescope.sorters"
local get_colors   = vim.fn.getcompletion("", "color")

local M = {}

local excludes = {
  "starry",
}

local function ignore_selected_colorscheme(ignore)
  for k, v in pairs(get_colors) do
    for i = 1, #ignore do
      local _v, _i = v, ignore[i]
      if _v == _i then
        table.remove(get_colors, k)
      end
    end
  end
end

ignore_selected_colorscheme(excludes)

local function enter(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)

  local path = vim.fn.expand "~/.dotfiles/nvim/lua/user/colorscheme.lua"
  local job_cmd = "sed -i '' '$d' "
    .. path
    .. " && echo '"
    .. "colorscheme "
    .. '"'
    .. selected[1]
    .. '"'
    .. "' >> "
    .. path
  vim.fn.jobstart(job_cmd)

  for _, v in pairs(get_colors) do
    if selected[1] == v then
      local timer = vim.loop.new_timer()
      local u = " 🤖 Update Colorscheme to : " .. v
      local s = " 🤖 Successfuly Loaded : " .. v
      local r =
        " Please Relaunch Noevim\n for make sure everything work properly"
      vim.notify(u, "warn", {
        title = "Colorscheme Info",
        on_open = function()
          timer:start(1500, 0, function()
            vim.notify(s, "info", {
              title = "Loading Colorscheme Config",
            })
          end)
          require "user.hot-reload"
          reload "user.colorscheme"
          vim.cmd [[source $MYVIMRC]]
        end,
        on_close = function()
          timer:start(1750, 0, function()
            vim.notify(r, "warn", {
              title = "🤖 Neovim Info",
            })
          end)
        end,
      })
      break
    end
  end
  actions.close(prompt_bufnr)
end

local function next_color(prompt_bufnr)
  actions.move_selection_next(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
end

local function prev_color(prompt_bufnr)
  actions.move_selection_previous(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
end

local opts = {
  finder = finders.new_table(get_colors),
  sorter = sorters.get_generic_fuzzy_sorter {},

  attach_mappings = function(prompt_bufnr, map)
    map("i", "<CR>", enter)
    map("i", "<C-j>", next_color)
    map("i", "<C-k>", prev_color)
    map("i", "<Tab>", next_color)
    map("i", "<s-Tab>", prev_color)

    map("n", "<CR>", enter)
    map("n", "j", next_color)
    map("n", "k", prev_color)
    map("n", "<Tab>", next_color)
    map("n", "<s-Tab>", prev_color)
    return true
  end,
}

function M.setup(layout)
  local colors = pickers.new(layout, opts)
  colors:find()
end

return M
