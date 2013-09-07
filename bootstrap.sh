#!/bin/sh

if [ ! -d "$HOME/lib/dotfiles" ]; then
    echo "Installing YADR for the first time"
    git clone https://github.com/lfilho/dotfiles.git "$HOME/lib/dotfiles"
    cd "$HOME/lib/dotfiles"
    [ "$1" == "ask" ] && export ASK="true"
    rake install
else
    echo "dotfiles is already installed"
fi
