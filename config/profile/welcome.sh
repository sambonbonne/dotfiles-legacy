#!/usr/bin/env sh

COLOR_BLACK=$(echo -en '\033[00;30m')
COLOR_RED=$(echo -en '\033[00;31m')
COLOR_GREEN=$(echo -en '\033[00;32m')
COLOR_YELLOW=$(echo -en '\033[00;33m')
COLOR_BLUE=$(echo -en '\033[00;34m')
COLOR_MAGENTA=$(echo -en '\033[00;35m')
COLOR_CYAN=$(echo -en '\033[00;36m')
COLOR_WHITE=$(echo -en '\033[01;37m')
COLOR_RESET=$(echo -en '\033[0m')

CHECK_FILE="/tmp/.welcome-$(id -u)-$(date '+%Y-%m-%d')"

if [ ! -f "${CHECK_FILE}" ]; then

  welcome_left_bar_top="${COLOR_BLACK}▖${COLOR_RESET}"
  welcome_left_bar_middle="${COLOR_BLACK}▌${COLOR_RESET}"
  welcome_left_bar_bottom="${COLOR_BLACK}▘${COLOR_RESET}"

  echo "  ${welcome_left_bar_top}
  ${welcome_left_bar_middle}  Hello ${COLOR_CYAN}$(tput bold)$(id -u -n)$(tput sgr0)${COLOR_RESET}
  ${welcome_left_bar_middle}
  ${welcome_left_bar_middle}  ⏰  ${COLOR_GREEN}$(uptime -p | sed 's/^up //')${COLOR_RESET}
  ${welcome_left_bar_middle}  🏭  ${COLOR_YELLOW}$(cat /proc/loadavg | cut -d ' ' -f 1-3)${COLOR_RESET}
  ${welcome_left_bar_middle}  🚂  ${COLOR_RED}$(ps aux | wc -l)${COLOR_RESET}
  ${welcome_left_bar_bottom}"

  touch "${CHECK_FILE}"
fi
