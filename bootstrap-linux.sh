#!/bin/bash

# THIS IS A WORK IN PROGRESS
# BE CAREFUL!
#
# Credit where credit is due. I based this on
# Steve Losh's bootstrap.sh

# Don't forget the SSH keys.

# Remove files that will be replaced
rm -rf ~/lib
rm -f ~/.hgrc
rm -f ~/.hgignore
rm -f ~/.zshrc
rm -f ~/.bashrc
rm -f ~/.bash_profile
rm -rf ~/.vim
rm -f ~/.vimrc
rm -f ~/.screenrc
rm -f ~/.gitconfig

# Create base directories
mkdir -p ~/scratch
mkdir -p ~/lib/hg
mkdir -p ~/lib/python
mkdir -p ~/lib/virtualenvs
mkdir -p ~/bin
mkdir -p ~/src

git clone https://github.com/disassembler/dotfiles.git ~/lib/dotfiles
git clone https://github.com/disassembler/oh-my-zsh.git ~/lib/oh-my-zsh
git clone https://github.com/sjl/z-zsh.git ~/lib/z

cd ~/lib/dotfiles
git submodule update --init --recursive

# Get android sdk
# wget http://dl.google.com/android/android-sdk_r16-linux.tgz -O ~/scratch/android-sdk_r16-linux.tgz
#cd ~/lib
#tar -zxvf ~/scratch/android-sdk_r16-linux.tgz
#~/lib/android-sdk-linux/tools/android update sdk --no-ui

# link configs
ln -s "$HOME/lib/dotfiles/.gitconfig" "$HOME/.gitconfig"
ln -s "$HOME/lib/dotfiles/.hgrc" "$HOME/.hgrc"
ln -s "$HOME/lib/dotfiles/.cvsignore" "$HOME/.cvsignore"
ln -s "$HOME/lib/dotfiles/vim" "$HOME/.vim"
ln -s "$HOME/lib/dotfiles/vim/vimrc" "$HOME/.vimrc"
ln -s "$HOME/lib/dotfiles/.screenrc" "$HOME/.screenrc"

ln -s "$HOME/lib/dotfiles/.zshrc" "$HOME/.zshrc"
