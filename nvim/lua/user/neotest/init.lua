local M = {}

function M.setup()
  require('neotest').setup {
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
end

return M
