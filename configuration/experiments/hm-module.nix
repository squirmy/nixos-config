{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  beam_pkgs = pkgs.beam.packagesWith pkgs.beam.interpreters.erlang;
  rust_pkgs = inputs.fenix.packages.${pkgs.stdenv.hostPlatform.system};
in
  lib.mkIf config.squirmy.experiments.enable {
    home.packages = [
      pkgs.discord

      # Convenience
      pkgs.colima
      pkgs.docker
      pkgs.go
      beam_pkgs.elixir
      beam_pkgs.erlang
      (rust_pkgs.complete.withComponents
        [
          "cargo"
          "clippy"
          "rust-src"
          "rustc"
          "rustfmt"
        ])
      rust_pkgs.rust-analyzer
    ];
  }
