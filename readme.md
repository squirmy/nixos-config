# Squirmy's NixOS Config

A [NixOS Flake](https://nixos.wiki/wiki/Flakes) for my macOS development environment.

I have tried to keep this as simple as possible. I only have one machine and the simpler this configuration is the more likely I am to be able to maintain and keep this up to date.

There are many comments throughout the files helping to explain why lines of configuration exist. I'm going to need this later when I forget just exactly why I put that line there.

My introduction to NixOS was through the following resources:

- https://xyno.space/post/nix-darwin-introduction
- https://github.com/malob/nixpkgs
- https://github.com/srid/nixos-config

Combined, they proved a handy resource for working out where I was going wrong, and how I might improve this setup. They also introduced me to some new tools which I'll be trialling instead of my previous setup.

One thing is for sure, creating your own flake is personal, as each of the above configurations were differently structured. This configuration is no different.

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
