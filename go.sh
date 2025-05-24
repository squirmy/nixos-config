#!/usr/bin/env bash

set -euo pipefail

function read_config() {
  if [ -f .env ]; then
    # shellcheck disable=SC1091
    set -a && source .env && set +a
  fi

  if [ -z "${NIXOS_CONFIG_HOSTNAME+x}" ]; then
    echo "Hostname not set. Set NIXOS_CONFIG_HOSTNAME in .env"
    exit 1
  fi

  export NIX_CONFIG="accept-flake-config = true"
}

function set_hostname() {
  if [ ! -f /etc/NIXOS ]; then
    current_hostname=$(hostname -s)
    if [ "$current_hostname" != "$NIXOS_CONFIG_HOSTNAME" ]; then
      read -p "Change hostname from: '$current_hostname' to '$NIXOS_CONFIG_HOSTNAME' ? " -n 1 -r
      echo
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Setting hostname to $NIXOS_CONFIG_HOSTNAME"
        sudo scutil --set ComputerName "$NIXOS_CONFIG_HOSTNAME"
        sudo scutil --set LocalHostName "$NIXOS_CONFIG_HOSTNAME"
      else
        exit 1
      fi
    fi
  fi
}

function switch() {
  if [ ! -f /etc/NIXOS ]; then
    # On a fresh NixOS installation `darwin-rebuild` is not installed. This command uses nix to
    # download `darwin-rebuild` and execute it.
    sudo nix run github:LnL7/nix-darwin --extra-experimental-features "nix-command flakes" -- switch \
      --flake .#"${NIXOS_CONFIG_HOSTNAME}"
  else
    sudo nixos-rebuild switch --flake .#"${NIXOS_CONFIG_HOSTNAME}"
  fi
}

# My hostname seemed to reset itself when setting up a fresh mac. Possibly
# being set by company mdm software. So I check here to see if it needs to
# be set again.
read_config
set_hostname

if [ "${1:-}" == "--update" ]; then
  # Update flake inputs before applying the config
  nix --extra-experimental-features "nix-command flakes" flake update

  # Update non-nix managed dependencies
  dprint config update
fi

switch

if [ "${1:-}" == "--install-hook" ] || [ "${1:-}" == "--update" ]; then
  # Ensure nvim plugins are installed and up to date
  # Running it in a new shell ensures nvim is in the path after installation
  zsh -c 'nvim --headless "+Lazy! sync" +qa'

  # Trigger the devshell to install the pre-commit hooks.
  nix --extra-experimental-features "nix-command flakes" develop --command bash -c "true"
fi
