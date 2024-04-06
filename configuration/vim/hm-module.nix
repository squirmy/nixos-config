{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.vim.enable {
  programs.vim.enable = true;
  programs.vim.defaultEditor = true;
}
