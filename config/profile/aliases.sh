# general and command aliases
alias l='ls -Fhl --group-directories-first --color=always --hide="*~"'
alias ll='ls -AFhl --group-directories-first --color=always --hide="*~"'
alias search='grep -RnF --exclude "*~" --color=always'
alias c='clear && l'
alias monochrome='sed "s,\x1B\[[0-9;]*[a-zA-Z],,g"' # pipe anything here
alias ports='ss -atn'
alias clean_editors_tmp_files='find . -type f -name "*~" -exec rm -f {} \;'
alias quickpod='podman run --rm -it -v "$(pwd):/mnt:z" -w /mnt'

# Encrypting
alias cipher='openssl rsautl -encrypt -pubin -inkey'
alias decipher='openssl rsautl -decrypt -inkey'

# utilities
alias util_ssh_force='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias util_docker_images_rm_anonymous='docker rmi $(docker images | grep "^<none>" | tr -s " " | cut -d " " -f 3)'
alias util_syncthing_list_conflicts="find ./ -type f -name '*.sync-conflict*'"
alias util_vim_clean_swap='find ./ -type f -name "\.*sw[klmnop]" -delete'
alias util_steam_clean='find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" -o -name "libgpg-error.so*" \) -print -delete'


# shrink a PDF
pdfshrink() {
  gs -sDEVICE=pdfwrite -dCompatibilityLEvel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH -dQUIET -sOutputFile="${2}" "${1}"
}
# shrink even more a PDF
pdfXshrink() {
  gs -sDEVICE=pdfwrite -dCompatibilityLEvel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dBATCH -dQUIET -sOutputFile="${2}" "${1}"
}

# find something and edit
quickedit() {
  quickedit_place_to_search="${2:-./}"
  quickedit_result="$(grep -m 1 --exclude "*~" --exclude-dir .git/ -rnF "${1}" "${quickedit_place_to_search}" | head -n 1 | cut -d: -f1,2)"

  test -z "${quickedit_result}" && echo "No match found for « ${1} »" && return 1

  quickedit_file="$(echo $quickedit_result | cut -d: -f1)"
  quickedit_line="$(echo $quickedit_result | cut -d: -f2)"

  ${EDITOR} "${quickedit_file}" "+${quickedit_line}"
}

# Python virtualenv facility
venv() {
  test "${VIRTUAL_ENV}" = "" && test "${1}" = "" && exit 0

  if [ "${VIRTUAL_ENV}" = "" ]; then
    VENV_SOURCE_PATH="$(pwd)/${1}/bin/activate"

    if [ ! -f "${VENV_SOURCE_PATH}" ]; then
      echo "${1} virtual env does not exist, create it? [y/n]"
      read -r VENV_CREATE

      test "${VENV_CREATE}" != "y" && exit 0
      python3 -m venv "${1}"
    fi

    . "${VENV_SOURCE_PATH}"
    rehash
  elif [ "${1}" == "update" ]; then
    pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
  else
    deactivate || unset VIRTUAL_ENV
    rehash
  fi
}

