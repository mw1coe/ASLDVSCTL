#!/usr/bin/env bash

connector_services_start()
{
    local svc

    for svc in ${SERVICES}
    do
        systemctl start "$svc"
    done
}

connector_services_stop()
{
    local svc

    for svc in ${SERVICES}
    do
        systemctl stop "$svc"
    done
}

connector_services_restart()
{
    local svc

    for svc in ${SERVICES}
    do
        systemctl restart "$svc"
    done
}

connector_services_status()
{
    local svc

    for svc in ${SERVICES}
    do
        printf "%-18s %s\n" \
            "$svc" \
            "$(systemctl is-active "$svc")"
    done
}
