local indent_ok, indent = pcall(require, 'indent_blankline')

if not indent_ok then
  return
end

vim.opt.list = true
vim.opt.termguicolors = true
vim.opt.listchars:append 'eol:↴'
vim.g.indent_blankline_char_list = ' '

indent.setup {
  char = '',
  show_trailing_blankline_indent = false,
}
