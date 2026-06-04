{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.ninetofive.enable {
  # drawio
  # Diagramming and whiteboard application
  # https://www.drawio.com
  home.packages = [
    pkgs.drawio
  ];
}
