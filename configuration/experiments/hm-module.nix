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

      # pkgs.alt-tab-macos
      # todo; switch when this becomes available (https://github.com/NixOS/nixpkgs/pull/313973)
      # pkgs.teams-for-linux

      # Convenience
      pkgs.colima
      pkgs.docker
      pkgs.go
      beam_pkgs.elixir
      beam_pkgs.erlang
    ];
  }
