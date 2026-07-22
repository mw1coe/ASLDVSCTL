#!/bin/bash
#
# ASLDVSCTL Connector Manager
#

CONNECTOR_PATH="${BASE_DIR}/connectors"

###############################################################################
# Discovery
###############################################################################

connector_exists()
{
    [[ -f "${CONNECTOR_PATH}/$1/connector.sh" ]]
}

#connector_load()
#{
#    local name="$1"
#    local file="${CONNECTOR_PATH}/${name}/connector.sh"
#
#    [[ -f "$file" ]] || return 1
#
#    # Remove any previously loaded connector functions
#    unset -f \
#        connector_name \
#        connector_version \
#        connector_mode \
#        connector_description \
#        connector_status \
#        connector_validate \
#        connector_generate \
#        connector_connect \
#        connector_disconnect \
#        2>/dev/null || true
#
#    # shellcheck source=/dev/null
#    source "$file"
#}

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

    return "$rc"
}

connector_list()
{
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

connector_info()
{
    local name="$1"

    [[ -f "${CONNECTOR_PATH}/${name}/README.md" ]] &&
        cat "${CONNECTOR_PATH}/${name}/README.md"
}

###############################################################################
# Validation
###############################################################################

connector_validate()
{
    local name="$1"

    connector_exists "$name" || return 1

    connector_load "$name" || return 1

    declare -F connector_init >/dev/null
}
