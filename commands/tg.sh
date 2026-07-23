#!/usr/bin/env bash
#
###############################################################################
# TG Command
###############################################################################

command_tg()
{
    [[ $# -eq 1 ]] || {
        echo "Usage: asldvsctl tg <talkgroup>"
        return 1
    }

    state_load || return 1

    saved_tg="${TG:-}"
    saved_slot="${SLOT:-}"

    profile_load "$PROFILE" || return 1

    TG="$saved_tg"
    SLOT="$saved_slot"

    TG="$1"
    
bridge_configure_runtime || return 1
services_restart_runtime || return 1

    state_save

    echo "Talkgroup set to ${TG}"
}
