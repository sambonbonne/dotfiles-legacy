{
  allowUnfree = true;

  firefox = {
    enableGoogleTalkPlugin = true;
    enableAdobeFlash = true;
  };

  chromium = {
    enablePepperFlash = true; # Chromium's non-NSAPI alternative to Adobe Flash
    enablePepperPDF = true;
  };

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
        "python3.5-jedi"
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
        rustc
        cargo
        racer
        python3
        "python3.5-pip"
        "python3.5-jedi"

        fira
        fira-mono
      ];
    };
  };
}
