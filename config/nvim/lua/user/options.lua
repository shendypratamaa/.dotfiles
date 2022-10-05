local options = {
  syntax = "on",
  filetype = "plugin_indent_on",
  fileencoding = "utf8",
  virtualedit = "block",
  clipboard = "unnamedplus",
  completeopt = { "menuone", "noselect" },
  signcolumn = "yes",
  mouse = "a",
  colorcolumn = "80",
  guifont = "JetBrainsMono Nerd Font Mono:h12",
  guicursor = "",
  exrc = true,
  autoread = true,
  hidden = true,
  number = true,
  relativenumber = true,
  backup = false,
  cmdheight = 1,
  conceallevel = 0,
  hlsearch = true,
  incsearch = true,
  pumheight = 10,
  splitright = true,
  splitbelow = true,
  swapfile = false,
  termguicolors = true,
  timeoutlen = 200,
  updatetime = 300,
  writebackup = false,
  cursorline = true,
  wrap = false,
  ignorecase = true,
  sidescrolloff = 8,
  scrolloff = 30,
  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,
  numberwidth = 2,
  expandtab = true,
  smartindent = true,
  autoindent = true,
  smartcase = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append "c"
vim.g.cursorhold_updatetime = 100
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.netrw_browsex_viewer = "open"
vim.g.did_load_filetypes = 1
