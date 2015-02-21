#
# deepumukundan mac os x .bash_profile
#

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Set path
export PATH=$PATH:~/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

# Set aliases for frequently used commands
alias c='clear'
alias ls='ls -GF'
alias tw='open -a TextWrangler'
alias a='open -a Atom'
alias y='open -a Yoink'
alias t='tree -aCF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Functions
function 1p() { 1pass --fuzzy "$1" | pbcopy; }
function f()  { find . -iname "*$1*" ${@:2} }
function r()  { grep "$1" ${@:2} -R . }
function rule() { printf -v _hr "%*s" $(tput cols) && echo ${_hr// /${1--}}}

# Load private settings
if [ -f $HOME/.bash_private ] && [ $USER = "deepumukundan" ]; then
    source $HOME/.bash_private
fi

# Load work specific settings
if [ -f $HOME/.bash_work ] && [ $USER = "dmukundan" ]; then
    source $HOME/.bash_work
fi

# RVM settings
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Brew cask settings - Symlink to /Applications directory by default
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# 1pass settings
export ONEPASSWORD_KEYCHAIN=~/Dropbox/1Password/1Password.agilekeychain
