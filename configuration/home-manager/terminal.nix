{
  lib,
  config,
  ...
}:
lib.mkIf config.squirmy.terminal.enable {
  # fzf
  # 🌸 A command-line fuzzy finder
  # https://github.com/junegunn/fzf
  # Why: Handy for searching through history for past commands
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
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
