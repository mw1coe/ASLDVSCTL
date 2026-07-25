#!/usr/bin/env bash
#
###############################################################################
# ASLDVSCTL
# Destination Library
###############################################################################

[[ -n "${ASLDVSCTL_DESTINATION_LOADED:-}" ]] && return
readonly ASLDVSCTL_DESTINATION_LOADED=1

DESTINATION_PATH="${BASE_DIR}/config/destinations"

destination_exists()
{
    local mode="$1"
    local name="$2"

    [[ -f "${DESTINATION_PATH}/${mode}/${name}.conf" ]]
}

destination_load()
{
    local mode="$1"
    local name="$2"

    if ! destination_exists "$mode" "$name"; then
        log_error "Destination '${name}' not found for mode '${mode}'"
        return 1
    fi

    # shellcheck disable=SC1090
    source "${DESTINATION_PATH}/${mode}/${name}.conf"
}

destination_list()
{
    local mode="$1"

    [[ -d "${DESTINATION_PATH}/${mode}" ]] || return 0

    find "${DESTINATION_PATH}/${mode}" -maxdepth 1 -name "*.conf" \
        -printf "%f\n" |
        sed 's/\.conf$//' |
        sort
}

destination_summary()
{
    echo
    echo "Destination"
    echo "-----------"

    printf "Name    : %s\n" "${DESTINATION:-<unset>}"
    printf "Address : %s\n" "${ADDRESS:-<unset>}"
    printf "Port    : %s\n" "${PORT:-<unset>}"
    printf "TG      : %s\n" "${TG:-<unset>}"
    printf "Slot    : %s\n" "${SLOT:-<unset>}"

    echo
}
