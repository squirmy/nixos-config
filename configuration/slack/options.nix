{lib, ...}: {
  options.squirmy.slack.enable = lib.options.mkEnableOption "slack";
}
