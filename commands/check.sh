#!/usr/bin/env bash

command_check() {

    echo "ASLDVSCTL ${ASLDVSCTL_VERSION}"
    echo
    echo "System Check"
    echo "============"
    echo

echo "Programs"
check_program asterisk
check_binary /opt/Analog_Bridge/Analog_Bridge
check_binary /opt/MMDVM_Bridge/MMDVM_Bridge
check_binary /opt/md380-emu/md380-emu

    echo
    echo "Services"
    check_service asterisk
    check_service analog_bridge
    check_service mmdvm_bridge
    check_service md380-emu

    echo
    echo "Configuration"
    check_file /etc/asterisk/rpt.conf
    check_file /opt/Analog_Bridge/Analog_Bridge.ini
    check_file /opt/MMDVM_Bridge/MMDVM_Bridge.ini
}
