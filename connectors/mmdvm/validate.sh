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

_mmdvm_check_file()
    {
        if [[ -f "$1" ]]; then
            printf "  [ OK ] %s\n" "$1"
        else
            printf "  [FAIL] %s\n" "$1"
            rc=1
        fi
    }

_mmdvm_check_binary()
    {
        if [[ -x "$1" ]]; then
            printf "  [ OK ] %s\n" "$1"
        else
            printf "  [FAIL] %s\n" "$1"
            rc=1
        fi
    }

_mmdvm_check_service()
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

    _mmdvm_check_file "$MMDVM_INI"
    _mmdvm_check_file "$DVSWITCH_INI"
    _mmdvm_check_file "$ANALOG_INI"

    #
    # Programs
    #

    _mmdvm_check_binary "${MMDVM_DIR}/MMDVM_Bridge"
    _mmdvm_check_binary "${ANALOG_DIR}/Analog_Bridge"

    #
    # Services
    #

    for svc in ${CONNECTOR_SERVICES}
    do
        _mmdvm_check_service "$svc"
    done

    return $rc
}
