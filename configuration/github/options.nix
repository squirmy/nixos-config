{lib, ...}: {
  options.squirmy.github.identities = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        pubkey = lib.mkOption {
          type = lib.types.str;
          description = "SSH public key (FIDO2 resident key) for this GitHub identity.";
        };

        directories = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [];
          description = ''
            Directories, relative to $HOME, that should use this identity.
            Empty means this is the machine's default identity — see
            `isDefaultIdentity` in ./lib.nix.
          '';
        };
      };
    });
    default = {};
    description = "GitHub identities (SSH key + optional directory scoping) for this machine.";
  };
}
