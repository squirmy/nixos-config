{
  config,
  flake,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (flake.config.myself) flakeDirectory;
in {
  # zsh
  # Why: It's the default on macOS, and I was previously
  # using oh-my-zsh.
  programs.zsh = {
    enable = true;
    initExtra = ''
      # Start typing + [Up-Arrow] - fuzzy find history forward
      autoload -U up-line-or-beginning-search
      zle -N up-line-or-beginning-search
      bindkey "^[[A" up-line-or-beginning-search # Up

      # Start typing + [Down-Arrow] - fuzzy find history backward
      autoload -U down-line-or-beginning-search
      zle -N down-line-or-beginning-search
      bindkey "^[[B" down-line-or-beginning-search # Down
    '';
    envExtra = ''
      # Colorize ls
      export CLICOLOR=1

      # Set default editor for all programs (including git)
      export VISUAL=vim
      export EDITOR="$VISUAL"
    '';
  };

  # kitty
  # The fast, feature-rich, GPU based terminal emulator
  # https://sw.kovidgoyal.net/kitty/
  # Why:
  #   1. Font & Color scheme is able to be configured easily, unlike iterm.
  #   2. Wasn't impressed with the Alacritty maintainers attitude towards
  #      accepting contributions from the community.
  #      - https://github.com/alacritty/alacritty/issues/3926
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    theme = "Tomorrow Night Eighties";
    extraConfig = ''
      # Use JetBrainsMono with its recommended font size and line height
      font_family JetBrainsMono Nerd Font
      font_size 13.0
      modify_font cell_height +2.6px";
    '';
  };
  # Switch the default icon out for a cuter one! 😸
  # Uses file: config/kitty/kitty-light.icns
  xdg.configFile."kitty/kitty.app.icns".source = mkOutOfStoreSymlink "${flakeDirectory}/config/kitty/kitty-light.icns";

  # Starship
  # The minimal, blazing-fast, and infinitely customizable prompt for any shell!
  # https://starship.rs/
  # Why: The prompt seems to do enough to suit my purposes, and looks nice.
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # Symbols taken from nerd-font-symbols preset
    # run: starship preset nerd-font-symbols
    settings = {
      aws.symbol = "  ";
      buf.symbol = " ";
      c.symbol = " ";
      conda.symbol = " ";
      dart.symbol = " ";
      directory.read_only = " 󰌾";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      fossil_branch.symbol = " ";
      git_branch.symbol = " ";
      golang.symbol = " ";
      guix_shell.symbol = " ";
      haskell.symbol = " ";
      haxe.symbol = "⌘ ";
      hg_branch.symbol = " ";
      hostname.ssh_symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      lua.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      meson.symbol = "󰔷 ";
      nim.symbol = "󰆥 ";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      os.symbols = {
        Alpaquita = " ";
        Alpine = " ";
        Amazon = " ";
        Android = " ";
        Arch = " ";
        Artix = " ";
        CentOS = " ";
        Debian = " ";
        DragonFly = " ";
        Emscripten = " ";
        EndeavourOS = " ";
        Fedora = " ";
        FreeBSD = " ";
        Garuda = "󰛓 ";
        Gentoo = " ";
        HardenedBSD = "󰞌 ";
        Illumos = "󰈸 ";
        Linux = " ";
        Mabox = " ";
        Macos = " ";
        Manjaro = " ";
        Mariner = " ";
        MidnightBSD = " ";
        Mint = " ";
        NetBSD = " ";
        NixOS = " ";
        OpenBSD = "󰈺 ";
        openSUSE = " ";
        OracleLinux = "󰌷 ";
        Pop = " ";
        Raspbian = " ";
        Redhat = " ";
        RedHatEnterprise = " ";
        Redox = "󰀘 ";
        Solus = "󰠳 ";
        SUSE = " ";
        Ubuntu = " ";
        Unknown = " ";
        Windows = "󰍲 ";
      };
      package.symbol = "󰏗 ";
      pijul_channel.symbol = "🪺 ";
      python.symbol = " ";
      rlang.symbol = "󰟔 ";
      ruby.symbol = " ";
      rust.symbol = " ";
      scala.symbol = " ";
      spack.symbol = "🅢 ";
    };
  };
}
