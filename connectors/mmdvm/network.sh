#!/usr/bin/env bash
#
###############################################################################
# MMDVM Network Functions
###############################################################################

mmdvm_network_name()
{
    echo "${NAME:-<none>}"
}

mmdvm_network_address()
{
    echo "${ADDRESS:-<none>}"
}

mmdvm_network_port()
{
    echo "${PORT:-<none>}"
}

mmdvm_network_password()
{
    echo "${PASSWORD:-}"
}

mmdvm_network_summary()
{
    echo
    echo "Network"
    echo "-------"
    printf "  %-12s %s\n" "Name:"    "${NAME:-<none>}"
    printf "  %-12s %s\n" "Address:" "${ADDRESS:-<none>}"
    printf "  %-12s %s\n" "Port:"    "${PORT:-<none>}"
}
