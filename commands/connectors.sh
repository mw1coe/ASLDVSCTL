#!/usr/bin/env bash
#
###############################################################################
# CONNECTORS
###############################################################################

command_connectors()
{
    local connector

    echo

    printf "%-12s %-8s %-10s %-12s\n" \
        "Connector" "Mode" "Version" "Status"

    printf "%-12s %-8s %-10s %-12s\n" \
        "---------" "----" "-------" "------"

    for connector in $(connector_list)
    do

        if ! connector_load "$connector"; then
            continue
        fi

        printf "%-12s %-8s %-10s %-12s\n" \
            "$(connector_name)" \
            "$(connector_mode)" \
            "$(connector_version)" \
            "$(connector_status)"
    done

    echo
}
