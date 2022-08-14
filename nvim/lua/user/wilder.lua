local wilder_ok, wilder = pcall(require, "wilder")

if not wilder_ok then
  return
end

wilder.set_option(
  "renderer",
  wilder.renderer_mux {
    [":"] = wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
      highlights = {
        accent = wilder.make_hl("WilderAccent", "Pmenu", {
          { a = 1 },
          { a = 1 },
          { foreground = "#f4468f" },
        }),
      },
      highlighter = wilder.basic_highlighter(),
      left = { " ", wilder.popupmenu_devicons() },
      right = { " ", wilder.popupmenu_scrollbar() },
    }),
    ["/"] = wilder.wildmenu_renderer {
      highlighter = wilder.basic_highlighter(),
      separator = " · ",
    },
  }
)

wilder.setup {
  modes = { ":", "/", "?" },
}
