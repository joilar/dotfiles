
# https://superuser.com/questions/789448/choosing-between-bashrc-profile-bash-profile-etc
# ~/.bash_profile should be super-simple and just load .profile and .bashrc (in that order)

if [ -f ~/.profile ]; then
	. ~/.profile
fi

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

