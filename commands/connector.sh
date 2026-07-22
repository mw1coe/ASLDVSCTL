#!/usr/bin/env bash
#
###############################################################################
# CONNECTOR
###############################################################################

command_connector()
{
    local connector="${1:-}"

    if [[ -z "$connector" ]]; then
        log_error "Usage: asldvsctl connector <name>"
        return 1
    fi

    if ! connector_load "$connector"; then
        log_error "Connector '$connector' not found."
        return 1
    fi

    connector_status
}
