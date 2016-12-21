#
# ~/.profile
# Eventually sourced by the shell
#

# disable XON/XOFF
stty -ixon

SH_CONFIG_PATH="${HOME}/.config/profile"

source "${SH_CONFIG_PATH}/path.sh"
source "${SH_CONFIG_PATH}/ssh_agent.sh"
source "${SH_CONFIG_PATH}/lc.sh"
source "${SH_CONFIG_PATH}/tools.sh"

# Eventually source Nix own env
local nix_env_path="${HOME}/.nix-profile/etc/profile.d/nix.sh"
[ -e "${nix_env_path}" ] && . "${nix_env_path}"
unset nix_env_path

# sometimes the TERM variable is not really pretty
if [[ $TERM == xterm || $TERM == vt220 ]]; then
    export TERM="xterm-256color"
fi
