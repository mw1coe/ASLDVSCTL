#!/usr/bin/env bash
#
# ASLDVSCTL
# <Description>
#

command_status()
{
    printf "ASLDVSCTL %s\n\n" "${ASLDVSCTL_VERSION}"

    project_summary

    station_summary

    state_summary

    connector_summary

    service_summary

    system_summary
}
