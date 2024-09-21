{ config, lib, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    initExtraBeforeCompInit = builtins.readFile ./zshrc;
    plugins = [
                 {
                    name = "powerlevel10k";
                    src = pkgs.zsh-powerlevel10k;
                    file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
                  }
                  {
                    name = "zsh-syntax-highlighting";
                    src = pkgs.fetchFromGitHub {
                            owner  = "zsh-users";
                            repo   = "zsh-syntax-highlighting";
                            rev    = "0.7.1";
                            sha256 = "gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
                    };
                  }  
        
              ];
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "tmuxinator"
        "colored-man-pages"
        "vi-mode"
        #"nix-shell"
      ];
    };
  };

  programs.fzf.enableZshIntegration = true;

  #home.file.".config/oh-my-zsh/themes/af-no-magic.zsh-theme".source = ./af-no-magic.zsh-theme;
  home.file.".p10k.zsh".source = ./.p10k.zsh;
}
#TODO need to delete this file
##/nix/store/n8x6ig1yf8ffpa07mwvxg6b7ilrrvfy1-nix-2.4/share/zsh/site-functions/_nix
