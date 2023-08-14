# Squirmy's NixOS Config

A [NixOS Flake](https://nixos.wiki/wiki/Flakes) for my macOS development environment.

I have tried to keep this as simple as possible.I only have one machine and the simpler this configuration is the more likely I am to be able to maintain and keep this up to date.

There are many comments throughout the files helping to explain why lines of configuration exist. I'm going to need this later when I forget just exactly why I put that line there.

My introduction to NixOS was through the following resources:

- https://xyno.space/post/nix-darwin-introduction
- https://github.com/malob/nixpkgs
- https://github.com/srid/nixos-config

Combined, they proved a handy resource for working out where I was going wrong, and how I might improve this setup. They also introduced me to some new tools which I'll be trialling instead of my previous setup.

One thing is for sure, creating your own flake is personal, as each of the above configurations were differently structured. This configuration is no different.

It's based heavily on srid's [nixos-config](https://github.com/srid/nixos-config). Without his [nixos-flake](https://github.com/srid/nixos-flake) module, modularizing the configuration would not have been as clean in this project.

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

```bash
bash <(curl -L 'https://raw.githubusercontent.com/squirmy/nixos-config/main/install.sh')
```

## I'm Not Squirmy

There are some things you need to be aware of before you run this on your system.

1. There are system defaults configured in [nix-darwin/macos.nix](./nix-darwin/macos.nix) that will persist even after installation. Double check that you're ok with these settings, and if not remove or customize them.
2. You need to customize your user details in [users/myself.nix](./users/myself.nix). Be sure to set your username, name and e-mail. You can customize the `flakeDirectory` if you wish to clone this repository to a different path.
3. You need to customize your hostname in [flake.nix](./flake.nix). The relevant config is `darwinConfigurations.{your-hostname-here}`. Run `hostname -s` to get the correct value.
4. Update the DNS resolvers in [nix-darwin/network.nix](./nix-darwin/network.nix) if you prefer another resolver.
5. Read through the rest of the files carefully and decide if you want the configuration. Remove anything you do not want to be included. You can always add things back in.

## Valuable Resources

Nix Darwin

- [LnL7/nix-darwin](https://github.com/LnL7/nix-darwin)
- [Darwin Configuration Options](https://daiderd.com/nix-darwin/manual/index.html)

Home Manager

- [nix-community/home-manager](https://github.com/nix-community/home-manager)
- [Home Manager Option Search](https://mipmip.github.io/home-manager-option-search)
