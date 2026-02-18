# This script auto clones my lazyvim dotfiles into ~/.config/nvim
# https://github.com/cubewhy/.lazyvim
#
# Notes:
# 1. nix-ld configuration should be loaded to use LSP in nvim
# 2. You should always run `git pull` to update the LazyVim dotfiles manually.
# Call `git pull` inside .nix is not a good practice.
{
  pkgs,
  config,
  lib,
  ...
}: {
  home.activation.installLazyVim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    NVIM_CONFIG="${config.home.homeDirectory}/.config/nvim"
    REPO_URL="https://github.com/cubewhy/.lazyvim"

    if [ ! -d "$NVIM_CONFIG" ]; then
      ${pkgs.git}/bin/git clone "$REPO_URL" "$NVIM_CONFIG"
    elif [ -z "$(ls -A "$NVIM_CONFIG")" ]; then
      ${pkgs.git}/bin/git clone "$REPO_URL" "$NVIM_CONFIG"
    fi
  '';

  home.packages = with pkgs; [
    git
    github-cli
    wget
    ripgrep
    fd
    wl-clipboard
    lazygit
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    withPython3 = true;

    extraWrapperArgs = [
      "--set"
      "LIBSQLITE"
      "${pkgs.sqlite.out}/lib/libsqlite3.so"
    ];

    extraPackages = with pkgs; [
      # -- Dependencies for specific plugins --
      nodejs
      tree-sitter

      # Uncomment these lines if you want to view images inside nvim
      # imagemagick
      # mermaid-cli
      # tectonic

      # LSP
      nixd
      clang-tools
      lua-language-server
      basedpyright
      bash-language-server
      vscode-langservers-extracted
      docker-ls
      docker-compose-language-service
      yaml-language-server
      vtsls
      tailwindcss-language-server
      taplo
      ruff
      eslint
      ember-language-server
      cmake-language-server
      marksman
      gopls

      # Formatters
      stylua
      alejandra
      prettier
      shfmt

      # Linters
      cmake-lint
      hadolint
      shellcheck
      markdownlint-cli2
      golangci-lint

      # Debuggers
      (vscode-extensions.vadimcn.vscode-lldb.overrideAttrs
        (oldAttrs: {
          buildInputs = [pkgs.python312Packages.six];
        }))

      # Language tools
      markdown-toc
      gotools
      gofumpt
      gomodifytags

      # -- Build tools --
      gcc
      clang
      go
      rustc
      cargo
      gnumake
      luarocks
      unzip

      (python3.withPackages (python-pkgs:
        with python-pkgs; [
          pysocks
          debugpy
        ]))
    ];
  };
}
