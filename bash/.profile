
# https://superuser.com/questions/789448/choosing-between-bashrc-profile-bash-profile-etc
# ~/.profile has the stuff NOT specifically related to bash, such as environment variables (PATH and friends)

# Source distro profile.
# Some distros include their own profile.
if [ -f ~/.profile.distro ]; then
    source ~/.profile.distro
fi

# Source local profile.
# Some machines require one-off customizations. Those go here.
if [ -f ~/.profile.local ]; then
    source ~/.profile.local
fi

# Add .local bins if not present
if [[ ! $PATH =~ "$HOME/.local/bin" ]]; then
    PATH=$HOME/.local/bin:$PATH
fi

# Add ~/bin if not present
if [[ ! $PATH =~ "$HOME/bin" ]]; then
    PATH=$HOME/bin:$PATH
fi

export PATH

