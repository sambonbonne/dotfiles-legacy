#!/usr/bin/env sh

##
# Dependencies: lemonbar wmctrl xdotool
##

killall -q lemonbar
while pgrep -u $UID -x lemonbar >/dev/null; do sleep 1; done

workspaces()
{
  workspaces="$(wmctrl -d | tr -s ' ' | cut -d ' ' -f 1,9)"
  current_workspace="$(wmctrl -d | grep '*' | tr -s ' ' | cut -d ' ' -f 1,9)"

  printf %s "$workspaces" | while IFS= read -r workspace; do
    workspace_index="$((${workspace:0:1} + 1))"
    switch_command="wmctrl -s ${workspace:0:1}"

    printf '%%{A:%s:}' "${switch_command}"

    if [ "${workspace}" = "${current_workspace}" ]; then
      if [ "${#workspace}" -ge 3 ]; then
        workspace_index="${workspace_index} $(echo "${workspace}" | cut -d ' ' -f 2-)"
      fi

      printf "%%{B#00C853} %s %%{B-}%%{A} " "${workspace_index}"
    else
      printf "%%{B#2962FF} %s %%{B-}%%{A} " "${workspace_index}"
    fi
  done
}

datetime()
{
  printf '%%{B#2962FF} '
  date '+%Y-%m-%d %H:%M'
  printf ' %%{B-}'
}

current_window()
{
  printf '%%{F#ECEFF1}%s%%{F-}' "$(xdotool getwindowfocus getwindowname)"
}

volume()
{
  printf '♪'
}

float2int()
{
  awk 'BEGIN{for (i=1; i<ARGC;i++)
    printf "%.0f\n", ARGV[i]}' "$@"
}

brightness()
{
  level="$(float2int $(xbacklight -get))"
  printf '☼%%{B#FFD600} %s%% %%{B-}' "${level}"
}

battery()
{
  level=$(("$(cat /sys/class/power_supply/BAT0/capacity)"))
  charging=$(("$(cat /sys/class/power_supply/ADP0/online)"))

  if [ $charging -eq 1 ]; then
    if [ $level -gt 15 ]; then
      printf '%%{B#00BFA5}%%{F#FFFF8D}'
    else
      printf '%%{B#C51162}%%{F#F4FF81}'
    fi
  else
    if [ $level -gt 75 ]; then
      printf '%%{B#00C853}'
    elif [ $level -gt 65 ]; then
      printf '%%{B#64DD17}'
    elif [ $level -gt 55 ]; then
      printf '%%{B#AEEA00}'
    elif [ $level -gt 45 ]; then
      printf '%%{B#FFD600}'
    elif [ $level -gt 35 ]; then
      printf '%%{B#FFAB00}'
    elif [ $level -gt 25 ]; then
      printf '%%{B#FF6D00}'
    elif [ $level -gt 15 ]; then
      printf '%%{B#DD2C00}'
    else
      printf '%%{B#D50000}'
    fi
  fi

  printf ' ☀%s%% %%{B-}%%{F-}' "${level}"
}

content()
{
  printf '%%{l} '
  workspaces
  printf '%%{c}'
  current_window
  printf '%%{r}'
  datetime
  printf ' '
  volume
  printf ' '
  brightness
  printf ' '
  battery
  printf ' '
}

statusbar()
{
  while true; do
    content | paste -sd ''
    sleep 0.2
  done
}

statusbar | lemonbar -d -p -n 'lemonbar-desktop' \
  -f '-*-hack-medium-r-*-*-16-*-*-*-*-*-*-*' -g 'x25' \
  -B '#263238' -F '#F5F5F5' &
