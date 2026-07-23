#!/usr/bin/env bash

command_slot()
{
    [[ $# -eq 1 ]] || {
        echo "Usage: asldvsctl slot <1|2>"
        return 1
    }

    case "$1" in
        1|2) ;;
        *)
            echo "Slot must be 1 or 2"
            return 1
            ;;
    esac

    state_load || return 1

    saved_tg="${TG:-}"
    saved_slot="${SLOT:-}"

    profile_load "$PROFILE" || return 1

    TG="$saved_tg"
    SLOT="$saved_slot"

    SLOT="$1"

bridge_configure_runtime || return 1

services_restart_runtime || return 1

    state_save

    echo "Slot set to ${SLOT}"
}
