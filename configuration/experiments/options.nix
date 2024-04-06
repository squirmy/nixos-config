{lib, ...}: {
  options.squirmy.experiments.enable = lib.options.mkEnableOption "experiments";
}
