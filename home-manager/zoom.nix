{pkgs, ...}: {
  # zoom
  # Unified communication and collaboration platform
  # https://zoom.us
  # Why: I use zoom frequently for video conferencing.
  home.packages = with pkgs; [
    zoom-us
  ];
}
