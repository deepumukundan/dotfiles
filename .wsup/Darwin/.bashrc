#! /bin/bash
# .bashrc for Darwin

if [ "$TERM" == "eterm-color" ]; then
    source ~/.bash_profile
fi


# Add RVM to PATH for scripting
# -----------------------------
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
