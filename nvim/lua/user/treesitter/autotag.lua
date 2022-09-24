local status_ok, autotag = pcall(require, "nvim-ts-autotag")

if not status_ok then
  return
end

local M = {}

local cfg = {
  skip_tag = {
    "area",
    "base",
    "br",
    "col",
    "command",
    "embed",
    "hr",
    "img",
    "slot",
    "input",
    "keygen",
    "link",
    "meta",
    "param",
    "source",
    "track",
    "wbr",
    "menuitem",
  },
  filetypes = {
    "html",
    "typescriptreact",
    "javascriptreact",
    "typescript",
    "javascript",
    "jsx",
    "tsx",
  },
}

function M.setup()
  autotag.setup(cfg)
end

return M
