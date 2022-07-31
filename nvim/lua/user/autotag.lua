local status_ok, autotag = pcall(require, "nvim-ts-autotag")

if not status_ok then
  return
end

local filetypes = {
  "html",
  "typescriptreact",
  "javascriptreact",
  "typescript",
  "javascript",
  "jsx",
  "tsx",
}

local skip_tag = {
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
}

autotag.setup {
  filetypes = filetypes,
  disable = skip_tag,
}
