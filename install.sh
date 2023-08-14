#!/usr/bin/env bash

{ # Wrapping to prevent execution if this script was only partially downloaded

  set -euo pipefail

  username="squirmy"
  hostname="Adams-MBP"
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
    print $success_level "${1} already installed, skipping..."
  }

  function print_installing() {
    print $info_level "Installing ${1}..."
  }

  function install_clt() {
    description="Command Line Tools"

    if xcode-select --print-path &> /dev/null; then
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

    if which nix &> /dev/null; then
      print_installed "$description"
    else
      print_installing "$description"
      # NixOS multi-user installation
      bash -c "$(curl -fsSL https://nixos.org/nix/install)" --daemon --yes

      # Get nix into the path
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        set +u
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        set -u
      fi
    fi
  }

  function install_homebrew() {
    description="Homebrew"

    if which brew &> /dev/null; then
      print_installed "$description"
    else
      print_installing "$description"
      bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  }

  function clone_nixos_config() {
    if [ ! -d "$nixos_config_dir" ]; then
      git clone "$nixos_config_repo_http" "$nixos_config_dir"
      git -C "$nixos_config_dir" remote set-url origin "$nixos_config_repo_ssh"
    fi
  }

  function backup_etc_shells() {
    etc_shells="/etc/shells"
    etc_shells_backup="${etc_shells}.before-nix-darwin"
    if [ -f $etc_shells ]; then
      if [ -f $etc_shells_backup ]; then
        print $success_level "Backup file $etc_shells_backup already exists, skipping..."
      else
        print $info_level "Backing up $etc_shells to $etc_shells_backup..."
        sudo mv /etc/shells /etc/shells.before-nix-darwin
      fi
    else
      print $success_level "$etc_shells already backed up, skipping..."
    fi
  }

  function set_hostname() {
    current_hostname=$(hostname -s)
    if [ "$current_hostname" != "$hostname" ]; then
      print $info_level "Setting hostname to $hostname"
      sudo scutil --set ComputerName "$hostname"
      sudo scutil --set LocalHostName "$hostname"
    else
      print $success_level "Hostname already set to $hostname, skipping..."
    fi
  }

  function go() {
    (
      cd "$nixos_config_dir"
      ./go.sh
    )
  }

  current_username=$(id -un)
  if [ "$current_username" != "$username" ]; then
    print $error_level "If you're $username. You've got the wrong username: ${current_username}"
    print $error_level "If you're not. This script is for helping me install from fresh. Take your time to understand what this does before running it."
    exit -1
  fi

  install_clt
  install_nixos
  install_homebrew
  clone_nixos_config
  backup_etc_shells
  set_hostname
  go

} # End of wrapping
