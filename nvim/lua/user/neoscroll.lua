local status_neo, neoscroll = pcall(require, "neoscroll")
local neoscroll_config = require "neoscroll.config"

if not status_neo then
  return
end

local cfg = {
  easing_function = "quadratic",
}

local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
-- Use the "sine" easing function
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "250", [['sine']] } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "250", [['sine']] } }
-- Use the "circular" easing function
t["<C-b>"] = {
  "scroll",
  { "-vim.api.nvim_win_get_height(0)", "true", "500", [['circular']] },
}
t["<C-f>"] = {
  "scroll",
  { "vim.api.nvim_win_get_height(0)", "true", "500", [['circular']] },
}
-- Pass "nil" to disable the easing animation (constant scrolling speed)
t["<C-y>"] = { "scroll", { "-0.10", "false", "100", nil } }
t["<C-e>"] = { "scroll", { "0.10", "false", "100", nil } }
-- When no easing function is provided the default easing function (in this case "quadratic") will be used
t["zt"] = { "zt", { "300" } }
t["zz"] = { "zz", { "300" } }
t["zb"] = { "zb", { "300" } }

neoscroll.setup(cfg)
neoscroll_config.set_mappings(t)
