{
  lib,
  pkgs,
  inputs,
  ...
}: {
  # nix-darwin switches from the initially installed nix version to
  # a version that it places it in the store. This uses the latest
  # version from unstable.
  nix.package = lib.mkDefault pkgs.nixUnstable;

  # Use the already fetched nixpkgs when referring to nixpkgs outside of a flake
  nix.nixPath = lib.mkDefault ["nixpkgs=${inputs.nixpkgs}"];
  nix.registry.nixpkgs.flake = lib.mkDefault inputs.nixpkgs;

  # The following settings are taken from https://github.com/DeterminateSystems/nix-installer
  nix.settings = {
    build-users-group = lib.mkDefault "nixbld";
    experimental-features = lib.mkDefault "nix-command flakes repl-flake";
    # https://github.com/NixOS/nix/issues/7273
    auto-optimise-store = lib.mkDefault false;
    bash-prompt-prefix = lib.mkDefault "(nix:$name)\040";
    max-jobs = lib.mkDefault "auto";
    extra-nix-path = lib.mkDefault "nixpkgs=flake:nixpkgs";
  };

  # Enable nix-daemon to support multi-user mode nix.
  # This is the recommended nix installation option.
  services.nix-daemon.enable = lib.mkDefault true;
}
