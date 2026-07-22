#!/bin/bash

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

    source "${DESTINATION_PATH}/${mode}/${name}.conf"
}
