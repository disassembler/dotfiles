export ZSH="$HOME/lib/oh-my-zsh"
export ZSH_THEME="disasm"
export DISABLE_AUTO_UPDATE="true"
export OH_MY_ZSH_DEBUG="true"
plugins=(command-coloring pip fabric lein redis-cli vagrant)

#test -f "$HOME/src/hgd/hd" && export OH_MY_ZSH_HG="$HOME/src/hgd/hd" || export OH_MY_ZSH_HG='hg'

source $ZSH/oh-my-zsh.sh


# Custom options -------------------------------------------------------------
unsetopt promptcr

# Set hostname
export HOSTNAME=$(hostname)

# Useful aliases -------------------------------------------------------------
#alias vi='gvim'
#alias vim='gvim'
alias dbg='gvim --role "Debugger"'
alias gentoo='/usr/local/gentoo/startprefix'
alias d2='wine /pvr/diablo2/Diablo\ II/Diablo\ II.exe -w'
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"


# SSH Completion
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

# Aliases
# Restart Apache (MAMP)
alias rsthttpd="sudo apachectl restart"

# ls quickies
alias ll="ls -Fhl --color"
alias ls="ls -F --color"
alias la="ls -Fa --color"

alias j='z'
alias c='clear'
alias bp='bpython'

# t task manager
alias t='python ~/lib/python/t/t.py --task-dir ~/Dropbox/tasks --list tasks'
alias b='python ~/lib/python/t/t.py --task-dir ./bugs --list bugs'

# Drupal ctags
alias ctags-drupal='ctags --langmap=php:.engine.test.inc.module.theme.php --php-kinds=cdfi     --languages=php --recurse'

# PATH Changes ---------------------------------------------------------------
export PATH=~/bin:~/python/bin:/usr/local/bin:/usr/X11/bin:/usr/texbin:$PATH:$HOME/.rvm/bin
export MANPATH=$MANPATH:/usr/local/share/man

# Pear stack
#alias pear="php /usr/lib/php/pear/pearcmd.php" 
#alias pecl="php /usr/lib/php/pear/peclcmd.php"

# android sdk
export PATH=~/lib/android-sdk-macosx/tools:~/lib/android-sdk-macosx/platform-tools:$PATH

# Other
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# Ruby - RVM
#source ~/.rvm/scripts/rvm

# Environment variables ------------------------------------------------------
export EDITOR='vim'
export GREP_OPTIONS='-n --color=auto'
export HISTSIZE=1000
export HISTFILESIZE=1000
export HISTCONTROL=erasedups
export COMMAND_MODE=unix2003
export RUBYOPT=rubygems

# Lifelines Genealogy variables ----------------------------------------------

export LLDATABASES=.:/home/sbl5007/Dropbox/lifelines
export LLPROGRAMS=/home/sbl5007/Dropbox/lifelines/scripts

# Python variables -----------------------------------------------------------
export PIP_DOWNLOAD_CACHE="$HOME/.pip/cache"
export PYTHONSTARTUP="$HOME/.pythonrc.py"
export WORKON_HOME="${HOME}/lib/virtualenvs"
export PATH="${PATH}:/usr/local/share/python"
export PATH="${PATH}:$HOME/.lein/bin"
export PYTHONPATH="$PYTHONPATH:/usr/local/Cellar/python/2.7.1/lib/python2.7/site-packages"
export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python2.7.1/site-packages"
export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python2.7/site-packages"
export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python2.6/site-packages"
export VEW_PATH="$HOME/lib/python/virtualenvwrapper/virtualenvwrapper.sh"
export PYTHONPATH="$HOME/lib/python/see:$PYTHONPATH"
export NODE_PATH="$NODE_PATH:/usr/local/lib/node:/usr/local/lib/node_modules"

# Mercurial variables --------------------------------------------------------
export PATH="$HOME/lib/hg/hg-stable:$PATH"
export PYTHONPATH="$HOME/lib/hg/hg-stable:$PYTHONPATH"

# Extra ----------------------------------------------------------------------
source ~/lib/z/z.sh

# Pre-Prompt Command ---------------------------------------------------------
function precmd () {
    z --add "$(pwd -P)"
}

# Local Settings -------------------------------------------------------------
if [[ -s $HOME/.zshrc_local ]] ; then source $HOME/.zshrc_local ; fi
