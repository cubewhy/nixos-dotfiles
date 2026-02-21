{lib, ...}: {
  programs.zsh = {
    enable = true;

    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "zoxide" "dirhistory"];
      theme = "fino-time";
    };

    shellAliases = {
      ll = "ls -l";
      v = "zi && nvim";
    };

    initContent = lib.mkOrder 550 ''
      ZSH_DISABLE_COMPFIX="true"
    '';
  };
}
