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

-   [GNU Emacs](https://www.gnu.org/software/emacs/) with plugins such
    as evil-mode, ivy, projectile, magit, org-mode, lsp-mode and more
-   [neovim](https://neovim.io/) for basic text editing
-   [xmonad](https://xmonad.org/) as window-manager, with
    [Dunst](https://dunst-project.org/) for notifications and
    [polybar](https://polybar.github.io/) as status bar
-   [Zsh](https://www.zsh.org/) with [Oh My Zsh](https://ohmyz.sh/) as
    shell
-   [Alacritty](https://github.com/alacritty/alacritty) as terminal
    emulator
-   Appearance-wise i use [Iosevka](https://github.com/be5invis/Iosevka)
    as my default font and [Solarized
    dark](https://ethanschoonover.com/solarized/) as color theme

# Setup

-   [Install
    nix](https://nixos.org/manual/nix/stable/#sect-multi-user-installation)
    and set up flakes

-   [Set up
    home-manager](https://github.com/nix-community/home-manager#installation)

-   Clone this repository

    ``` {.shell}
    $ git clone git@github.com:sebastiant/dotfiles.git
    $ cd dotfiles
    ```

-   Change name, username and email if you\'re not me

    ``` {.shell}
    $ grep sebastian -r .
    $ # edit away!
    ```

-   Create the first generation

    -   NixOS

        ``` {.shell}
        $ sudo nixos-rebuild switch --flake '.#'
        ```

    -   Linux and macOS

        ``` {.shell}
        $ nix build && sudo ./result/activate && rm ./result
        ```
