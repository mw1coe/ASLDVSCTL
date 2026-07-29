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

    doctor_run

    return 0
}
