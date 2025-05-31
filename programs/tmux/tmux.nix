{  pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      continuum
      yank
      open
      dracula
    ];
    tmuxinator.enable = true;
    baseIndex = 1;
    keyMode = "vi";
    prefix = "C-space";
    historyLimit = 100000;
    extraConfig = builtins.readFile ./tmux.conf + builtins.readFile ./theme.conf + ''
      set -g default-command ${pkgs.zsh}/bin/zsh
    '';
  };
}
