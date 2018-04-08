export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set aliases for frequently used commands
alias a='open -a "Visual Studio Code"'
alias bf='cd ~/Documents/Workspace/Personal/Brewfiles/Common'
alias c='clear'
alias code='open -a "Visual Studio Code"'
alias dd='cd ~/Library/Developer/Xcode/DerivedData'
alias dot='cd ~/.wsup/dotfiles'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias gh='cd ~/Documents/Workspace/Github-Clones'
alias grep='grep --color=auto'
alias h='history'
alias ls='ls -GF'
alias o='open .'
alias right="printf '%*s' $(tput cols)"
alias t='tree -aCF'
alias tw='open -a TextWrangler'
alias wd='cd ~/Documents/Workspace'
alias xb='sudo xcode-select -s /Applications/Xcode-beta.app'
alias xd='sudo xcode-select -s /Applications/Xcode.app'
alias xp='xcode-select -p'
alias xs='sudo xcode-select -s'
alias y='open -a Yoink'

# Functions
function 1p() { 1pass --fuzzy "$1" | pbcopy; }
function dpick() { cd $(find . -type d | pick) }
function f()  { find . -iname "*$1*" ${@:2} }
function gpick() { git checkout $(git branch | pick) }
function hpick() { $(history | cut -c8- | sort -u | pick) }
function kpick() { kill $(ps -e | awk '{if(NR!=1) { print $4, $1 }}' | pick -do | tail -n +2) }
function loc() { find . -type f -iname "*.[hm]" -exec wc -l {} \; | awk '{total += $1} END{print total}' }
function locs() { find . -type f -iname "*.swift" -exec wc -l {} \; | awk '{total += $1} END{print total}' }
function r()  { grep "$1" ${@:2} -R . }
function rule() { printf -v _hr "%*s" $(tput cols) && echo ${_hr// /${1--}}}
source ~/bin/shorten
source ~/bin/fixAppStore

# Brew cask settings - Symlink to /Applications directory by default
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# 1pass settings
export ONEPASSWORD_KEYCHAIN=~/Dropbox/Apps/1Password/Vaults/1Password.opvault

# Setup swift toolchains in path
export PATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:$PATH

# Setup swift environment manager
if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi

# Setup my commandline tools in path
export PATH=$PATH:~/bin

# Setup Fastlane autocompletion
. ~/.fastlane/completions/completion.sh

# Load personal and work configs
source $HOME/.bash_private
source $HOME/.bash_work

# Ruby environment manager
eval "$(rbenv init -)"

echo "🛣  PATH:" $PATH
echo "🎉  .bash_profile loaded..."
