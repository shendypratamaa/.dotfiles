local cmp_status_ok, cmp = pcall(require, 'cmp')
local luasnip = require 'luasnip'

if not cmp_status_ok then
  return
end

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})

cmp.setup.cmdline('/', {
  view = {
    entries = { name = 'wildmenu', separator = ' . ' },
  },
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  view = {
    entries = 'custom',
  },
  mapping = {
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ['<CR>'] = cmp.mapping.confirm { select = true },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes(
            '<Plug>luasnip-expand-or-jump',
            true,
            true,
            true
          ),
          ''
        )
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes(
            '<Plug>luasnip-jump-prev',
            true,
            true,
            true
          ),
          ''
        )
      else
        fallback()
      end
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        luasnip = '[Snippets]',
        nvim_lsp = '[LSP]',
        emoji = '[Emoji]',
        path = '[Path]',
        buffer = '[Buffers]',
        treesitter = '[Treesitter]',
        calc = '[Calc]',
      })[entry.source.name]

      if entry.source.name == 'nvim_lsp' then
        vim_item.dup = 0
      end

      return vim_item
    end,
  },
  sources = {
    { name = 'luasnip' },
    {
      name = 'buffer',
      keyword_length = 5,
      option = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
    },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'cmdline' },
    { name = 'emoji' },
    { name = 'path', option = {
      triling_slash = true,
    } },
    { name = 'neorg' },
    { name = 'calc' },
    { name = 'treesitter' },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}
