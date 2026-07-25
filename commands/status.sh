#!/usr/bin/env bash

command_status()
{
    printf "ASLDVSCTL %s\n\n" "${ASLDVSCTL_VERSION}"

    printf "Project\n"
    printf '%s\n' "-------"
    printf "Root       : %s\n" "${PROJECT_ROOT}"
    printf "Version    : %s\n\n" "${ASLDVSCTL_VERSION}"

    station_summary
    echo

  #  state_summary
  #  echo

 #   connector_summary
 #   echo

    service_summary
    echo

    system_summary
}
