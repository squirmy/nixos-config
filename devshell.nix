{...}: {
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    treefmt.config = {
      inherit (config.flake-root) projectRootFile;
      package = pkgs.treefmt;
      flakeCheck = false;

      programs = {
        alejandra.enable = true;
        deadnix.enable = true;
        shfmt.enable = true;
        prettier.enable = true;
        taplo.enable = true;
      };
    };

    pre-commit = {
      check.enable = true;
      settings.hooks = {
        treefmt.enable = true;
        shellcheck.enable = true;
        gitleaks = {
          enable = true;
          name = "gitleaks";
          entry = "${pkgs.gitleaks}/bin/gitleaks protect --verbose --redact --staged";
          language = "system";
          pass_filenames = false;
        };
      };
    };

    formatter = config.treefmt.build.wrapper;

    devshells.default = {
      devshell.startup = {
        pre-commit.text = ''
          ${config.pre-commit.installationScript}
        '';
      };
    };
  };
}
