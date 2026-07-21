#!/usr/bin/env bash
#
# Backup Library
#

[[ -n "${ASLDVSCTL_INSTALL_BACKUP_LOADED:-}" ]] && return
readonly ASLDVSCTL_INSTALL_BACKUP_LOADED=1

BACKUP_DIR="${ROOT_DIR}/backups/install"

mkdir -p "$BACKUP_DIR"

###############################################################################
# Backup one file
###############################################################################

backup_file()
{
    local file="$1"

    [[ -f "$file" ]] || return 0

    cp -a \
        "$file" \
        "${BACKUP_DIR}/$(basename "$file")"

    printf "  [BACKUP] %s\n" "$file"
}
