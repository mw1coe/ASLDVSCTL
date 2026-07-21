#!/usr/bin/env bash
#
# ASLDVSCTL 2.0
# System Paths
#

[[ -n "${ASLDVSCTL_PATHS_LOADED:-}" ]] && return
readonly ASLDVSCTL_PATHS_LOADED=1

###############################################################################
# DVSwitch Components
###############################################################################

readonly MMDVM_DIR="/opt/MMDVM_Bridge"
readonly ANALOG_DIR="/opt/Analog_Bridge"

###############################################################################
# Configuration Files
###############################################################################

readonly MMDVM_INI="${MMDVM_DIR}/MMDVM_Bridge.ini"
readonly DVSWITCH_INI="${MMDVM_DIR}/DVSwitch.ini"
readonly ANALOG_INI="${ANALOG_DIR}/Analog_Bridge.ini"

###############################################################################
# Services
###############################################################################

readonly SERVICE_MMDVM="mmdvm_bridge"
readonly SERVICE_ANALOG="analog_bridge"
readonly SERVICE_MD380="md380-emu"

###############################################################################
# Logs
###############################################################################

readonly MMDVM_LOG="/var/log/mmdvm_bridge.log"
readonly ANALOG_LOG="/var/log/analog_bridge.log"
