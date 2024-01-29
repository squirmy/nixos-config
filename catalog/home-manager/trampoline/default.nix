{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
  mkIf (pkgs.stdenv.hostPlatform.isDarwin && config.squirmy.trampoline.enable) {
    # Install MacOS applications to the user Applications folder. Also update Docked applications
    # Why: Applications installed by home-manager don't show up in spotlight. This
    # module works around the issue. Can be removed if this is ever included
    # in home-manager.
    # Issue: https://github.com/nix-community/home-manager/issues/1341
    home.extraActivationPath = with pkgs; [
      rsync
      dockutil
      gawk
    ];
    home.activation.trampolineApps = hm.dag.entryAfter ["writeBoundary"] ''
      ${builtins.readFile ./trampoline-apps.sh}
      fromDir="$HOME/Applications/Home Manager Apps"
      toDir="$HOME/Applications/Home Manager Trampolines"
      sync_trampolines "$fromDir" "$toDir"
    '';
  }
