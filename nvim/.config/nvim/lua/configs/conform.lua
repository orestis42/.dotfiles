local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    objc = { "clang_format" },
    objcpp = { "clang_format" },
    swift = { "swiftformat" },
    xml = { "xmlformat" },
    markdown = { "codespell" },
    text = { "codespell" },
    -- Add more formatters as needed
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 2000,
    lsp_fallback = true,
  },
  -- Formatter options can be configured per formatter
  formatters = {
    clang_format = {
      -- You can specify custom args here if needed
      args = { "--style=file" },
    },
    swiftformat = {
      -- Any custom options for swiftformat
    },
    -- Add other formatter configurations as needed
  },
}

return options
