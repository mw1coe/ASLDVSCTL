#!/usr/bin/env bash
#
# ASLDVSCTL
# Restore Command
#

command_restore()
{
    [[ $# -eq 0 ]] || {
        echo "Usage: asldvsctl restore"
        return 1
    }

    transaction_rollback || return 1

    log_info "Restore complete"

    return 0
}
