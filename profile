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

load_sh_config "path"
load_sh_config "ssh_agent"
load_sh_config "lc"
load_sh_config "tools"

# Eventually source Nix own env
local nix_env_path="${HOME}/.nix-profile/etc/profile.d/nix.sh"
[ -e "${nix_env_path}" ] && . "${nix_env_path}"
unset nix_env_path

# sometimes the TERM variable is not really pretty
if [[ $TERM == xterm || $TERM == vt220 ]]; then
    export TERM="xterm-256color"
fi
