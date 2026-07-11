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
    services.ollama = {
      enable = true;
      environmentVariables.OLLAMA_KEEP_ALIVE = "1m";
    };

    # home-manager's ollama module doesn't set RunAtLoad, so the agent only
    # restarts on crash and never starts automatically at login.
    launchd.agents.ollama.config.RunAtLoad = true;

    # "Background" ProcessType (upstream default) blocks Metal/GPU access,
    # causing ollama to silently fall back to CPU-only inference.
    launchd.agents.ollama.config.ProcessType = lib.mkForce "Standard";

    home.packages = [
      pkgs.discord
      pkgs.claude-code
      pkgs.obsidian

      # Convenience
      pkgs.colima
      pkgs.docker
      pkgs.go
      beam_pkgs.elixir_1_19
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
