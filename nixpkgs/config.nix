{
  allowUnfree = true;

  packageOverrides = pkgs: rec {
    basic-environment = with pkgs; buildEnv {
      name = "basic-environment";

      paths = [
        tmux
        htop
        elinks
        zip
        unzip
      ];
    };

    desktop-environment = with pkgs; buildEnv {
      name = "desktop-environment";

      paths = [
        firefox

        libreoffice
        hunspell

        vlc
        easytags

        libnotify
        xsel
      ];
    };

    dev-environment = with pkgs; buildEnv {
      name = "dev-environment";

      paths = [
        neovim
        "python3.5-neovim"
        universal-ctags
        tmux
        fzy
        silver-searcher

        git
        diff-so-fancy
        httpie

        gnumake
        gcc-wrapper

        nodejs
        rust
        cargo
        python3
        "python3.5-pip"

        fira
        fira-mono
      ];
    };
  };
}
