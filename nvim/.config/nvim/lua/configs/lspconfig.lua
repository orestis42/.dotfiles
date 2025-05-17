-- Load NvChad defaults (patched in init.lua)
local nvlsp = require("nvchad.configs.lspconfig")
local lspconfig = require("lspconfig")

-- List of LSP servers
local servers = {
  "clangd",        -- C/C++
  "lua_ls",        -- Lua
  "rust_analyzer", -- Rust
  "ruff",          -- Python
  "ocamllsp",      -- OCaml
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Custom server config for Clang (C/C++)
lspconfig.clangd.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp" },
  cmd = { "clangd", "--background-index" },
  flags = {
    debounce_text_changes = 150, -- to reduce the number of diagnostics updates
  },
  init_options = {
    fallbackFlags = { "-std=c++20" }, -- Use C++20 standard or change according to your project
    clangdFileStatus = true,          -- Enable file status updates
  },
  settings = {
    clangd = {
      diagnostics = {
        severity = {
          -- Reduce the severity of specific diagnostics (tweak according to your needs)
          warnings = vim.lsp.protocol.DiagnosticSeverity.Hint,
          information = vim.lsp.protocol.DiagnosticSeverity.Hint,
          -- You can also turn off diagnostics for specific issues like this:
          -- Disabled specific clang-tidy checks (if you're using clang-tidy)
          disabled = {
            "cppcoreguidelines-pro-type-member-init",
            "modernize-use-trailing-return-type",
            "readability-magic-numbers",
            -- Add more checks to suppress here
          },
        },
      },
    },
  },
}

-- Custom server config for Lua
lspconfig.lua_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
}

-- Custom server config for Rust
lspconfig.rust_analyzer.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}

-- Custom config for Ruff LSP (Python)
lspconfig.ruff.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    ruff = {
      fix = { enabled = true }, -- auto-fix on save
    },
  },
}

-- Custom config for ocamllsp
lspconfig.ocamllsp.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "ocamllsp" },
  filetypes = { "ocaml", "ocaml.interface", "ocaml.ocamllex", "ocaml.menhir", "reason", "dune" },
  root_dir = lspconfig.util.root_pattern("*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace"),
}
