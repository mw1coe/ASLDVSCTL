#!/usr/bin/env bash
#
###############################################################################
# Status Library
###############################################################################

[[ -n "${ASLDVSCTL_STATUS_LOADED:-}" ]] && return
readonly ASLDVSCTL_STATUS_LOADED=1

status_show()
{
    state_load >/dev/null 2>&1 || true

    echo
    echo "ASLDVSCTL Status"
    echo "================"

    status_station
    status_runtime
    status_connector
    status_services
}

status_station()
{
    echo
    echo "Station"
    echo "-------"

    printf "Callsign : %s\n" "${CALLSIGN:-Unknown}"
    printf "Node     : %s\n" "${NODE:-Unknown}"
    printf "DMR ID   : %s\n" "${DMR_ID:-Unknown}"
}

status_runtime()
{
    echo
    runtime_show
}

status_connector()
{
    echo

    if [[ -n "${CONNECTOR:-}" ]]; then
        connector_current
    else
        echo "Connector"
        echo "---------"
        echo "None"
    fi
}

status_services()
{
    echo

    if declare -F service_summary >/dev/null; then
        service_summary
    fi
}
