vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- Add highlight group definition for IblChar
vim.api.nvim_set_hl(0, 'IblChar', { fg = '#3E4452', bg = 'NONE' })

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },

  -- Ensure that indent-blankline.nvim is correctly configured
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup({
        char = '│',
        filetype_exclude = { 'help', 'packer' },
        buftype_exclude = { 'terminal', 'nofile' },
      })
    end,
  },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Set background to transparent
vim.cmd("highlight Normal guibg=none ctermbg=none")
vim.cmd("highlight NonText guibg=none ctermbg=none")

