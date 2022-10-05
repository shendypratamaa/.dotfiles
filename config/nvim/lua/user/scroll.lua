local status_neo, neoscroll = pcall(require, "neoscroll")
local smooth_ok, smooth = pcall(require, "smoothcursor")
local neoscroll_config = require "neoscroll.config"
local ts_ctx = require("treesitter-context")

if not status_neo and smooth_ok then
  return
end

local smoth_cfg  = {
  autostart          = true,
  cursor             = "▷",
  texthl             = "SmoothCursor",
  linehl             = nil,
  type               = "default",
  speed              = 10,
  intervals          = 30,
  priority           = 20,
  timeout            = 3000,
  threshold          = 3,
  enabled_filetypes  = nil,
  disabled_filetypes = { "TelescopePrompt", "cybu", "toggleterm", "alpha" },
}

local neo_cfg = {
  respect_scrolloff    = false,
  pre_hook = function(_) ts_ctx.disable() end,
  post_hook = function(_) ts_ctx.enable() end
}

local t = {}
-- Syntax: t[keys] = {function, {function arguments}}

-- Use the "sine" easing function
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "400", nil } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "400", nil } }

-- Use the "circular" easing function
t["<C-b>"] = {
  "scroll",
  { "-vim.api.nvim_win_get_height(0)", "true", "400", nil },
}
t["<C-f>"] = {
  "scroll",
  { "vim.api.nvim_win_get_height(0)", "true", "400", nil},
}

-- Pass "nil" to disable the easing animation (constant scrolling speed)
t["<C-y>"] = { "scroll", { "-0.10", "false", "100", nil } }
t["<C-e>"] = { "scroll", { "0.10", "false", "100", nil } }

-- When no easing function is provided the default easing function (in this case "quadratic") will be used
t["zt"] = { "zt", { "300" } }
t["zz"] = { "zz", { "300" } }
t["zb"] = { "zb", { "300" } }

smooth.setup(smoth_cfg)
neoscroll.setup(neo_cfg)
neoscroll_config.set_mappings(t)
