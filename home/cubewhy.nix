{
  osConfig,
  pkgs,
  ...
}: {
  imports = [
    ./software/lazyvim.nix
    ./software/rime.nix
    ./software/git-pagers.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cubewhy";
  home.homeDirectory = "/home/cubewhy";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    prismlauncher
    kitty
    ayugram-desktop
    fastfetch
    librewolf
    obs-studio
    jetbrains.idea
    vscode
    devenv
    claude-code

    thunderbird

    krita
    kdePackages.kate
    kdePackages.kdenlive
    kdePackages.ktorrent
    kdePackages.kcolorchooser

    kicad

    libreoffice-qt-fresh
    gimp-with-plugins
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  programs.git = {
    enable = true;
    ignores = [
      ".direnv/"
      ".DS_Store"
      "node_modules/"
      "*.swp"
    ];
    signing = {
      key = "2CC84D387218DAAA23335B31ACC7D792BD6F8124";
      signByDefault = true;
      format = "openpgp";
    };
    settings = {
      include.path = osConfig.sops.secrets.git_email_config.path;

      sendemail = {
        smtpserver = "smtp.gmail.com";
        smtpuser = "qby140326@gmail.com";
        smtpserverport = 465;
        smtpencryption = "ssl";
      };

      user = {
        name = "cubewhy";
        email = "qby140326@gmail.com";
      };
    };
  };

  programs.bash.enable = true;
  programs.zsh = {
    enable = true;

    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      theme = "robbyrussell";
    };

    shellAliases = {
      ll = "ls -l";
    };

    initExtra = ''
    '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cubewhy/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    ANTHROPIC_BASE_URL = "http://127.0.0.1:8045/v1/messages";
    ANTHROPIC_AUTH_TOKEN = "sk-localhost";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
