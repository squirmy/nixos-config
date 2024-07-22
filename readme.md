# Squirmy's NixOS Config

A [NixOS Flake](https://nixos.wiki/wiki/Flakes) for my macOS development environment.

This flake uses [nix-machine](https://github.com/squirmy/nix-machine) - a convenience flake for configuring your machine using [nix-darwin](https://github.com/LnL7/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager).

All configuration for my machine lives within [the configuration directory](./configuration/) and is disabled by default.

Configuration that I have deemed to be a good default for nix, nix-darwin, and home manager has been moved into [nix-machine's configuration directory](https://github.com/squirmy/nix-machine/tree/main/configuration).

The general contents of this flake are:

- MacOS defaults and network configuration
- Terminal emulator, prompt and shell setup
- Git configuration
- OpenSSH with Yubikey support
- VSCode configuration with unmanaged extensions
- Chat and video conferencing apps
- Various apps from the App Store via Homebrew
- Pre-commit checks: secrets, shellcheck and formatting

### Scripts

The [`install.sh`](./install.sh) and [`go.sh`](./go.sh) scripts are the entry points into this repository. The install script is used on a fresh macOS installation to bootstrap the development environment. The go script is used to apply new configuration, or update the flake inputs.

## Getting Started

### Install pre-requisites:

1. [NixOs](https://nixos.org/download) (Multi-user installation)
2. [Homebrew](https://brew.sh/)

### Clone this repository:

```bash
mkdir -p "$HOME/.config"
git clone https://github.com/squirmy/nixos-config "$HOME/.config/nixos-config"
```

### Run the ./go.sh script:

⚠️ Warning: Are you me? If not, stop and read [I'm not squirmy](#im-not-squirmy).

```bash
cd "$HOME/.config/nixos-config"
./go.sh
```

### Installing on a fresh macOS installation

I plan to run this on a fresh setup from time to time so I have created an install script to automate the above tasks. It can be tweaked for your own setup. Please be careful using this and take the time to understand how it works before you run it.

Steps:

1. Sign in with your Apple ID
2. Enable FileVault
3. Restart
4. Run the install script

```bash
bash <(curl -L 'https://raw.githubusercontent.com/squirmy/nixos-config/main/install.sh')
```

## I'm Not Squirmy

There are some things you need to be aware of before you run this on your system.

1. There are system defaults configured in [configuration/nix-darwin/macos.nix](./configuration/nix-darwin/macos.nix) that will persist even after installation. Double check that you're ok with these settings, and if not remove or customize them.
2. You need to customize your user details in [flake.nix](./flake.nix). Be sure to set your username, name and e-mail.
3. You need to customize your hostname in [flake.nix](./flake.nix). The relevant config is `nix-machine.macos.{your-hostname-here}`. Run `hostname -s` to get the correct value.
4. Update the DNS resolvers in [configuration/nix-darwin/network.nix](./configuration/nix-darwin/network.nix) if you prefer another resolver.
5. Read through the rest of the files carefully and decide if you want the configuration. Remove anything you do not want to be included. You can always add things back in.

## Known Issues

### 1. Could not write domain: com.apple.Safari.

This can be fixed by giving your terminal full disk access in Settings -> Privacy & Security -> Full Disk Access.

Fix found on [reddit](https://www.reddit.com/r/MacOSBeta/comments/15yjcnc/comment/jxdhpj4/).

> Safari is sandboxed preventing defaults from read/writing to it. Your terminal needs full disk access so defaults can access the sandboxed container.

## Valuable Resources

Nix Darwin

- [LnL7/nix-darwin](https://github.com/LnL7/nix-darwin)
- [Darwin Configuration Options](https://daiderd.com/nix-darwin/manual/index.html)

Home Manager

- [nix-community/home-manager](https://github.com/nix-community/home-manager)
- [Home Manager Option Search](https://mipmip.github.io/home-manager-option-search)
