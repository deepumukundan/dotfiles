#! /bin/bash
# .bashrc for Darwin

# Configs

# Increase history size
HISTSIZE=5000
HISTFILESIZE=10000
# Append to history file from all sessions instead of overwriting
shopt -s histappend
# Disable ctrl+s suspend terminal
stty -ixon

# Terminal colors
if [ "$TERM" == "eterm-color" ]; then
    source ~/.bash_profile
fi

# Add RVM to PATH for scripting
# -----------------------------
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
