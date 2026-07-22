#!/usr/bin/env bash
#
# ASLDVSCTL
# State Library
#

[[ -n "${ASLDVSCTL_STATE_LOADED:-}" ]] && return
readonly ASLDVSCTL_STATE_LOADED=1

readonly STATE_FILE="${STATE_DIR}/current.state"

###############################################################################
# Load
###############################################################################

state_load() {

    [[ -f "$STATE_FILE" ]] || return 1

    # shellcheck source=/dev/null
    source "$STATE_FILE"
}

###############################################################################
# Save
###############################################################################

state_save() {

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

state_show() {

    [[ -f "$STATE_FILE" ]] || {
        echo "No active profile."
        return
    }

    cat "$STATE_FILE"
}
