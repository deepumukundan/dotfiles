#
# deepumukundan mac os x .bash_profile
#

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Set path
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# Set aliases for frequently used commands
alias c='clear'
alias ls='ls -GF'
alias tw='open -a TextWrangler'
alias a='open -a Atom'
alias h='history'
alias y='open -a Yoink'
alias t='tree -aCF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias right="printf '%*s' $(tput cols)"
alias dd='cd ~/Library/Developer/Xcode/DerivedData'
alias gh='cd ~/Documents/Workspace/Github-Clones'

# Functions
function 1p() { 1pass --fuzzy "$1" | pbcopy; }
function f()  { find . -iname "*$1*" ${@:2} }
function r()  { grep "$1" ${@:2} -R . }
function rule() { printf -v _hr "%*s" $(tput cols) && echo ${_hr// /${1--}}}
function hpick() { $(history | cut -c8- | sort -u | pick) }
function gpick() { git checkout $(git branch | pick) }
function dpick() { cd $(find . -type d | pick) }
function kpick() { kill $(ps -e | awk '{if(NR!=1) { print $4, $1 }}' | pick -do | tail -n +2) }
function loc() { find . -type f -iname "*.[hm]" -exec wc -l {} \; | awk '{total += $1} END{print total}' }
function locs() { find . -type f -iname "*.swift" -exec wc -l {} \; | awk '{total += $1} END{print total}' }
source ~/bin/shorten
source ~/bin/fixAppStore

source ~/.profile

# Load private settings
if [ -f $HOME/.bash_private ] && [ $USER = "deepumukundan" ]; then
    source $HOME/.bash_private
fi

# Load work specific settings
if [ -f $HOME/.bash_work ] && [ $USER = "dmukundan" ]; then
    source $HOME/.bash_work
fi

# Brew cask settings - Symlink to /Applications directory by default
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# 1pass settings
export ONEPASSWORD_KEYCHAIN=~/Dropbox/1Password/1Password.agilekeychain

# Setup swift environment manager
if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi

# Setup swift toolchains in the path
export PATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:$PATH

# RVM settings

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Fastlane autocompletion
. ~/.fastlane/completions/completion.sh
