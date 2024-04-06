{
  pkgs,
  config,
  lib,
  ...
}:
lib.mkIf config.squirmy.rider.enable {
  # Jetbrains Rider
  # Fast & powerful cross-platform .NET IDE
  # https://www.jetbrains.com/rider/
  home.packages = with pkgs; [
    jetbrains.rider
  ];
}
