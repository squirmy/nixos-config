{pkgs, ...}: {
  home.packages = with pkgs; [
    nodejs_20
    nodejs_20.pkgs.pnpm
  ];
}
