vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

local nvchad_lspconfig = require("nvchad.configs.lspconfig")
local original_on_attach = nvchad_lspconfig.on_attach
nvchad_lspconfig.on_attach = function(client, bufnr)
  local temp_client = setmetatable({}, {
    __index = function(_, key)
      if key == "supports_method" then
        return function(_, method)
          return client.server_capabilities[method .. "Provider"] or false
        end
      end
      return client[key]
    end
  })

  original_on_attach(temp_client, bufnr)
end

dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.filetype.add({
  extension = {
    mll = "ocaml.ocamllex",
    mly = "ocaml.menhir"
  }
})
