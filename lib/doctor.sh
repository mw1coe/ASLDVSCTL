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

    [[ -f "$CONFIG_FILE" ]] \
        && doctor_pass "Configuration file" \
        || doctor_fail "Configuration file"

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

    [[ -n "${CALLSIGN:-}" ]] && doctor_pass "Callsign" || doctor_fail "Callsign"
    [[ -n "${NODE:-}" ]]     && doctor_pass "Node"     || doctor_fail "Node"
    [[ -n "${DMR_ID:-}" ]]   && doctor_pass "DMR ID"   || doctor_fail "DMR ID"

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

    [[ -n "${PROFILE:-}" ]]   && doctor_pass "Profile"   || doctor_fail "Profile"
    [[ -n "${CONNECTOR:-}" ]] && doctor_pass "Connector" || doctor_fail "Connector"
    [[ -n "${MODE:-}" ]]      && doctor_pass "Mode"      || doctor_fail "Mode"
    [[ -n "${TG:-}" ]]        && doctor_pass "Talkgroup" || doctor_fail "Talkgroup"
    [[ -n "${SLOT:-}" ]]      && doctor_pass "Slot"      || doctor_fail "Slot"

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

    [[ -f "$STATE_FILE" ]] \
        && doctor_pass "State file" \
        || doctor_fail "State file"

    printf "\n"
}

###############################################################################
# Transactions
###############################################################################

doctor_check_transactions()
{
    printf "Transactions\n"
    printf "%s\n" "------------"

    [[ -d "$BACKUP_DIR" ]] \
        && doctor_pass "Backup directory" \
        || doctor_fail "Backup directory"

    printf "\n"
}

###############################################################################
# Logs
###############################################################################

doctor_check_logs()
{
    printf "Logs\n"
    printf "%s\n" "----"

    [[ -d "$LOG_DIR" ]] \
        && doctor_pass "Log directory" \
        || doctor_fail "Log directory"

    printf "\n"
}
