{ pkgs, ... }:

{
  programs.vscode.enable = true;
  programs.vscode.enableUpdateCheck = false;
  programs.vscode.enableExtensionUpdateCheck = false;

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    bbenoist.nix
    dbaeumer.vscode-eslint
    rust-lang.rust-analyzer
    tamasfe.even-better-toml
    serayuzgur.crates
  ];

  programs.vscode.userSettings = {
    "editor.fontFamily" = "Fira Code";
    "editor.fontLigatures" = true;
    "editor.fontWeight" = "450"; # Retina
  };
}
