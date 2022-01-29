{ config, pkgs, nixpkgs, lib, ... }:
{
  imports =
    [
      ../programs/zsh/zsh.nix
      ../programs/neovim/neovim.nix
      ../programs/git.nix
    ];

  home = {
    stateVersion = "21.05";
    packages = with pkgs; [
      cabal-install
      #cachix
      #gawk
      #jsonnet
      lorri
      #mypy
      #pandoc
      #pyright
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
      #nodePackages.javascript-typescript-langserver
      #nodePackages.uglify-js
    ];
  };


  programs.fzf.enable = true;
  programs.bat = {
    enable = true;
    config.theme = "ansi-dark";
  };


  home.file.".ipython/profile_default/ipython_config.py".text = ''
    c.InteractiveShellApp.extensions = ["autoreload"]
    c.InteractiveShellApp.exec_lines = ["%autoreload 2"]
    '';
}
