#!/usr/bin/env bash
#
# ASLDVSCTL
# Doctor Command
#

command_doctor()
{
    [[ $# -eq 0 ]] || {
        echo "Usage: asldvsctl doctor"
        return 1
    }

    echo "ASLDVSCTL Doctor"
    echo "================"
    echo

    doctor_project
    doctor_station
    doctor_runtime
    doctor_services
    doctor_connector

    echo "Doctor completed."

    return 0
}

