{flake, ...}: {
  # Allow using TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Configure system defaults:
  # 1. Dark mode
  # 2. Disable options which mess with the keyboard input
  #
  # Warning: These values are not reset when removing them.
  # If you wish to rollback, you'll have to set it
  # to the value to update to.
  # Issue: https://github.com/LnL7/nix-darwin/issues/88
  system.defaults.NSGlobalDomain = {
    AppleShowAllFiles = true;
    AppleInterfaceStyle = "Dark";
    AppleInterfaceStyleSwitchesAutomatically = false;
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled = false;
    NSAutomaticSpellingCorrectionEnabled = false;
  };

  system.defaults.dock.appswitcher-all-displays = true;

  # Set the user's name & home directory. This should be
  # in sync with home manager. (home/default.nix)
  users.users.${flake.config.myself.username} = {
    name = flake.config.myself.username;
    home = flake.config.myself.home;
  };
}
