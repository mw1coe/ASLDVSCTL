#!/usr/bin/env bash
#
# ASLDVSCTL
# State Library
#

[[ -n "${ASLDVSCTL_STATE_LOADED:-}" ]] && return
readonly ASLDVSCTL_STATE_LOADED=1

readonly STATE_FILE="${STATE_DIR}/current.state"

echo "STATE_DIR=$STATE_DIR"
echo "STATE_FILE=$STATE_FILE"
echo "PWD=$(pwd)"
echo "Saving state..."

###############################################################################
# Load
###############################################################################

state_load()
{
    [[ -f "$STATE_FILE" ]] || {
        TG="$DEFAULT_TG"
        SLOT="$DEFAULT_SLOT"
        return 1
    }

    source "$STATE_FILE"

    TG="${TG:-$DEFAULT_TG}"
    SLOT="${SLOT:-$DEFAULT_SLOT}"

    export PROFILE NAME MODE CONNECTOR TG SLOT

    return 0
}

###############################################################################
# Save
###############################################################################

state_save()
{
    mkdir -p "$STATE_DIR"

    cat > "$STATE_FILE" <<EOF
PROFILE=${PROFILE:-}
NAME=${NAME:-}
MODE=${MODE:-}
CONNECTOR=${CONNECTOR:-}
TG=${TG:-}
SLOT=${SLOT:-}
EOF
}

###############################################################################
# Show
###############################################################################

state_show()
{
    [[ -f "$STATE_FILE" ]] || {
        echo "No active profile."
        return
    }

    cat "$STATE_FILE"
}

###############################################################################
# Summary
###############################################################################

state_summary()
{
    echo
    echo "Runtime"
    echo "-------"

    if ! state_load; then
        echo "No active profile."
        echo
        return
    fi

    printf "Profile   : %s\n" "${PROFILE:-<unset>}"
    printf "Name      : %s\n" "${NAME:-<unset>}"
    printf "Mode      : %s\n" "${MODE:-<unset>}"
    printf "Connector : %s\n" "${CONNECTOR:-<unset>}"
    printf "TG        : %s\n" "${TG:-<unset>}"
    printf "Slot      : %s\n" "${SLOT:-<unset>}"

    echo
}
