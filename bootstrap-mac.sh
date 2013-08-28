#!/bin/bash

# THIS IS A WORK IN PROGRESS
# BE CAREFUL!
#
# Credit where credit is due. I based this on
# Steve Losh's bootstrap.sh

# Don't forget the SSH keys. They need to be in place for
# the pull from cosine to work!

# Remove files that will be replaced
rm -f ~/.hgrc
rm -f ~/.hgignore
rm -f ~/.zshrc
rm -f ~/.bashrc
rm -f ~/.bash_profile
rm -rf ~/.vim
rm -f ~/.vimrc

# Create base directories
mkdir -p ~/scratch
mkdir -p ~/lib/hg
mkdir -p ~/lib/python
mkdir -p ~/lib/virtualenvs
mkdir -p ~/bin
mkdir -p ~/src

export PATH="$HOME/lib/hg/hg-stable:$PATH"
cd ~/lib/hg/hg-stable
make local
hg up
make local
cd


git clone git://github.com/sjl/oh-my-zsh.git ~/lib/oh-my-zsh
git clone git://github.com/sjl/z-zsh.git ~/lib/z

sudo easy_install hg-git

hg clone http://bitbucket.org/ianb/pip/ ~/lib/python/pip
cd ~/lib/python/pip
sudo python setup.py install
cd

sudo pip install virtualenv

hg clone http://bitbucket.org/dhellmann/virtualenvwrapper ~/lib/python/virtualenvwrapper
cd ~/lib/python/virtualenvwrapper
sudo python setup.py install
cd

rm -f ~/.hgrc

#ln -s "$HOME/lib/dotfiles/zsh" "$HOME/lib/oh-my-zsh/custom"

ln -s "$HOME/lib/dotfiles/.gitconfig" "$HOME/.gitconfig"
ln -s "$HOME/lib/dotfiles/.hgrc" "$HOME/.hgrc"
ln -s "$HOME/lib/dotfiles/.cvsignore" "$HOME/.cvsignore"
ln -s "$HOME/lib/dotfiles/vim" "$HOME/.vim"
ln -s "$HOME/lib/dotfiles/vim/vimrc" "$HOME/.vimrc"
ln -s "$HOME/lib/dotfiles/.screenrc" "$HOME/.screenrc"

ln -s "$HOME/lib/dotfiles/.zshrc" "$HOME/.zshrc"

hg clone bb://sjl/hg-prompt/ "$HOME/lib/hg/hg-prompt"
hg clone bb://sjl/hg-paste/ "$HOME/lib/hg/hg-paste"
hg clone bb://sjl/hg-review/ "$HOME/src/hg/hg-review"
hg clone bb://ccaughie/hgcollapse/ "$HOME/lib/hg/hgcollapse"
hg clone bb://durin42/histedit/ "$HOME/lib/hg/histedit"
hg clone bb://durin42/hg-git/ "$HOME/lib/hg/hg-git"
hg clone bb://Bill_Barry/hgattic "$HOME/lib/hg/hgattic"
hg clone bb://edgimar/crecord "$HOME/lib/hg/crecord"

# Get android sdk
wget http://dl.google.com/android/android-sdk_r20.0.3-macosx.zip -O ~/scratch/
cd ~/lib
unzip ~/scratch/android-sdk_r16-macosx.zip
~/lib/android-sdk-macosx/tools/android update sdk --no-ui
