#!/usr/bin/env bash
#
# Package Installation Library
#

[[ -n "${ASLDVSCTL_INSTALL_PACKAGES_LOADED:-}" ]] && return
readonly ASLDVSCTL_INSTALL_PACKAGES_LOADED=1

###############################################################################
# Install packages from a package list
###############################################################################

install_package_list()
{
    local package_file="$1"

    [[ -f "$package_file" ]] || {
        echo "ERROR: Missing package file:"
        echo "       $package_file"
        return 1
    }

    local missing=()

    while IFS= read -r package
    do

        [[ -z "$package" ]] && continue
        [[ "$package" =~ ^# ]] && continue

        if dpkg -s "$package" >/dev/null 2>&1
        then
            printf "  [OK]   %-24s\n" "$package"
        else
            printf "  [MISS] %-24s\n" "$package"
            missing+=("$package")
        fi

    done < "$package_file"

    echo

    if (( ${#missing[@]} == 0 ))
    then
        echo "Nothing to install."
        echo
        return 0
    fi

    echo "Installing..."

    apt install -y "${missing[@]}"

    echo
}
