{pkgs, ...}: let
  deltaThemes = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/dandavison/delta/main/themes.gitconfig";
    sha256 = "sha256-kPGzO4bzUXUAeG82UjRk621uL1faNOZfN4wNTc1oeN4=";
  };
in {
  xdg.configFile."delta/themes.gitconfig".source = deltaThemes;

  programs.delta = {
    enable = true;
    enableGitIntegration = true;

    options = {
      features = "decorations";
    };
  };

  xdg.configFile = {
    "lazygit/config.yml".text = ''
      git:
        log:
            order: default
        pagers:
          - pager: delta --dark --paging=never --line-numbers --features=colibri
            colorArg: always
          - pager: ydiff -p cat -s --wrap --width={{columnWidth}}
            colorArg: never
          - externalDiffCommand: difft --color=always
    '';
  };

  home.packages = with pkgs; [
    ydiff
    difftastic
  ];

  programs.git = {
    enable = true;

    includes = [
      {path = "~/.config/delta/themes.gitconfig";}
    ];
  };
}
