#!/usr/bin/env bash

set -euo pipefail

hostname="Adams-MBP"

function set_hostname() {
  current_hostname=$(hostname -s)
  if [ "$current_hostname" != "$hostname" ]; then
    read -p "Change hostname from: '$current_hostname' to '$hostname' ? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo "Setting hostname to $hostname"
      sudo scutil --set ComputerName "$hostname"
      sudo scutil --set LocalHostName "$hostname"
    else
      exit 1
    fi
  fi
}

function switch() {
  if which nh_darwin &>/dev/null; then
    # Once the flake has been switched once, nh-darwin is available to use
    nh_darwin os switch . --hostname "$hostname"
  else
    # On a fresh NixOS installation `darwin-rebuild` is not installed. This command uses nix to
    # download `darwin-rebuild` and execute it.
    nix run github:LnL7/nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake .#"${hostname}"
  fi
}

# My hostname seemed to reset itself when setting up a fresh mac. Possibly
# being set by company mdm software. So I check here to see if it needs to
# be set again.
set_hostname

if [ "${1:-}" == "--update" ]; then
  # Update flake inputs before applying the config
  nix flake update

  # Update non-nix managed dependencies
  dprint config update
fi

switch

if [ "${1:-}" == "--install-hook" ] || [ "${1:-}" == "--update" ]; then
  # Ensure nvim plugins are installed and up to date
  nvim --headless "+Lazy! sync" +qa

  # Trigger the devshell to install the pre-commit hooks.
  nix develop --command bash -c "true"
fi
