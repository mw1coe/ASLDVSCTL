#!/usr/bin/env bash
#
# Station Library
#

[[ -n "${ASLDVSCTL_STATION_LOADED:-}" ]] && return
readonly ASLDVSCTL_STATION_LOADED=1

station_load()
{
    config_load
}

station_summary()
{
    echo
    echo "Station"
    echo "-------"

    printf "Callsign : %s\n" "${CALLSIGN:-<unset>}"
    printf "Node     : %s\n" "${NODE:-<unset>}"
    printf "DMR ID   : %s\n" "${DMR_ID:-<unset>}"
    printf "USRP     : %s\n" "${USRP_NODE:-<unset>}"

    echo
}
