#!/bin/bash
#
# Common connector helper functions
#

connector_error()
{
    echo "[ERROR] $*"
    return 1
}

connector_info()
{
    echo "[INFO ] $*"
}

connector_ok()
{
    echo "[ OK  ] $*"
}
