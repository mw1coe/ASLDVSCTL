#!/usr/bin/env bash
#
# Generic ASLDVSCTL Connector
#

CONNECTOR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${CONNECTOR_DIR}/metadata.conf"

connector_name()        { echo "${NAME}"; }
connector_version()     { echo "${VERSION}"; }
connector_mode()        { echo "${MODE}"; }
connector_description() { echo "${DESCRIPTION}"; }
connector_status()      { echo "${STATUS}"; }

connector_validate()    { return 0; }
connector_generate()    { return 0; }
connector_connect()     { return 0; }
connector_disconnect()  { return 0; }
