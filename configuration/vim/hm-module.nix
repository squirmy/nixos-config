{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.squirmy.vim.enable {
  home.packages = [
    pkgs.xclip
    pkgs.tree-sitter
    pkgs.nodejs_22
  ];

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.vimAlias = true;
  programs.neovim.vimdiffAlias = true;

  programs.ripgrep.enable = true;

  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/users/${config.nix-machine.username}/.config/nixos-config/configuration/vim/config";
}
