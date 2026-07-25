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

    state_load || true

    [[ -n "${CONNECTOR:-}" ]] && connector_load "$CONNECTOR"

    services_restart_network || return 1
    services_restart_runtime || return 1

    log_info "Restore complete"

    return 0
}
