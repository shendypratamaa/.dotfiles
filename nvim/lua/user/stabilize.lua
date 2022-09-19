local stab_ok, stab = pcall(require, 'stabilize')

if not stab_ok then
  return
end

stab.setup {
  ignore = {
    filetype = { 'help', 'list', 'Trouble' },
    buftype = { 'quickfix', 'loclist', 'undotree', 'terminal' },
  },
  nested = nil,
}
