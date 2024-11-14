{
  lib,
  config,
  pkgs,
  ...
}: let
  beam_pkgs = pkgs.beam.packagesWith pkgs.beam.interpreters.erlang;
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
    ];
  }
