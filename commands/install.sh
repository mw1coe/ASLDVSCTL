#!/usr/bin/env bash
#
###############################################################################
# Install Connector
###############################################################################

command_install()
{
    [[ $# -eq 1 ]] || {
        echo "Usage: asldvsctl install <connector>"
        return 1
    }

    connector_run_install "$1"
}


