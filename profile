# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.

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
export LC_CTYPE="fr_FR.UTF-8"
export LC_ALL="fr_FR.UTF-8"
export EDITOR=/bin/vim

if [[ $TERM == xterm ]]; then
    export TERM=xterm-256color
fi

export JAVA_HOME=/usr/lib/jvm/default
export ANDROID_HOME=/opt/android-sdk

# Start SSH agent if not exists and warn if no stored key
pidof ssh-agent 2>&1 > /dev/null || ssh-agent -a $XDG_RUNTIME_DIR/ssh-agent.socket
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket" ; export SSH_AGENT_PID=$(pidof ssh-agent)
ssh-add -L 2>&1 > /dev/null || echo "\033[0;31mNo SSH key stored, don't forget to add one\033[0m"
