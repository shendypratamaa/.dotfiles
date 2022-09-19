local surround_ok, sr = pcall(require, 'nvim-surround')

if not surround_ok then
  return
end

sr.setup()
