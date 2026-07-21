#!/usr/bin/env bash
#
# Installation Paths
#

[[ -n "${ASLDVSCTL_INSTALL_PATHS_LOADED:-}" ]] && return
readonly ASLDVSCTL_INSTALL_PATHS_LOADED=1

###############################################################################
# AllStarLink
###############################################################################

ASTERISK_DIR="/etc/asterisk"

RPT_CONF="${ASTERISK_DIR}/rpt.conf"
IAX_CONF="${ASTERISK_DIR}/iax.conf"
EXTENSIONS_CONF="${ASTERISK_DIR}/extensions.conf"

###############################################################################
# DVSwitch
###############################################################################

DVSWITCH_DIR="/etc/dvswitch"

ANALOG_BRIDGE_INI="/opt/Analog_Bridge/Analog_Bridge.ini"

MMDVM_BRIDGE_INI="/opt/MMDVM_Bridge/MMDVM_Bridge.ini"

DVSWITCH_INI="/opt/MMDVM_Bridge/DVSwitch.ini"

###############################################################################
# Services
###############################################################################

ASTERISK_SERVICE="asterisk"

ANALOG_BRIDGE_SERVICE="analog_bridge"

MMDVM_BRIDGE_SERVICE="mmdvm_bridge"

MD380_SERVICE="md380-emu"
