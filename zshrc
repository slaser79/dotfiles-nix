export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="af-no-magic"

CASE_SENSITIVE="true"

DISABLE_AUTO_TITLE="true"

COMPLETION_WAITING_DOTS="true"
plugins=(git tmuxinator nix-shell)

# User configuration
alias ls="ls -lF"
alias bat="batcat"

export PATH="/run/current-system/sw/bin:/usr/local/bin:/bin:/usr/sbin:/sbin:/usr/bin:$HOME/.local/bin:$HOME/.cargo/bin"
export EDITOR='vim'
export TERM="xterm-256color"

source $ZSH/oh-my-zsh.sh

setopt interactivecomments

# fzf
if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
  bindkey -r '^T'
  bindkey '^B' fzf-history-widget
fi

#Nix
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi

# GHC (Haskell)
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"


# direnv
eval "$(direnv hook zsh)"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

vterm_printf(){
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH

. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
# End Nix

# For stuff not suppose to be version controlled
if [ -e ~/.env ]; then
  source ~/.env
fi

