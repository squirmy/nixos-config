#!/usr/bin/env bash

# On a fresh NixOS installation `darwin-rebuild` is not installed. This command uses nix to
# download `darwin-rebuild` and execute it. Once this is complete `darwin-rebuild` will
# be installed, but it's rather simple to just keep using the same command.

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

# My hostname seemed to reset itself when setting up a fresh mac. Possibly
# being set by company mdm software. So I check here to see if it needs to
# be set again.
set_hostname

nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake .#"${hostname}"
nix develop --command bash -c "true"
