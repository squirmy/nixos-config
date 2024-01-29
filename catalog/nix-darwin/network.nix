{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.network.enable {
  # Use fast dns resolvers.
  networking.dns = [
    # Cloudflare
    "1.1.1.1"
    # Google
    "8.8.8.8"
  ];

  networking.knownNetworkServices = [
    "Wi-Fi"
    "USB 10/100/1000 LAN"
  ];
}
