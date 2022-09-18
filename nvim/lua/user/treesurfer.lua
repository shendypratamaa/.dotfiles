local sts_ok, sts = pcall(require, 'syntax-tree-surfer')

if not sts_ok then
  return
end

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', 'gv', function() -- only jump to variable_declarations
  sts.targeted_jump { 'variable_declaration' }
end, opts)
keymap('n', 'gfu', function() -- only jump to functions
  sts.targeted_jump { 'function', 'arrrow_function', 'function_definition' }
  --> In this example, the Lua language schema uses "function",
  --  when the Python language uses "function_definition"
  --  we include both, so this keymap will work on both languages
end, opts)
keymap('n', 'gif', function() -- only jump to if_statements
  sts.targeted_jump { 'if_statement' }
end, opts)
keymap('n', 'gfo', function() -- only jump to for_statements
  sts.targeted_jump { 'for_statement' }
end, opts)
keymap('n', 'gj', function() -- jump to all that you specify
  sts.targeted_jump {
    'function',
    'if_statement',
    'else_clause',
    'else_statement',
    'elseif_statement',
    'for_statement',
    'while_statement',
    'switch_statement',
  }
end, opts)

-------------------------------
-- filtered_jump --
-- "default" means that you jump to the default_desired_types or your lastest jump types
keymap('n', '\\af', function()
  sts.filtered_jump('default', true) --> true means jump forward
end, opts)
keymap('n', '\\as', function()
  sts.filtered_jump('default', false) --> false means jump backwards
end, opts)

-- non-default jump --> custom desired_types
keymap('n', '\\ae', function()
  sts.filtered_jump({
    'if_statement',
    'else_clause',
    'else_statement',
  }, true) --> true means jump forward
end, opts)
keymap('n', '\\aw', function()
  sts.filtered_jump({
    'if_statement',
    'else_clause',
    'else_statement',
  }, false) --> false means jump backwards
end, opts)

-------------------------------
-- jump with limited targets --
-- jump to sibling nodes only
keymap('n', '-', function()
  sts.filtered_jump({
    'if_statement',
    'else_clause',
    'else_statement',
  }, false, { destination = 'siblings' })
end, opts)
keymap('n', '=', function()
  sts.filtered_jump(
    { 'if_statement', 'else_clause', 'else_statement' },
    true,
    { destination = 'siblings' }
  )
end, opts)

-- jump to parent or child nodes only
keymap('n', '_', function()
  sts.filtered_jump({
    'if_statement',
    'else_clause',
    'else_statement',
  }, false, { destination = 'parent' })
end, opts)
keymap('n', '+', function()
  sts.filtered_jump({
    'if_statement',
    'else_clause',
    'else_statement',
  }, true, { destination = 'children' })
end, opts)

keymap('n', '\\vs', '<cmd>STSSelectCurrentNode<cr>', opts)
keymap('n', '\\va', '<cmd>STSSelectMasterNode<cr>', opts)

sts.setup {
  highlight_group = 'TelescopePromptTitle',
  disable_no_instance_found_report = false,
  default_desired_types = {
    'function',
    'arrow_function',
    'function_definition',
    'if_statement',
    'else_clause',
    'else_statement',
    'elseif_statement',
    'for_statement',
    'while_statement',
    'switch_statement',
  },
  left_hand_side = 'fdsawervcxqtzb',
  right_hand_side = 'jkl;oiu.,mpy/n',
  icon_dictionary = {
    ['if_statement'] = '',
    ['else_clause'] = '',
    ['else_statement'] = '',
    ['elseif_statement'] = '',
    ['for_statement'] = 'ﭜ',
    ['while_statement'] = 'ﯩ',
    ['switch_statement'] = 'ﳟ',
    ['function'] = '',
    ['function_definition'] = '',
    ['variable_declaration'] = '',
  },
}
