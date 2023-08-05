#!/usr/bin/env bash

# On a fresh NixOS installation `darwin-rebuild` is not installed. This command uses nix to
# download `darwin-rebuild` and execute it. Once this is complete `darwin-rebuild` will
# be installed, but it's rather simple to just keep using the same command.

# The nixos-flake module provides a: `nix run .#activate` command which does the same as
# below. But it will only work once `darwin-rebuild` is installed.
# https://github.com/srid/nixos-flake/blob/master/flake-module.nix

HOSTNAME=$(hostname -s)

nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake .#"${HOSTNAME}"
