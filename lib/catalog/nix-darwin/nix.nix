{
  pkgs,
  inputs,
  ...
}: {
  # nix-darwin switches from the initially installed nix version to
  # a version that it places it in the store. This uses the latest
  # version from unstable.
  nix.package = pkgs.nixUnstable;

  # Use the already fetched nixpkgs when referring to nixpkgs outside of a flake
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  # The following settings are taken from https://github.com/DeterminateSystems/nix-installer
  nix.settings = {
    build-users-group = "nixbld";
    experimental-features = "nix-command flakes repl-flake";
    # https://github.com/NixOS/nix/issues/7273
    auto-optimise-store = false;
    bash-prompt-prefix = "(nix:$name)\040";
    max-jobs = "auto";
    extra-nix-path = "nixpkgs=flake:nixpkgs";
  };

  # Enable nix-daemon to support multi-user mode nix.
  # This is the recommended nix installation option.
  services.nix-daemon.enable = true;
}