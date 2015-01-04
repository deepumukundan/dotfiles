#!/usr/bin/env bash
#
# update local installs

echo -n "homebrew... "
brew update
brew outdated
