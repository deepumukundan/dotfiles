#!/usr/bin/env bash
#
# update local installs

sudo npm update -g
gem update
gem update --system
brew update && brew upgrade
rvm get stable
brew outdated