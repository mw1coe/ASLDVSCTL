#!/usr/bin/env bash
#
###############################################################################
# ASLDVSCTL
# Doctor Library
###############################################################################

[[ -n "${ASLDVSCTL_DOCTOR_LOADED:-}" ]] && return
readonly ASLDVSCTL_DOCTOR_LOADED=1

DOCTOR_PASS=0
DOCTOR_WARN=0
DOCTOR_FAIL=0

###############################################################################
# Result Helpers
###############################################################################

doctor_pass()
{
    printf "PASS  %s\n" "$1"
    ((DOCTOR_PASS++))
}

doctor_warn()
{
    printf "WARN  %s\n" "$1"
    ((DOCTOR_WARN++))
}

doctor_fail()
{
    printf "FAIL  %s\n" "$1"
    ((DOCTOR_FAIL++))
}

###############################################################################
# Master
###############################################################################

doctor_run()
{
    DOCTOR_PASS=0
    DOCTOR_WARN=0
    DOCTOR_FAIL=0

    printf "ASLDVSCTL Doctor\n"
    printf "================\n\n"

    doctor_check_configuration
    doctor_check_station
    doctor_check_runtime
    doctor_check_profiles
    doctor_check_connectors
    doctor_check_services
    doctor_check_state
    doctor_check_transactions
    doctor_check_logs

    printf "\nSummary\n"
    printf "%s\n" "-------"
    printf "PASS  %d\n" "$DOCTOR_PASS"
    printf "WARN  %d\n" "$DOCTOR_WARN"
    printf "FAIL  %d\n" "$DOCTOR_FAIL"

    return 0
}

###############################################################################
# Configuration
###############################################################################

doctor_check_configuration()
{
    printf "Configuration\n"
    printf "%s\n" "-------------"

if [[ -f "$SYSTEM_CONFIG" ]]; then
    doctor_pass "Configuration file"
else
    doctor_fail "Configuration file"
fi

    printf "\n"
}

###############################################################################
# Station
###############################################################################

doctor_check_station()
{
    printf "Station\n"
    printf "%s\n" "-------"

    station_validate >/dev/null 2>&1

if [[ -n "${CALLSIGN:-}" ]]; then
    doctor_pass "Callsign"
else
    doctor_fail "Callsign"
fi

if [[ -n "${NODE:-}" ]]; then
    doctor_pass "Node"
else
    doctor_fail "Node"
fi

if [[ -n "${DMR_ID:-}" ]]; then
    doctor_pass "DMR ID"
else
    doctor_fail "DMR ID"
fi

    printf "\n"
}

###############################################################################
# Runtime
###############################################################################

doctor_check_runtime()
{
    printf "Runtime\n"
    printf "%s\n" "-------"

    state_load >/dev/null 2>&1 || true

if [[ -n "${PROFILE:-}" ]]; then
    doctor_pass "Profile"
else
    doctor_fail "Profile"
fi

if [[ -n "${CONNECTOR:-}" ]]; then
    doctor_pass "Connector"
else
    doctor_fail "Connector"
fi

if [[ -n "${MODE:-}" ]]; then
    doctor_pass "Mode"
else
    doctor_fail "Mode"
fi

if [[ -n "${TG:-}" ]]; then
    doctor_pass "Talkgroup"
else
    doctor_fail "Talkgroup"
fi

if [[ -n "${SLOT:-}" ]]; then
    doctor_pass "Slot"
else
    doctor_fail "Slot"
fi

    printf "\n"
}

###############################################################################
# Profiles
###############################################################################

doctor_check_profiles()
{
    printf "Profiles\n"
    printf "%s\n" "--------"

    [[ -n "${PROFILE:-}" ]] || {
        doctor_fail "No active profile"
        printf "\n"
        return
    }

    if profile_exists "$PROFILE"; then
        doctor_pass "Profile exists"
    else
        doctor_fail "Profile exists"
    fi

    printf "\n"
}

###############################################################################
# Connectors
###############################################################################

doctor_check_connectors()
{
    printf "Connectors\n"
    printf "%s\n" "----------"

    [[ -n "${CONNECTOR:-}" ]] || {
        doctor_fail "No active connector"
        printf "\n"
        return
    }

    if connector_exists "$CONNECTOR"; then
        doctor_pass "Connector exists"
    else
        doctor_fail "Connector exists"
    fi

    printf "\n"
}

###############################################################################
# Services
###############################################################################

doctor_check_services()
{
    printf "Services\n"
    printf "%s\n" "--------"

    connector_load "${CONNECTOR:-}" >/dev/null 2>&1 || true

    for svc in ${CONNECTOR_SERVICES:-}; do
        if systemctl is-active --quiet "$svc"; then
            doctor_pass "$svc"
        else
            doctor_fail "$svc"
        fi
    done

    printf "\n"
}

###############################################################################
# State
###############################################################################

doctor_check_state()
{
    printf "State\n"
    printf "%s\n" "-----"

    if [[ -f "$STATE_FILE" ]]; then
        doctor_pass "State file"
    else
        doctor_fail "State file"
    fi

    printf "\n"
}

###############################################################################
# Transactions
###############################################################################

doctor_check_transactions()
{
    printf "Transactions\n"
    printf "%s\n" "------------"

    if [[ -d "$BACKUP_DIR" ]]; then
        doctor_pass "Backup directory"
    else
        doctor_fail "Backup directory"
    fi

    printf "\n"
}

###############################################################################
# Logs
###############################################################################

doctor_check_logging()
{
    printf "Logging\n"
    printf "%s\n" "-------"

    if [[ -f "${BASE_DIR}/lib/logging.sh" ]]; then
        doctor_pass "Logging library"
    else
        doctor_fail "Logging library"
    fi

    printf "\n"
}
