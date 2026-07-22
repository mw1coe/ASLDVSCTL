#!/usr/bin/env bash
#
###############################################################################
# MMDVM Validation
###############################################################################

connector_validate()
{
    local rc=0

    echo
    echo "Validation"
    echo "----------"

    check_file()
    {
        if [[ -f "$1" ]]; then
            printf "  [ OK ] %s\n" "$1"
        else
            printf "  [FAIL] %s\n" "$1"
            rc=1
        fi
    }

    check_binary()
    {
        if [[ -x "$1" ]]; then
            printf "  [ OK ] %s\n" "$1"
        else
            printf "  [FAIL] %s\n" "$1"
            rc=1
        fi
    }

check_service()
{
    if systemctl cat "${1}.service" >/dev/null 2>&1; then
        printf "  [ OK ] %s.service\n" "$1"
    else
        printf "  [FAIL] %s.service\n" "$1"
        rc=1
    fi
}

    #
    # Configuration
    #

    check_file "${MMDVM_DIR}/MMDVM_Bridge.ini"
    check_file "${MMDVM_DIR}/DVSwitch.ini"
    check_file "${ANALOG_DIR}/Analog_Bridge.ini"

    #
    # Programs
    #

    check_binary "${MMDVM_DIR}/MMDVM_Bridge"
    check_binary "${ANALOG_DIR}/Analog_Bridge"

    #
    # Services
    #

    for svc in ${SERVICES}
    do
        check_service "$svc"
    done

    return $rc
}
