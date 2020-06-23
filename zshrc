export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="af-magic"

CASE_SENSITIVE="true"

DISABLE_AUTO_TITLE="true"

COMPLETION_WAITING_DOTS="true"
plugins=(git)

# User configuration
alias ls="ls -lF"

export PATH="/usr/local/bin:/bin:/usr/sbin:/sbin:/usr/bin:/usr/local/git/bin:/usr/texbin"
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
export LC_ALL=sv_SE.UTF-8 
export LANG=sv_SE.UTF-8
export EDITOR='vim'
export TERM="xterm-256color"

source $ZSH/oh-my-zsh.sh
source ~/.bin/tmuxinator.zsh

setopt interactivecomments

# jenv (Java environments)
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# GHC (Haskell)
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

# pyenv (Python)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init -)"
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
