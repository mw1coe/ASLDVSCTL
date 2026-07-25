#!/usr/bin/env bash
#
# ASLDVSCTL
# <Description>
#

doctor_project()
{
    echo "Project"
    echo "-------"

    [[ -d "$PROJECT_ROOT" ]] \
        && echo "PASS  Project directory" \
        || echo "FAIL  Project directory"

    [[ -d "$LIB_DIR" ]] \
        && echo "PASS  Library directory" \
        || echo "FAIL  Library directory"

    echo
}

###############################################################################
# Station
###############################################################################

doctor_station()
{
    echo "Station"
    echo "-------"

    [[ -n "${CALLSIGN:-}" ]] \
        && echo "PASS  Callsign configured" \
        || echo "WARN  Callsign not configured"

    [[ -n "${NODE:-}" ]] \
        && echo "PASS  Node configured" \
        || echo "WARN  Node not configured"

    [[ -n "${DMR_ID:-}" ]] \
        && echo "PASS  DMR ID configured" \
        || echo "WARN  DMR ID not configured"

    [[ -n "${USRP_NODE:-}" ]] \
        && echo "PASS  USRP node configured" \
        || echo "WARN  USRP node not configured"

    echo
}

###############################################################################
# Runtime
###############################################################################

doctor_runtime()
{
    echo "Runtime"
    echo "-------"

    if state_load
    then
        echo "PASS  State file"

        [[ -n "${PROFILE:-}" ]] \
            && echo "PASS  Active profile (${PROFILE})" \
            || echo "WARN  No active profile"

        [[ -n "${CONNECTOR:-}" ]] \
            && echo "PASS  Active connector (${CONNECTOR})" \
            || echo "WARN  No active connector"
    else
        echo "FAIL  State file missing"
    fi

    echo
}

###############################################################################
# Services
###############################################################################

doctor_services()
{
    local svc

    echo "Services"
    echo "--------"

    for svc in \
        asterisk \
        analog_bridge \
        mmdvm_bridge \
        md380-emu
    do
        if service_running "$svc"
        then
            printf "PASS  %s\n" "$svc"
        else
            printf "FAIL  %s\n" "$svc"
        fi
    done

    echo
}

###############################################################################
# Connector
###############################################################################

doctor_connector()
{
    echo "Connector"
    echo "---------"

    if [[ -z "${CONNECTOR:-}" ]]
    then
        echo "WARN  No connector selected"
        echo
        return 0
    fi

    if connector_load "$CONNECTOR"
    then
        echo "PASS  Connector loaded"

        connector_validate \
            && echo "PASS  Connector valid" \
            || echo "FAIL  Connector validation"
    else
        echo "FAIL  Unable to load connector"
    fi

    echo
}

###############################################################################
# Configuration
###############################################################################

doctor_configuration()
{
    echo "Configuration"
    echo "-------------"

    local file

    for file in \
        "$SYSTEM_CONFIG" \
        "$MMDVM_INI" \
        "$DVSWITCH_INI" \
        "$ANALOG_INI"
    do
        if [[ -f "$file" ]]
        then
            printf "PASS  %s\n" "$file"
        else
            printf "FAIL  %s\n" "$file"
        fi
    done

    echo
}

