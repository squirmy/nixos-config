{
  lib,
  config,
  ...
}: let
  githubLib = import ./lib.nix;
in {
  assertions = [
    {
      assertion = lib.length (lib.filter githubLib.isDefaultIdentity (lib.attrValues config.squirmy.github.identities)) <= 1;
      message = "squirmy.github.identities: at most one identity may be the default (empty `directories`).";
    }
  ];
}
