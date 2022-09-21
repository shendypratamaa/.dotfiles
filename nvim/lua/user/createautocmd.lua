local autocmd = vim.api.nvim_create_autocmd

-- FIX autocmd
autocmd({ 'BufWinEnter' }, {
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
    ]]
  end,
})

autocmd({ 'User' }, {
  pattern = { 'AlphaReady' },
  callback = function()
    vim.cmd [[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]
  end,
})

autocmd({ 'Filetype' }, {
  pattern = {
    'qf',
    'help',
    'man',
    'lspinfo',
    'spectre_panel',
    'lir',
    'startuptime',
    'Trouble',
    'OUTLINE',
    'undotree_2'
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})
