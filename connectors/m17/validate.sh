#!/usr/bin/env bash
#
###############################################################################
# M17 Validation
###############################################################################

connector_validate()
{
    local rc=0

    echo
    echo "Validation"
    echo "----------"

    check_file "$USRP2M17_INI" || rc=1
    check_binary "$USRP2M17_BIN" || rc=1
    check_service "$USRP2M17_SERVICE" || rc=1

    return $rc
}
