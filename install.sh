#!/usr/bin/env bash

{ # Wrapping to prevent execution if this script was only partially downloaded

  set -euo pipefail

  username="squirmy"
  nixos_config_dir="$HOME/.config/nixos-config"
  nixos_config_repo_ssh="git@github.com:$username/nixos-config.git"
  nixos_config_repo_http="https://github.com/$username/nixos-config"

  info_level="\033[0;33m"
  success_level="\033[0;32m"
  error_level="\033[0;31m"

  function print() {
    echo -e "${1}${2}\033[0m"
  }

  function print_installed() {
    print "$success_level" "${1} already installed, skipping..."
  }

  function print_installing() {
    print "$info_level" "Installing ${1}..."
  }

  function install_clt() {
    description="Command Line Tools"

    if xcode-select --print-path &>/dev/null; then
      print_installed "$description"
    else
      print_installing "$description"
      touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
      product=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
      softwareupdate -i "$product" --verbose
    fi
  }

  function install_nixos() {
    description="NixOS"

    if which nix &>/dev/null; then
      print_installed "$description"
    else
      print_installing "$description"
      # NixOS multi-user installation
      curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix |
        sh -s -- install --no-confirm \
          --extra-conf 'extra-trusted-substituters = https://nix-community.cachix.org https://toyvo.cachix.org' \
          --extra-conf 'extra-trusted-public-keys = nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= toyvo.cachix.org-1:s++CG1te6YaS9mjICre0Ybbya2o/S9fZIyDNGiD4UXs='

      # Get nix into the path
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        set +u
        # shellcheck disable=SC1091
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        set -u
      fi
    fi
  }

  function install_homebrew() {
    description="Homebrew"

    if which brew &>/dev/null; then
      print_installed "$description"
    else
      print_installing "$description"
      NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  }

  function clone_nixos_config() {
    if [ ! -d "$nixos_config_dir" ]; then
      git clone "$nixos_config_repo_http" "$nixos_config_dir"
      git -C "$nixos_config_dir" remote set-url origin "$nixos_config_repo_ssh"
    fi
  }

  function set_config() {
    if [ -z "${NIXOS_CONFIG_HOSTNAME+x}" ]; then
      echo "Hostname not set. Use: NIXOS_CONFIG_HOSTNAME=<hostname> install.sh"
      exit 1
    fi

    echo "NIXOS_CONFIG_HOSTNAME=\"$NIXOS_CONFIG_HOSTNAME\"" >"$nixos_config_dir/.env"
  }

  function go() {
    (
      cd "$nixos_config_dir"
      bash -c "./go.sh --install-hook"
    )
  }

  current_username=$(id -un)
  if [ "$current_username" != "$username" ]; then
    print "$error_level" "If you're $username. You've got the wrong username: ${current_username}"
    print "$error_level" "If you're not. This script is for helping me install from fresh. Take your time to understand what this does before running it."
    exit 1
  fi

  install_clt
  install_nixos
  install_homebrew
  clone_nixos_config
  set_config
  go

} # End of wrapping
