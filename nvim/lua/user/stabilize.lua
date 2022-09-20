local stab_ok, stab = pcall(require, 'stabilize')

if not stab_ok then
  return
end

local stabilize_cfg = {
  force = true, -- stabilize window even when current cursor position will be hidden behind new window
  forcemark = nil, -- set context mark to register on force event which can be jumped to with '<forcemark>
  ignore = { -- do not manage windows matching these file/buftypes
    filetype = { 'help', 'list', 'Trouble' },
    buftype = { 'terminal', 'quickfix', 'loclist' },
  },
  nested = 'QuickFixCmdPost,DiagnosticChanged *',
}

stab.setup(stabilize_cfg)
