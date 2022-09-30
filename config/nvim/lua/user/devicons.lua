local icon_ok, nvim_dev = pcall(require, "nvim-web-devicons")

if not icon_ok then
  return
end

local cfg = {
  lua = {
    icon = "",
    color = "#009dff",
    cterm_color = "65",
    name = "Lua",
  },
  js = {
    icon = "",
    color = "#fffd75",
    cterm_color = "65",
    name = "Js",
  },
  ts = {
    icon = "ﯤ",
    color = "#009dff",
    cterm_color = "65",
    name = "Ts",
  },
}

nvim_dev.set_icon(cfg)
