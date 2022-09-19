local regex_ok, regex = pcall(require, 'regexplainer')

if not regex_ok then
  return
end

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', '\\rq', ':RegexplainerShow<cr>', opts)
keymap('n', '\\rw', ':RegexplainerHide<cr>', opts)
keymap(
  'n',
  '\\re',
  ':lua require("regexplainer").show { display = "pasteboard" }<cr>',
  opts
)

regex.setup {
  mode = 'narrative',
  auto = true,
  filetypes = {
    'html',
    'js',
    'cjs',
    'mjs',
    'ts',
    'jsx',
    'tsx',
    'cjsx',
    'mjsx',
  },
  display = 'popup',
  narrative = {
    separator = function(component)
      local sep = '\n'
      if component.depth > 0 then
        for _ = 1, component.depth do
          sep = sep .. '> '
        end
      end
      return sep
    end,
  },
}
