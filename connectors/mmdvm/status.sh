#!/usr/bin/env bash
#
###############################################################################
# MMDVM Status
###############################################################################

connector_status()
{
    local running=0
    local total=0
    local svc

    echo
    echo "Connector : $(connector_name)"
    echo "Mode      : $(connector_mode)"
    echo "Version   : $(connector_version)"
    echo

    echo "Services"
    echo "--------"

    for svc in ${SERVICES}
    do
        total=$((total+1))

        if systemctl is-active --quiet "$svc"
        then
            printf "  %-18s active\n" "$svc"
            running=$((running+1))
        else
            printf "  %-18s inactive\n" "$svc"
        fi
    done

    echo
    echo "Running: ${running}/${total}"
}
