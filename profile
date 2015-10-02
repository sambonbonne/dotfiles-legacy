# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# append path if not already in
path_append() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:$PATH"
    fi
}
path_append "$HOME/bin"
path_append "$HOME/.npm/bin"

# export some variables
export LANG=fr_FR.UTF-8
export LANGUAGE=fr_FR:en_US:en
export LC_ALL="fr_FR.UTF-8"
export EDITOR=/bin/vim
export TERMINAL=zsh
if [[ $TERM == xterm ]]; then
    export TERM=xterm-256color
fi

export JAVA_HOME=/usr/lib/jvm/default
export ANDROID_HOME=/opt/android-sdk

# Start SSH agent if not exists, thanks Julien Palard for inspiration
# Warning ! You have to launch ssh-add manually ! (not a bug, wanted feature)
ssh_agents_number="$(ls -1 /tmp/ssh-*/* 2>&1 > /dev/null | wc -l)"
if [ z"$ssh_agents_number" = z"1" ] ; then
    export SSH_AUTH_SOCK="$(printf "%s" /tmp/ssh-*/*)"
    export SSH_AGENT_PID="${SSH_AUTH_SOCK##/*/*.}"
else
    eval `ssh-agent` > /dev/null 2>&1
fi
