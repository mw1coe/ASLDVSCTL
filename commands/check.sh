#!/usr/bin/env bash

command_check() {

    echo "ASLDVSCTL ${ASLDVSCTL_VERSION}"
    echo
    echo "System Check"
    echo "============"
    echo

echo "Programs"
check_program asterisk

echo
echo "Services"
check_service asterisk

echo
echo "Configuration"
check_file /etc/asterisk/rpt.conf

echo

connector_run_validate "$CONNECTOR"
}

