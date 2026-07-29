#!/usr/bin/env bash
#
###############################################################################
# ASLDVSCTL
# Diagnostic Dump
###############################################################################

dump_show()
{
    printf "ASLDVSCTL Diagnostic Dump\n"
    printf "%s\n" "========================="
    printf "\n"

    station_summary
    printf "\n"

    runtime_show
    printf "\n"

    profile_show "${PROFILE:-${RUNTIME_PROFILE:-B1}}" 2>/dev/null || true
    printf "\n"

    connector_current 2>/dev/null || true
    printf "\n"

    service_summary
    printf "\n"

    printf "\nDoctor\n"
    printf "%s\n" "------"

    doctor_run
}
