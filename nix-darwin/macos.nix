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

  system.defaults.CustomUserPreferences = {
    NSGlobalDomain.WebKitDeveloperExtras = true;

    "com.apple.Safari" = {
      # Don’t send search queries to Apple
      UniversalSearchEnabled = false;
      SuppressSearchSuggestions = true;
      AutoOpenSafeDownloads = false;

      # Enable debug menu, developer menu and web inspector
      IncludeInternalDebugMenu = true;
      IncludeDevelopMenu = true;
      WebKitDeveloperExtrasEnabledPreferenceKey = true;
      "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;

      # Spell check, but don't correct
      WebContinuousSpellCheckingEnabled = true;
      WebAutomaticSpellingCorrectionEnabled = false;

      # Disable AutoFill
      AutoFillPasswords = false;
      AutoFillFromAddressBook = false;
      AutoFillCreditCardData = false;
      AutoFillMiscellaneousForms = false;
    };

    "com.apple.SoftwareUpdate" = {
      AutomaticCheckEnabled = true;
      # Check for software updates daily, not just once per week
      ScheduleFrequency = 1;
      # Download newly available updates in background
      AutomaticDownload = 1;
      # Install System data files & security updates
      CriticalUpdateInstall = 1;
    };

    # Turn on app auto-update
    "com.apple.commerce".AutoUpdate = true;
  };

  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  # Set the user's name & home directory. This should be
  # in sync with home manager. (home/default.nix)
  users.users.${flake.config.myself.username} = {
    name = flake.config.myself.username;
    home = flake.config.myself.home;
  };
}
