{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.macos.enable {
  # Allow using TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Configure system defaults:
  # 1. Dark mode
  # 2. Disable options which mess with the keyboard input
  # 3. Disable macos hotkeys which mess with applications
  # 4. Configure Safari to be developer orientated
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
    _HIHideMenuBar = true;
  };

  system.defaults.dock.appswitcher-all-displays = true;
  system.defaults.dock.autohide = true;
  system.defaults.universalaccess.reduceMotion = true;

  system.defaults.CustomUserPreferences = {
    NSGlobalDomain.WebKitDeveloperExtras = true;

    "com.apple.Safari" = {
      # SmartSearchField = Address Bar
      ShowFullURLInSmartSearchField = true;

      # Always show website titles in tabs
      EnableNarrowTabs = 0;

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

      # Used for storing passkeys
      AutoFillPasswords = true;

      # Disable AutoFill
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

  system.activationScripts.extraUserActivation.text = let
    hotkeys = [
      32 # Mission Control
      34
      33 # Application windows
      35
      79 # Move left a space
      80
      81 # Move right a space
      82
    ];

    disabled = ''
      <dict>
        <key>enabled</key><false/>
        <key>value</key>
        <dict>
          <key>type</key><string>standard</string>
          <key>parameters</key>
          <array>
            <integer>65535</integer>
            <integer>65535</integer>
            <integer>0</integer>
          </array>
        </dict>
      </dict>
    '';

    # hotkeys: https://gist.github.com/mkhl/455002
    # credit: https://github.com/franckrasolo/dotfiles.nix/commit/0e314283388c0bdc6be795d25c686e755ec0680f
    disableHotKeyCommands = map (key: "defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add ${toString key} '${disabled}'") hotkeys;
  in ''
    echo >&2 "configuring hotkeys..."
    ${lib.concatStringsSep "\n" disableHotKeyCommands}
  '';

  # credit: https://medium.com/@zmre/nix-darwin-quick-tip-activate-your-preferences-f69942a93236
  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
