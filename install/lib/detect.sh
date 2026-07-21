#!/usr/bin/env bash
#
# Detection Library
#

[[ -n "${ASLDVSCTL_INSTALL_DETECT_LOADED:-}" ]] && return
readonly ASLDVSCTL_INSTALL_DETECT_LOADED=1

###############################################################################
# Detect a required file
###############################################################################

detect_file()
{
    local file="$1"

    if [[ -f "$file" ]]
    then
        printf "  [OK]   %s\n" "$file"
        return 0
    fi

    printf "  [MISS] %s\n" "$file"
    return 1
}

###############################################################################
# Detect package
###############################################################################

detect_package()
{
    local package="$1"

    if dpkg -s "$package" >/dev/null 2>&1
    then
        printf "  [OK]   %s\n" "$package"
    else
        printf "  [MISS] %s\n" "$package"
        return 1
    fi
}

###############################################################################
# Detect service
###############################################################################

detect_service()
{
    local service="$1"

    if systemctl is-active --quiet "$service"
    then
        printf "  [OK]   %s\n" "$service"
    else
        printf "  [FAIL] %s\n" "$service"
        return 1
    fi
}
