#!/usr/bin/env bash
#
# Configuration Transaction Library
#

[[ -n "${ASLDVSCTL_TRANSACTION_LOADED:-}" ]] && return
readonly ASLDVSCTL_TRANSACTION_LOADED=1

transaction_begin()
{
    echo
    echo "========================================"
    echo " Configuration Transaction"
    echo "========================================"
    echo
}

transaction_end()
{
    echo
    echo "Transaction complete."
    echo
}
