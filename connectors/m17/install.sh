#!/usr/bin/env bash
#
###############################################################################
# M17 Installer
###############################################################################

usrp2m17_install()
{
    usrp2m17_install_packages      || return 1
    usrp2m17_clone_source          || return 1
    usrp2m17_patch_source          || return 1
    usrp2m17_build		   || return 1
    usrp2m17_install_files         || return 1
    usrp2m17_install_service       || return 1
    usrp2m17_create_config         || return 1

    rm -rf "$USRP2M17_BUILD"
   
    log_info "USRP2M17 installation complete"
}

###############################################################################
# USRP2M17 Source
###############################################################################

USRP2M17_BUILD="/tmp/asldvsctl-build/usrp2m17"

usrp2m17_clone_source()
{
    log_info "Downloading USRP2M17"

    rm -rf "$USRP2M17_BUILD"

    mkdir -p "$(dirname "$USRP2M17_BUILD")" || return 1

    git clone "$CONNECTOR_REPO" "$USRP2M17_BUILD" || return 1

    cd "$USRP2M17_BUILD/USRP2M17" || return 1
}

usrp2m17_build()
{
    log_info "Building USRP2M17"

    cd "$USRP2M17_BUILD/USRP2M17" || return 1

    make clean >/dev/null 2>&1

    make || return 1
}

usrp2m17_install_files()
{
    log_info "Installing USRP2M17"

    install -d /opt/USRP2M17 || return 1

    install -m755 \
        "$USRP2M17_BUILD/USRP2M17/USRP2M17" \
        /opt/USRP2M17/ || return 1
}

usrp2m17_create_config()
{
    log_info "Creating default USRP2M17 configuration"

    install -d /opt/USRP2M17 || return 1
    install -d /var/log/usrp || return 1

    cat >/opt/USRP2M17/USRP2M17.ini <<EOF
[M17 Network]
Callsign=${CALLSIGN:-N0CALL}
Address=${ADDRESS:-127.0.0.1}
Name=${REFLECTOR:-M17-000} ${MODULE:-A}
LocalPort=${LOCAL_PORT:-32010}
DstPort=${PORT:-17000}
GainAdjustdB=3
Daemon=1
Debug=0

[USRP Network]
Address=127.0.0.1
DstPort=32008
LocalPort=34008
GainAdjustdB=3
Debug=0

[Log]
DisplayLevel=0
FileLevel=1
FilePath=/var/log/usrp
FileRoot=USRP2M17
EOF
}

usrp2m17_install_packages()
{
    log_info "Installing dependencies"

    apt-get update || return 1

    apt-get install -y \
        build-essential \
        git \
        ca-certificates \
        pkg-config \
        libtool || return 1
}

usrp2m17_install_service()
{
    log_info "Installing systemd service"

    install -m644 \
        "$CONNECTOR_DIR/usrp2m17.service" \
        /usr/lib/systemd/system/usrp2m17.service || return 1

    systemctl daemon-reload || return 1

    systemctl enable usrp2m17 || return 1
}

usrp2m17_patch_source()
{
    log_info "Patching source for modern compilers"

    cd "$USRP2M17_BUILD/USRP2M17" || return 1

    for file in *.h *.cpp; do
        [[ -f "$file" ]] || continue

        grep -Eq 'uint(8|16|32|64)_t|int(8|16|32|64)_t' "$file" || continue

        grep -q '#include <cstdint>' "$file" && continue

        log_info "Patching $file"

        sed -i '/^#include /i #include <cstdint>' "$file"
    done
}
