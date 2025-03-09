
# https://superuser.com/questions/789448/choosing-between-bashrc-profile-bash-profile-etc
# ~/.bashrc has anything you'd want at an interactive command line. Command prompt, EDITOR variable, bash aliases for my use

# Source global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Source distro definitions
# Some distros include their own bashrc.
if [ -f ~/.bashrc.distro ]; then
    source ~/.bashrc.distro
fi

# Source local definitions
# Some machines require one-off customizations. Those go here.
if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

# Aliases

alias resource='source ~/.bash_profile'

alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -lh'
alias la='ll -a'

alias pu='pushd'
alias po='popd'

alias repos='cd ~/repos'
alias dotfiles='cd ~/dotfiles'
alias bin='cd ~/bin'

alias edit_shell='vim -o ~/.profile ~/.bashrc; resource'
alias esh='edit_shell'

alias edit_vim='vim ~/.vimrc'
alias evim='edit_vim'

alias edit_git='vim ~/.gitconfig'
alias egit='edit_git'

alias linode='ssh joilar@linode.johnoilar.com'

# Functions

function cdwhich ()
{
    local dir=$(dirname $(realpath $(which $1)))
    echo $dir
    cd $dir
}

# Variables

export EDITOR=/usr/bin/vim

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Perl local::lib
if [[ -d "$HOME/perl5/lib/perl5" ]]; then
    eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
fi

if [[ -f "$HOME/perl5/perlbrew/etc/bashrc" ]]; then
    source $HOME/perl5/perlbrew/etc/bashrc
fi

