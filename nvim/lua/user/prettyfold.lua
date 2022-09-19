local fold_ok, fd = pcall(require, 'pretty-fold')

if not fold_ok then
  return
end

fd.setup()
