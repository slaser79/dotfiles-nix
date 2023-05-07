{ config, pkgs, nixpkgs, lib, ... }:
{
  imports =
    [
      ../programs/base.nix
      ../programs/zsh/zsh.nix
      ../programs/neovim-lsp
      ../programs/git.nix
      ../programs/docker.nix
    ];

  home = {
    stateVersion = "21.05";
    packages = with pkgs; [
      #cabal-install
      #cachix
      #gawk
      #jsonnet
      #lorri
      #mypy
      #pandoc
      #pyright
      fd #alternative to find
      ripgrep
      #sqlite
      #stack
      tree
      #zathura
      #kubectx
      #watchexec
      #lazydocker
      htop
      #httpie
      #k9s
      #whois
      jq
      #caddy
      #elixir_ls
      nodePackages.javascript-typescript-langserver
      nodePackages.pnpm
      #nodePackages.uglify-js
      # previously in my nix-env
      nix-diff
      nix-index
      nix-prefetch-git
      nixos-shell
      pcre-cpp
      binutils
      cabal2nix
      cachix
      cntr
      direnv
      entr
      ghcid
      glow
      grip
      ncdu
      niv
      nixfmt
      nodejs
      numactl
      pandoc
      postgresql
      python3
      shellcheck
      sqlite
    ];
  };


  programs.fzf.enable = true;
  programs.bat = {
    enable = true;
    config.theme = "ansi-dark";
  };

  modules.docker.enable = true;


  home.file.".ipython/profile_default/ipython_config.py".text = ''
    c.InteractiveShellApp.extensions = ["autoreload"]
    c.InteractiveShellApp.exec_lines = ["%autoreload 2"]
    '';
}
