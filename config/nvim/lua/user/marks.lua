local marks_ok, mark = pcall(require, "marks")

if not marks_ok then
  return
end

vim.keymap.set('n', ']sa', ":MarksQFListAll<CR>", {})
vim.keymap.set('n', ']sb', ":MarksQFListBuf<CR>", {})

local cfg = {
  default_mappings = true,
  builtin_marks = {},
  cyclic = true,
  force_write_shada = false,
  refresh_interval = 250,
  sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
  excluded_filetypes = {},
  bookmark_0 = {
    sign = "⚑",
    virt_text = "bookmarks",
    annotate = false,
  },
  mappings = {
    next = "]s",
    prev = "[s",
    set_next = false,
    preview = false,
    set_bookmark0 = "m1",
  },
}

mark.setup(cfg)
