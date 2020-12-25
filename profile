#
# ~/.profile
# Eventually sourced by the shell
#

# disable XON/XOFF
stty -ixon

SH_CONFIG_PATH="${HOME}/.config/profile"
load_sh_config() {
  source "${SH_CONFIG_PATH}/${1}.sh"
}

load_sh_config "detect_os"
load_sh_config "path"
load_sh_config "ssh_agent"
load_sh_config "lc"
load_sh_config "tools"
load_sh_config "aliases"
load_sh_config "prompt"

# Eventually source Nix own env
nix_env_path="${HOME}/.nix-profile/etc/profile.d/nix.sh"
[ -e "${nix_env_path}" ] && . "${nix_env_path}"
unset nix_env_path

# sometimes the TERM variable is not really pretty
if [[ $TERM == xterm || $TERM == vt220 ]]; then
    export TERM="xterm-256color"
fi

# Enventually set LXC infos
is_on_lxc && load_sh_config 'lxc'

# Welcome message when ready
load_sh_config "welcome"
