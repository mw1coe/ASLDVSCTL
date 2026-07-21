#!/usr/bin/env bash
###############################################################################
# ASLDVSCTL
# Common Library
###############################################################################

# Prevent multiple sourcing
[[ -n "${_COMMON_SH:-}" ]] && return
readonly _COMMON_SH=1

###############################################################################
# Version
###############################################################################

readonly ASLDVSCTL_VERSION="2.0.0"

###############################################################################
# Installation Paths
###############################################################################

readonly PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ -d "${PROJECT_ROOT}/profiles" ]]; then
    readonly BASE_DIR="${PROJECT_ROOT}"
else
    readonly BASE_DIR="/opt/asldvsctl"
fi

readonly BIN_DIR="${BASE_DIR}/bin"
readonly LIB_DIR="${BASE_DIR}/lib"
readonly CONFIG_DIR="${BASE_DIR}/config"
readonly TEMPLATE_DIR="${BASE_DIR}/templates"
readonly PROFILE_DIR="${BASE_DIR}/profiles"
readonly SOUND_DIR="${BASE_DIR}/sounds"
readonly STATE_DIR="${BASE_DIR}/state"
readonly LOG_DIR="${BASE_DIR}/logs"
readonly BACKUP_DIR="${BASE_DIR}/backups"
readonly SCRIPT_DIR="${BASE_DIR}/scripts"

readonly COMMAND_DIR="${PROJECT_ROOT}/commands"

###############################################################################
# System Configuration
###############################################################################

readonly SYSTEM_CONFIG="/etc/asldvsctl.conf"
readonly SYSTEM_SECRETS="/etc/asldvsctl.secrets"

###############################################################################
# Required Services
###############################################################################

readonly REQUIRED_SERVICES=(
    asterisk
    analog_bridge
    mmdvm_bridge
    md380-emu
)

###############################################################################
# Exit Codes
###############################################################################

readonly EXIT_SUCCESS=0
readonly EXIT_FAILURE=1
