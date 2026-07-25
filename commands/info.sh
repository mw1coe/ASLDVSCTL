#!/usr/bin/env bash
#
# ASLDVSCTL
# Info Command
#

command_info()
{
    [[ $# -eq 0 ]] || {
        echo "Usage: asldvsctl info"
        return 1
    }

    state_load

    [[ -n "${CONNECTOR:-}" ]] && connector_load "$CONNECTOR"

    project_summary

    station_summary

    state_summary

    connector_summary

    return 0
}
