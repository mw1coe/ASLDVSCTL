#!/usr/bin/env bash
#
# ASLDVSCTL
# <Description>
#

command_backup()
{
    [[ $# -eq 0 ]] || {
        echo "Usage: asldvsctl backup"
        return 1
    }

state_load || return 1

[[ -n "${CONNECTOR:-}" ]] || {
    log_error "No active connector."
    return 1
}

connector_load "$CONNECTOR" || return 1

    transaction_begin || return 1

    transaction_backup_connector || {
        transaction_abort
        return 1
    }

    log_info "Backup complete"

    transaction_show
}
