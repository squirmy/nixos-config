# Why: Applications installed by home-manager don't show up in spotlight. This
# module works around the issue. Can be removed if this is ever included
# in home-manager.
# Issue: https://github.com/nix-community/home-manager/issues/1341
{
  config,
  pkgs,
  lib,
  ...
}: {
  home.activation = {
    trampolineApps = let
      apps = pkgs.buildEnv {
        name = "home-manager-applications";
        paths = config.home.packages;
        pathsToLink = "/Applications";
      };
    in
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        toDir="$HOME/Applications/HMApps"
        fromDir="${apps}/Applications"
        rm -rf "$toDir"
        mkdir "$toDir"
        (
          cd "$fromDir"
          for app in *.app; do
            /usr/bin/osacompile -o "$toDir/$app" -e "do shell script \"open '$fromDir/$app'\""
            icon="$(/usr/bin/plutil -extract CFBundleIconFile raw "$fromDir/$app/Contents/Info.plist")"
            if [[ $icon != *".icns" ]]; then
              icon="$icon.icns"
            fi
            mkdir -p "$toDir/$app/Contents/Resources"
            cp -f "$fromDir/$app/Contents/Resources/$icon" "$toDir/$app/Contents/Resources/applet.icns"
          done
        )
      '';
  };
}
