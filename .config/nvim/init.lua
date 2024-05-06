-- Initialization for lazy.nvim
vim.cmd [[packadd lazy.nvim]]
require('lazy').setup {
  {'wbthomason/packer.nvim'},
  {'nvim-lua/plenary.nvim'},
  {'kyazdani42/nvim-web-devicons'},
  {
    'folke/tokyonight.nvim',
    config = function()
      vim.cmd [[colorscheme tokyonight-moon]]
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('lualine').setup {
        options = { theme = 'tokyonight' }
      }
    end
  },
  {'junegunn/fzf'},
  {'junegunn/fzf.vim'},
  {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  },
  {'ThePrimeagen/harpoon'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-cmdline'},
  {'f3fora/cmp-spell'},
  {'lewis6991/spellsitter.nvim'}
}

-- Basic editor settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.list = true
vim.opt.listchars = {space = '⋅', eol = '↴', trail = '•', tab = '>-'}

-- Clipboard configuration for seamless system integration
vim.opt.clipboard = "unnamedplus"

-- Telescope configuration for enhanced file and text searching
require('telescope').setup {}

-- LSP setup for C/C++
local lspconfig = require('lspconfig')
lspconfig.clangd.setup{}

-- Autocompletion setup
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'cmp_spell' },
    { name = 'buffer' },
    { name = 'path' }
  })
})

-- Enable spell checking only in text modes and comments
require('spellsitter').setup {
    enable = true,
}

-- Leader key setup
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Telescope mappings
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { noremap = true, silent = true })

-- FZF key mappings
vim.api.nvim_set_keymap('n', '<leader>fz', ':FZF<CR>', { noremap = true, silent = true })

-- Harpoon mappings
vim.api.nvim_set_keymap('n', '<leader>ha', '<cmd>lua require("harpoon.mark").add_file()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hm', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true, silent = true })

-- LSP mappings for quick actions
vim.api.nvim_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ln', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })

