# About

This repository contains my systems setup. I have three hosts set up by
this repository:

-   A Dell XPS laptop running [WSL2 on Ubunto](https://docs.microsoft.com/en-us/windows/wsl/install)
-   My work  Thinkpad laptop running [WSL1 on Ubuntu](https://docs.microsoft.com/en-us/windows/wsl/install)

I use [nix](https://nixos.org/) as package manager for all hosts. I use
[Home Manager](https://github.com/nix-community/home-manager) to declare
nix packages and configuration to use. All hosts are configured from their respective
[/hosts](file:///hosts) directory, [*hosts/common.nix*]{.spurious-link
target="hosts/common.nix"} contain shared configuration and
program-specific configuration live under
[*programs*](file:///programs/)

# My toolbox

-   [neovim](https://neovim.io/) for basic text editing
    - One configuration using COC for lsp
    - Another configuration using inbuilt nvim lsp and generally the nvim plugin ecosystem
-   [Zsh](https://www.zsh.org/) with [Oh My Zsh](https://ohmyz.sh/) as
    shell
-   [tmux](https://github.com/tmux/wiki) for managing terminal windows
-   Terminal is form
-   I use the [power level 10k theme](https://github.com/romkatv/powerlevel10k) for Zsh and [dracula](https://github.com/dracula/vim) as my default theme for vim 
-   I use the windows terminal for the terminal settings for WSL (manually configured)

# Setup

-   [Install
    nix](https://nixos.org/manual/nix/stable/#sect-multi-user-installation)
    and set up [flakes] (https://nixos.wiki/Flakes)

-   [Set up
    home-manager](https://github.com/nix-community/home-manager#installation)

-   Clone this repository

    ``` {.shell}
    $ git clone git@github.com:slaser79/dotfiles-nix.git
    $ cd dotfiles-nix
    ```

-   Change name, username and email if you\'re not me

    ``` {.shell}
    $ grep -E '(shingi|slaser)' -r .
    $ # edit away!
    ```

-   Create the first generation


    -   Linux and macOS

        ``` {.shell}
        $ nix build && sudo ./result/activate && rm ./result
        ```
    -   NixOS (Not implementated)

        ``` {.shell}
        $ sudo nixos-rebuild switch --flake '.#'
        ```
