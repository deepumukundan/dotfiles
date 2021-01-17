export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set aliases for frequently used commands
alias a='open -a "Visual Studio Code"'
alias bf='cd ~/Documents/Workspace/Personal/Brewfiles'
alias c='clear'
alias cb='carthage bootstrap --platform iOS --cache-builds'
alias code='open -a "Visual Studio Code"'
alias cu='carthage update --platform iOS --cache-builds'
alias dd='cd ~/Library/Developer/Xcode/DerivedData'
alias dot='cd ~/.wsup/dotfiles'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias gh='cd ~/Documents/Workspace/Github-Clones'
alias grep='grep --color=auto'
alias gs='git stash'
alias gsp='git stash pop'
alias h='history'
alias hg='history | grep'
alias ip='ipconfig getifaddr en0 || ipconfig getifaddr en1'
alias ls='ls -GF'
alias o='open .'
alias pi='pod install'
alias pu='pod update'
alias right="printf '%*s' $(tput cols)"
alias sim='xcrun simctl'
alias t='tree -aCF'
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
function mp4() { ffmpeg -i $1.mov -vcodec h264 -acodec mp2 $1.mp4 }

source ~/bin/shorten
source ~/bin/fixAppStore

# Brew cask settings - Symlink to /Applications directory by default
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Setup Fastlane autocompletion
. ~/.fastlane/completions/completion.sh

# Setup swift toolchains in path
export PATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:$PATH

# Swift environment manager
if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi

# Ruby environment manager
eval "$(rbenv init -)"

# Node environment manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load personal and work configs
source $HOME/.bash_private
source $HOME/.bash_work

# Setup my commandline tools in path
export PATH=$PATH:~/bin

echo "🛣  PATH:" $PATH
echo "🎉  Personal preferences loaded..."