{ config, pkgs, ... }:
{
  imports =
    [
      ./programs/zsh/zsh.nix
      ./programs/neovim.nix
      ./programs/git.nix
      ./programs/emacs/emacs.nix
    ];

  home = {
    stateVersion = "21.05";
    packages = with pkgs; [
      pandoc
      cabal-install
      ghc
      haskell-language-server
      stack
      ripgrep
      tree
      espeak
      blink1-tool
    ];
  };

  programs.fzf.enable = true;
  programs.bat = {
    enable = true;
    config.theme = "ansi-dark";
  };

  xdg.configFile."alacritty/alacritty.yml".source = ./programs/alacritty.yml;
  xdg.configFile."dunst/dunstrc".source = ./programs/dunstrc;
}