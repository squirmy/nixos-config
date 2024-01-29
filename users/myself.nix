{...}: let
  username = "squirmy";
  home = "/Users/${username}";
in {
  inherit username home;
  name = "Adam Woods";
  email = "squirmy.dev@gmail.com";
  flakeDirectory = "${home}/.config/nixos-config";
}
