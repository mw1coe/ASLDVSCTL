#!/usr/bin/env bash
#
###############################################################################
# M17 Connector
###############################################################################

CONNECTOR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${CONNECTOR_DIR}/metadata.conf"

source "${CONNECTOR_DIR}/network.sh"
source "${CONNECTOR_DIR}/runtime.sh"
source "${CONNECTOR_DIR}/services.sh"
source "${CONNECTOR_DIR}/status.sh"
source "${CONNECTOR_DIR}/generate.sh"
source "${CONNECTOR_DIR}/install.sh"
source "${CONNECTOR_DIR}/validate.sh"

connector_name()
{
    echo "${CONNECTOR_NAME}"
}

connector_version()
{
    echo "${CONNECTOR_VERSION}"
}

connector_mode()
{
    echo "${CONNECTOR_MODE}"
}

connector_description()
{
    echo "${CONNECTOR_DESCRIPTION}"
}

connector_connect()
{
    return 0
}

connector_disconnect()
{
    return 0
}

connector_install()
{
    usrp2m17_install
}
