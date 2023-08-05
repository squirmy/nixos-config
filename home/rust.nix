{ pkgs, ... }:

{
  # fenix
  # Rust toolchains and rust-analyzer nightly for Nix
  # https://github.com/nix-community/fenix
  # Why: This appeared to be a nice way to install and
  # manage the rust toolchain. No experience with this.
  # Time will tell.
  # Note: Requires the overlay to be present in nix-darwin/nix.nix
  home.packages = with pkgs; [
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer-nightly
  ];
}
