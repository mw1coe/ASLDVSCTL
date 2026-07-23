#!/usr/bin/env bash
#
###############################################################################
# CONNECTOR
###############################################################################

command_connector()
{
    local connector="${1:-}"
    local action="${2:-status}"

    if [[ -z "$connector" ]]; then
        log_error "Usage: asldvsctl connector <name> [status|validate]"
        return 1
fi
#
# Load current runtime state
#
state_load 2>/dev/null || true

#
# Reload active profile if one exists
#
if [[ -n "${PROFILE:-}" ]]; then
    profile_load "$PROFILE" || true

    fi

    if ! connector_load "$connector"; then
        log_error "Connector '$connector' not found."
        return 1
    fi

    case "$action" in
        status)
            connector_status
            ;;

        validate)
            connector_validate
            ;;

        *)
            log_error "Unknown connector action: $action"
            return 1
            ;;
    esac
}
