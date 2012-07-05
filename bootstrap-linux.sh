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

wget http://personal.psu.edu/sbl5007/hg.tar.gz -O ~/scratch/hg.tar.gz
tar -zxvf ~/scratch/hg.tar.gz -C ~/lib

export PATH="$HOME/lib/hg/hg-stable:$PATH"
cd ~/lib/hg/hg-stable
make local
hg up
make local
cd
wget http://personal.psu.edu/sbl5007/hgrc-base -O ~/.hgrc

git clone https://github.com/disassembler/dotfiles.git ~/lib/dotfiles
git clone git://github.com/sjl/oh-my-zsh.git ~/lib/oh-my-zsh
git clone git://github.com/sjl/z-zsh.git ~/lib/z


hg clone bb://sjl/hg-prompt "$HOME/lib/hg/hg-prompt"
hg clone bb://sjl/hg-paste "$HOME/lib/hg/hg-paste"
hg clone bb://sjl/hg-review "$HOME/lib/hg/hg-review"
hg clone bb://peerst/hgcollapse "$HOME/lib/hg/hgcollapse"
hg clone bb://durin42/histedit "$HOME/lib/hg/histedit"
hg clone bb://Bill_Barry/hgattic "$HOME/lib/hg/hgattic"
hg clone bb://edgimar/crecord "$HOME/lib/hg/crecord"

# Get android sdk
wget http://dl.google.com/android/android-sdk_r16-linux.tgz -O ~/scratch/android-sdk_r16-linux.tgz
cd ~/lib
tar -zxvf ~/scratch/android-sdk_r16-linux.tgz
~/lib/android-sdk-linux/tools/android update sdk --no-ui

# remove temporary hgrc
rm -f ~/.hgrc

# link configs
ln -s "$HOME/lib/dotfiles/.gitconfig" "$HOME/.gitconfig"
ln -s "$HOME/lib/dotfiles/.hgrc" "$HOME/.hgrc"
ln -s "$HOME/lib/dotfiles/.cvsignore" "$HOME/.cvsignore"
ln -s "$HOME/lib/dotfiles/vim" "$HOME/.vim"
ln -s "$HOME/lib/dotfiles/vim/vimrc" "$HOME/.vimrc"
ln -s "$HOME/lib/dotfiles/.screenrc" "$HOME/.screenrc"

ln -s "$HOME/lib/dotfiles/.zshrc" "$HOME/.zshrc"
