#!/usr/bin/env sh

# Add some files in path when needed

str_contains() {
    local string="${1}"
	local substring="${2}"
	if test "${string#*$substring}" != "${string}"; then
		return 0
	else
		return 1
	fi
}

# Append if exists and not already in path
path_append() {
	[ -d "${1}" ] && (! str_contains "${PATH}" "${1}") && PATH="${1}:${PATH}"
}

# global
path_append "/bin"
path_append "/usr/bin"
path_append "/usr/local/bin"
# home
path_append "${HOME}/bin"
path_append "${HOME}/.local/bin"
path_append "${HOME}/.npm/bin"
path_append "${HOME}/.composer/vendor/bin"
