# -*- shell-script -*-
#
# deepumukundan mac os x .bash_profile
#

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Load the default .profile
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

# Set path
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

# Set aliases for frequently used commands
alias c='clear'
alias ls='ls -GF'
alias tw='open -a TextWrangler '
alias y='open -a Yoink '
alias t='tree -aCF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Terminal colors
case "$TERM" in
    xterm*) color_prompt=yes;;
    eterm-color*) color_prompt=yes;;
    *) ;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u \d \t \!\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt

# when in a terminal window, change the title bar:
case "$TERM" in
    xterm*|rxvt*)
      PS1="\[\e]0;\u@\h: \w\a\]$PS1"
      ;;
    *)
      ;;
esac

# bash completion via homebrew
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# Load private settings
if [ -f $HOME/.bash_private ]; then
    source $HOME/.bash_private
fi

# Load work specific settings
if [ -f $HOME/.bash_work ]; then
    source $HOME/.bash_work
fi

# RVM settings
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Brew cask settings - Symlink to /Applications directory by default
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
