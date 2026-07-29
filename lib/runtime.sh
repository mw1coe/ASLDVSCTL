#!/usr/bin/env bash
#
###############################################################################
# Runtime Library
###############################################################################

runtime_show()
{
    state_load || true

    printf "Runtime\n"
    printf "%s\n" "-------"

    printf "Mode      : %s\n" "${MODE:-Unknown}"
    printf "Profile   : %s\n" "${PROFILE:-None}"
    printf "Connector : %s\n" "${CONNECTOR:-None}"
    printf "TG        : %s\n" "${TG:-None}"
    printf "Slot      : %s\n" "${SLOT:-None}"
}

runtime_reset()
{
    TG="$DEFAULT_TG"
    SLOT="$DEFAULT_SLOT"

    state_save

    printf "Runtime reset to defaults.\n"

    return 0
}

runtime_validate()
{
    state_load || true

    printf "Runtime Validation\n"
    printf "%s\n" "------------------"

    [[ -n "${PROFILE:-}" ]]   && printf "PASS  Profile\n"   || printf "FAIL  Profile\n"
    [[ -n "${CONNECTOR:-}" ]] && printf "PASS  Connector\n" || printf "FAIL  Connector\n"
    [[ -n "${MODE:-}" ]]      && printf "PASS  Mode\n"      || printf "FAIL  Mode\n"
    [[ -n "${TG:-}" ]]        && printf "PASS  Talkgroup\n" || printf "FAIL  Talkgroup\n"
    [[ -n "${SLOT:-}" ]]      && printf "PASS  Slot\n"      || printf "FAIL  Slot\n"
    [[ -f "$STATE_FILE" ]]    && printf "PASS  State File\n" || printf "FAIL  State File\n"

    return 0
}

runtime_save()
{
    state_save

    log_info "Runtime state saved."

    return 0
}

runtime_load()
{
    state_load || return 1

    runtime_show

    return 0
}

runtime_reset()
{
    PROFILE=""
    NAME=""
    MODE=""
    CONNECTOR=""

    TG="$DEFAULT_TG"
    SLOT="$DEFAULT_SLOT"

    state_save

    log_info "Runtime reset."

    return 0
}



