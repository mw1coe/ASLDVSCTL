#!/usr/bin/env bash
#
###############################################################################
# Runtime Functions
###############################################################################

mmdvm_runtime_summary()
{
    echo
    echo "Runtime"
    echo "-------"
    printf "  %-10s %s\n" "TG:"   "${TG:-}"
    printf "  %-10s %s\n" "Slot:" "${SLOT:-}"
}
