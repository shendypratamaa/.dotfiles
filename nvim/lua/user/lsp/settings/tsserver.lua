return {
  settings = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    root_dir = {
      "package.json",
      "tsconfig.json",
      "jsconfig.json",
      ".git",
    },
  },
}
