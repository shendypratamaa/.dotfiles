local fidget_ok, fd = pcall(require, 'fidget')

if not fidget_ok then
  return
end

fd.setup()
