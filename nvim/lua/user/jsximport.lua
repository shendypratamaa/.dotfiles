vim.g.js_file_import_sort_after_insert = 0
vim.g.js_file_import_prompt_if_no_tag = 0
vim.g.js_file_import_force_require = 1
vim.g.js_file_import_package_first = 0
vim.g.js_file_import_omit_semicolon = 0
vim.g.js_file_import_no_mappings = 1
vim.g.js_file_import_string_quote = "'"
vim.g.js_file_import_use_fzf = 1
vim.g.js_file_import_use_telescope = 1
vim.g.js_file_import_strip_file_extension = 0

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', 'gi', ':JsFileImport<CR>', opts)
keymap('n', 'gI', ':JsFileImportList<CR>', opts)
keymap('n', 'gd', ':JsGotoDefinition<CR>', opts)
keymap('n', 'gP', ':PromptJsFileImport<CR>', opts)
keymap('n', 'gS', ':SortJsFileImport<CR>', opts)
keymap('n', 'gf', ':JsFixImport<CR>', opts)
