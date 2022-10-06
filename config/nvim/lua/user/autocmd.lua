vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd [[
      set formatoptions-=cro
      set wildignore+=*.meteor*
      set wildignore+=*vim/backups*
      set wildignore+=*sass-cache*
      set wildignore+=*cache*
      set wildignore+=*logs*
      set wildignore+=*node_modules/**
      set wildignore+=*DS_Store*
      set wildignore+=*.gem
      set wildignore+=log/**
      set wildignore+=tmp/**
      set wildignore+=*.png,*.jpg,*.gif
      set nocompatible
      set iskeyword+=-
      set whichwrap+=<,>,[,],h,l
      set nofoldenable
      set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
      set grepformat=%f:%l:%c:%m
      let g:vimwiki_list = [{'path': '~/vimwiki/',
                            \ 'syntax': 'markdown', 'ext': '.md'}]
    ]]
  end,
})

-- trim whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- disable lualine when access alpha dashoard
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "AlphaReady", "alpha" },
  callback = function()
    vim.cmd [[
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]
  end,
})

-- bind q for close specified filetypes
vim.api.nvim_create_autocmd({ "Filetype" }, {
  pattern = {
    "qf",
    "help",
    "man",
    "lspinfo",
    "startuptime",
    "Trouble",
    "Outline",
    "undotree_2",
    "toggleterm",
    "TelescopePrompt",
    "null-ls-info",
    "tsplayground"
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :q!<CR>
      set nobuflisted
    ]]
  end,
})
