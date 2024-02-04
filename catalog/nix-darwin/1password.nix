{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.onepassword.enable {
  # Prefer installing application from the Mac App Store
  # Sometimes when installing an application the app store gives an error:
  # > Redownload Unavailable with This Apple ID
  # The fix for me was to install using the app store and then move the app to the trash
  # From then on the app is able to be installed using homebrew mas.
  homebrew.masApps = {
    "1Password for Safari" = 1569813296;
  };

  # If an app isn't available in the Mac App Store, or the version in the App Store has
  # limitiations, e.g., Transmit, install the Homebrew Cask.
  homebrew.casks = [
    # 1password
    # A password manager, digital vault, form filler and secure digital wallet.
    # https://1password.com
    # Why: Tried using nixpkgs#_1password-gui but this fails to launch
    # as it's not in the /Applications folder
    "1password"
  ];
}
