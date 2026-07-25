#!/usr/bin/env bash
#
# ASLDVSCTL
# <Description>
#

command_apply()
{
    [[ $# -eq 1 ]] || {
        echo "Usage: asldvsctl apply <profile>"
        return 1
    }

    local profile="$1"

    PROFILE="$profile"

    profile_load "$profile" || return 1
    profile_validate || return 1

    connector_load "$CONNECTOR" || return 1

    transaction_begin || return 1

    transaction_backup_connector || {
        transaction_abort
        return 1
    }

    bridge_configure_network || {
        transaction_abort
        return 1
    }

    bridge_configure_runtime || {
        transaction_abort
        return 1
    }

    state_save || {
        transaction_abort
        return 1
    }

    services_restart_network || {
        transaction_abort
        return 1
    }

    services_restart_runtime || {
        transaction_abort
        return 1
    }

    transaction_commit

    echo
    echo "Profile '$profile' applied successfully."
}
