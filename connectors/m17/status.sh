#!/usr/bin/env bash
#
###############################################################################
# M17 Status
###############################################################################

connector_status()
{
    echo "Connector : M17"

    echo "Service   : $(systemctl is-active usrp2m17 2>/dev/null)"
}
