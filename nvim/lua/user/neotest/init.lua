local test_ok, tst = pcall(require, 'neotest')

if not test_ok then
  return
end

tst.setup {
  adapters = {
    require 'neotest-jest' {
      allow_file_types = { 'javascript', 'typescript' },
      jestCommand = 'npm test --',
      jestConfigFile = 'custom.jest.config.ts',
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    },
  },
}
