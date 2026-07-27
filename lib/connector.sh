#!/usr/bin/env bash
#
###############################################################################
# ASLDVSCTL
# Connector Manager Library
###############################################################################

[[ -n "${ASLDVSCTL_CONNECTOR_LOADED:-}" ]] && return
readonly ASLDVSCTL_CONNECTOR_LOADED=1

CONNECTOR_PATH="${BASE_DIR}/connectors"

###############################################################################
# Discovery
###############################################################################

connector_exists() {
    [[ -f "${CONNECTOR_PATH}/$1/connector.sh" ]]
}

connector_load()
{
    local name="$1"
    local file="${CONNECTOR_PATH}/${name}/connector.sh"

    [[ -f "$file" ]] || {
        return 1
    }

    unset -f \
        connector_name \
        connector_version \
        connector_mode \
        connector_description \
        connector_status \
        connector_validate \
        connector_generate \
        connector_connect \
        connector_disconnect \
        2>/dev/null || true

    # shellcheck source=/dev/null
    source "$file"

    local rc=$?

    if [[ $rc -eq 0 ]]; then
        CONNECTOR="$name"

        if declare -F connector_mode >/dev/null; then
            MODE="$(connector_mode)"
        fi
    fi

    return "$rc"
}

connector_list()
{
    local dir
    local name

    printf "Available Connectors\n"
    printf "%s\n" "--------------------"

    for dir in "${CONNECTORS_DIR}"/*; do
        [[ -d "$dir" ]] || continue

        name="$(basename "$dir")"

        [[ "$name" == "common" ]] && continue

        printf "%s\n" "$name"
    done

    return 0
}

###############################################################################
# Information
###############################################################################

connector_info() {
    local name="$1"

    [[ -f "${CONNECTOR_PATH}/${name}/README.md" ]] && cat 
        "${CONNECTOR_PATH}/${name}/README.md"
}

###############################################################################
# Validation
###############################################################################

connector_validate()
{
    printf "Connector Validation\n"
    printf "%s\n" "--------------------"

    [[ -n "${CONNECTOR_NAME:-}" ]] || {
        log_error "Connector metadata not loaded."
        return 1
    }

    printf "PASS  Metadata\n"

    if declare -F connector_run_validate >/dev/null; then
        connector_run_validate
    else
        printf "WARN  No connector-specific validation\n"
    fi

    return 0
}

###############################################################################
# Summary
###############################################################################

connector_summary()
{
    echo "Connector"
    echo "---------"

    if [[ -z "${CONNECTOR:-}" ]]
    then
        echo "Current     : <none>"
        echo
        return 0
    fi

    printf "Current     : %s\n" "${CONNECTOR}"
    printf "Name        : %s\n" "${CONNECTOR_NAME:-<unknown>}"
    printf "Version     : %s\n" "${CONNECTOR_VERSION:-<unknown>}"
    printf "Mode        : %s\n" "${CONNECTOR_MODE:-<unknown>}"
    printf "Description : %s\n" "${CONNECTOR_DESCRIPTION:-<unknown>}"
    printf "Author      : %s\n" "${CONNECTOR_AUTHOR:-<unknown>}"
    printf "Status      : %s\n" "${CONNECTOR_STATUS:-<unknown>}"

    echo
}

connector_show()
{
    printf "Connector\n"
    printf "%s\n" "---------"

    printf "Name        : %s\n" "${CONNECTOR_NAME:-Unknown}"
    printf "Version     : %s\n" "${CONNECTOR_VERSION:-Unknown}"
    printf "Author      : %s\n" "${CONNECTOR_AUTHOR:-Unknown}"
    printf "Description : %s\n" "${CONNECTOR_DESCRIPTION:-None}"
    printf "Mode        : %s\n" "${CONNECTOR_MODE:-Unknown}"

    return 0
}

connector_current()
{
    state_load >/dev/null 2>&1 || true

    if [[ -z "${CONNECTOR:-}" ]]; then
        log_error "No active connector."
        return 1
    fi

    connector_load "${CONNECTOR}" || return 1

    connector_show
}

connector_install()
{
    [[ -n "${CONNECTOR_NAME:-}" ]] || {
        log_error "Connector metadata not loaded."
        return 1
    }

    if declare -F connector_run_install >/dev/null; then
        connector_run_install
    else
        log_error "Connector '${CONNECTOR_NAME}' does not support installation."
        return 1
    fi

    return 0
}

connector_uninstall()
{
    [[ -n "${CONNECTOR_NAME:-}" ]] || {
        log_error "Connector metadata not loaded."
        return 1
    }

    if declare -F connector_run_uninstall >/dev/null; then
        connector_run_uninstall
    else
        log_error "Connector '${CONNECTOR_NAME}' does not support uninstallation."
        return 1
    fi

    return 0
}
