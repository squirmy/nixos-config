{
  pkgs,
  lib,
  config,
  ...
}: let
  openssh-key-parser = {
    buildPythonPackage,
    setuptools-scm,
    bcrypt,
    cryptography,
    ...
  }:
    buildPythonPackage {
      pname = "openssh-key-parser";
      version = "0.0.7";
      pyproject = true;

      src = pkgs.fetchFromGitHub {
        owner = "scottcwang";
        repo = "openssh_key_parser";
        rev = "1e35d9f1254e617eb3a35cfc9eee67f36944d30b";
        sha256 = "sha256-cAPQwrRs+5HGmwG4wF5HiIFPcVQvr99M79rbgM6e6xg=";
      };

      nativeBuildInputs = [
        setuptools-scm
      ];

      propagatedBuildInputs = [
        bcrypt
        cryptography
      ];

      doCheck = false;
    };
in
  lib.mkIf config.squirmy.yubikey.enable {
    home.packages = with pkgs; [
      # YubiKey Manager
      # Cross-platform application for configuring any YubiKey over all USB interfaces
      # https://www.yubico.com/support/download/yubikey-manager/
      yubikey-manager

      # openssh-key-parser
      # Utilities to parse and pack OpenSSH private and public key files.
      # https://github.com/scottcwang/openssh_key_parser
      # Why: Mentioned on https://developers.yubico.com/SSH/Securing_SSH_with_FIDO2.html
      # for viewing the contents of the private key.
      # Usage: python -m openssh_key ~/.ssh/id_ed25519_sk
      (pkgs.python311Packages.python.withPackages (python-pkgs: [
        (pkgs.callPackage openssh-key-parser {
          inherit (python-pkgs) setuptools-scm bcrypt cryptography buildPythonPackage;
        })
      ]))
    ];
  }
