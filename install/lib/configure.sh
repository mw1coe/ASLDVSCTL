#!/usr/bin/env bash
#
# Configuration Library
#

[[ -n "${ASLDVSCTL_INSTALL_CONFIGURE_LOADED:-}" ]] && return
readonly ASLDVSCTL_INSTALL_CONFIGURE_LOADED=1

###############################################################################
# Configuration Directories
###############################################################################

STAGING_DIR="${ROOT_DIR}/staging"

mkdir -p "${STAGING_DIR}"

###############################################################################
# Stage a file
###############################################################################

stage_file()
{
    local source="$1"
    local destination="$2"

    cp -f "$source" "${STAGING_DIR}/${destination}"
}

###############################################################################
# Install staged file
###############################################################################

install_staged_file()
{
    local staged="$1"
    local target="$2"

    mkdir -p "$(dirname "$target")"

    cp -f \
        "${STAGING_DIR}/${staged}" \
        "$target"
}
