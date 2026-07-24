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

connector_load() {
    local name="$1"
    local file="${CONNECTOR_PATH}/${name}/connector.sh"

    [[ -f "$file" ]] || { return 1
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

    return "$rc"
}

connector_list() {
    find "${CONNECTOR_PATH}" \
        -mindepth 1 \
        -maxdepth 1 \
        -type d \
        ! -name common \
        -printf "%f\n" | sort
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

connector_run_validate()
{
    local name="$1"

    connector_exists "$name" || return 1

    connector_load "$name" || return 1

    declare -F connector_validate >/dev/null || return 1

    connector_validate
}


###############################################################################
# Installation
###############################################################################

connector_run_install()
{
    local name="$1"

    connector_exists "$name" || {
        log_error "Unknown connector '$name'"
        return 1
    }

    connector_load "$name" || return 1

    declare -F connector_install >/dev/null || {
        log_error "Connector '$name' does not support installation"
        return 1
    }

    connector_install
}
