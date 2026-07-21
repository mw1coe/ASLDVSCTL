#!/usr/bin/env bash
#
# ASLDVSCTL 2.0
# INI Helper Library
#

[[ -n "${ASLDVSCTL_INI_LOADED:-}" ]] && return
readonly ASLDVSCTL_INI_LOADED=1

###############################################################################
# Read a value
###############################################################################

ini_get() {

    local file="$1"
    local section="$2"
    local key="$3"

    [[ -f "$file" ]] || return 1

    awk -F= \
        -v section="$section" \
        -v key="$key" '

        $0=="[" section "]" {
            in_section=1
            next
        }

        /^\[/ {
            in_section=0
        }

        in_section {

            k=$1

            sub(/^[ \t]+/, "", k)
            sub(/[ \t]+$/, "", k)

            if(k==key) {

                value=$2

                sub(/^[ \t]+/, "", value)
                sub(/[ \t]+$/, "", value)

                print value
                exit
            }
        }

    ' "$file"
}

ini_update() {

    local file="$1"
    local section="$2"
    local key="$3"
    local value="$4"

    [[ -f "$file" ]] || return 1

    awk \
        -v section="$section" \
        -v key="$key" \
        -v value="$value" '

    BEGIN {
        in_section=0
        updated=0
    }

    /^\[/ {

        if(in_section && !updated) {
            print key "=" value
            updated=1
        }

        in_section=($0=="[" section "]")
    }

    {

    if(in_section) {

    split($0,a,"=")

    k=a[1]

    sub(/^[ \t]+/, "", k)
    sub(/[ \t]+$/, "", k)

    if(k==key) {
        print key "=" value
        updated=1
        next
}

        }

        print
    }

    END {

        if(in_section && !updated)
            print key "=" value
    }

    ' "$file" > "${file}.new"

    mv "${file}.new" "$file"
}

###############################################################################
# Write a value
###############################################################################

ini_set() {

    local file="$1"
    local section="$2"
    local key="$3"
    local value="$4"

    if ini_get "$file" "$section" "$key" >/dev/null; then
        ini_update "$file" "$section" "$key" "$value"
    else
        ini_add "$file" "$section" "$key" "$value"
    fi
}

ini_add() {

    log_debug "ini_add() not implemented"
}

###############################################################################
# Delete a key
###############################################################################

ini_delete() {

    local file="$1"
    local section="$2"
    local key="$3"

    log_debug "ini_delete: ${file} [${section}] ${key}"
}

###############################################################################
# Check if a section exists
###############################################################################

ini_section_exists() {

    local file="$1"
    local section="$2"

    log_debug "ini_section_exists: ${file} [${section}]"
}

###############################################################################
# Backup an INI file
###############################################################################

ini_backup() {

    local file="$1"

    log_debug "ini_backup: ${file}"
}
