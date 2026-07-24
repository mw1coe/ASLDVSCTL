#!/usr/bin/env bash
#
###############################################################################
# USRP2M17 Package Installation
###############################################################################

usrp2m17_install_packages()
{
    log_info "Installing build dependencies"

    apt-get update || return 1

    apt-get install -y \
        build-essential \
        git \
        pkg-config \
        libtool
}
