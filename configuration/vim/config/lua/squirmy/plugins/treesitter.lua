return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
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
      },

      sync_install = false,
      auto_install = true,
      indent = {
        enable = true,
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'markdown' },
      },
    })
  end,
}
