{...}: {
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
      ll = "ls -l";
      v = "zi && nvim";
    };

    initExtra = ''
    '';
  };
}
