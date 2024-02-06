{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.slack.enable {
  homebrew.masApps = {
    "Slack for Desktop" = 803453959;
  };
}
