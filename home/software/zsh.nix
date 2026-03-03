{lib, ...}: {
  programs.zsh = {
    enable = true;

    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "zoxide" "dirhistory"];
      theme = "robbyrussell";
    };

    shellAliases = {
      v = "zi && nvim";
    };

    initContent = lib.mkOrder 550 ''
      ZSH_DISABLE_COMPFIX="true"
      export DISTROBOX_ENTER_PATH="/run/current-system/sw/bin/distrobox-enter"
    '';
  };
}
