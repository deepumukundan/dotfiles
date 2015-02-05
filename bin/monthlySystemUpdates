#!/usr/bin/env bash
#
# update local installs

brew update && brew upgrade && brew cleanup && brew prune
brew upgrade brew-cask && brew cask cleanup
sudo npm update -g
gem update
gem update --system
rvm get stable

brew outdated
