return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false, -- Important: This plugin does not support lazy-loading
  build = ':TSUpdate',
  config = function()
    -- Setup nvim-treesitter (minimal config needed)
    require('nvim-treesitter').setup({
      install_dir = vim.fn.stdpath('data') .. '/site',
    })

    -- Install parsers
    require('nvim-treesitter').install({
      'vimdoc',
      'bash',
      'javascript',
      'typescript',
      'jsdoc',
      'lua',
      'rust',
      'elixir',
      'heex',
      'eex',
      'nix',
      'just',
    })

    -- Enable treesitter highlighting for these filetypes
    local filetypes = {
      'vim',
      'bash',
      'javascript',
      'typescript',
      'lua',
      'rust',
      'elixir',
      'heex',
      'eex',
      'nix',
      'just',
      'markdown',
    }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = filetypes,
      callback = function() vim.treesitter.start() end,
    })

    -- Enable treesitter indentation for these filetypes
    vim.api.nvim_create_autocmd('FileType', {
      pattern = filetypes,
      callback = function() vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end,
    })
  end,
}
