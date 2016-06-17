#!/bin/sh

echo "                                                          {"
echo "                                                       {   }"
echo "o      O                 .oOOOo.                        }_{ __{"
echo "O      o                 o     o                     .-{   }   }-."
echo "o      O                 O.                         (   }     {   )"
echo "OoOooOOo                  \`OOoo.                    |\`-.._____..-’|"
echo "o      O .oOo. O   o           \`O .oOoO' \`oOOoOO.   |             ;--."
echo "O      o OooO' o   O            o O   o   O  o  o   |            (__  \\"
echo "o      o O     O   o     O.    .O o   O   o  O  O   |             | )  )"
echo "o      O \`OoO' \`OoOO      \`oooO'  \`OoO'o  O  o  o   |             |/  /"
echo "                   o                                |             /  /"
echo "                OoO'                                |            (  /"
echo "                                                    \\             y’"
echo "                                                     \`-.._____..-'"


say() {
  echo ""

  if [ ${#} -eq 1 ]; then
    echo "${1}"
  else
    local color=""

    case "${1}" in
      green ) local color="\033[0;32m";;
      blue ) local color="\033[0;34m";;
      red ) local color="\033[0;31m";;
    esac

    echo -e "${color}${2}\033[0m" "${color}" "${2}"
    #printf "%s%s\033[0m" "${color}" "${2}" # better than "echo -e" because echo options are not standards
  fi
}

say "Nice to see you! Take a tea, I manage all that for you"

fetch() {
  say "I start with a fetch, so I'll know if you need an update"
  git fetch > /dev/null 2>&1
}

apply_updates() {
  local _behind="$(git log --oneline "..@{u}" 2> /dev/null | wc -l | tr -d ' ')"
  if [ "${_behind}" -gt 0 ]; then
    say "You have ${_behind} update(s) to get, I stash to rebase them"
    if (git stash > /dev/null 2>&1 && git rebase > /dev/null 2>&1 && git stash pop > /dev/null 2>&1); then
      say green "That's OK, your ${_behind} updates are applied, now let's check if we need to push"
    else
      say red "Oops, it seems we can't fetch updates … I'll stop here :("
      return 1
    fi
  else
    say blue "It seems you haven't any update to get, so let's check if we need to push"
  fi

  return 0
}

send_updates() {
  local _ahead="$(git log --oneline "@{u}".. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "${_ahead}" -gt 0 ]; then
    say "You have ${_ahead} update(s) to send, I can push now"
    if (git push > /dev/null 2>&1); then
      say green "That's OK, your ${_ahead} updates are now sent, don't forget to get them in you other machines"
    else
      say red "Oops, it seems we can't push updates … I'll stop here :/"
      return 2
    fi
  else
    say blue "You haven't any update to send, I hope your configuration is nice for you"
  fi

  return 0
}

ended() {
  [ ${1} -eq 0 ] && say green "I'm happy say you all is OK, have a nice day :)" || say red "I'm sorry that didn't work, I know you are smart enough to fix the problem :S"
}


_action="${1:-all}"

case "${_action}" in
  fetch|get )  fetch; apply_updates; ended $?;;
  send|push ) send_updates; ended $?;;
  all ) fetch; apply_updates; send_updates; ended $?;;
  * ) say red "Unknow action ${_action}" && exit 1;;
esac
