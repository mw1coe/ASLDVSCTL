#!/usr/bin/env bash

#
# Common system check functions
#

check_program() {
    local prog="$1"

    printf "%-25s" "$prog"

    if command -v "$prog" >/dev/null 2>&1; then
        echo "[OK]"
    else
        echo "[NOT FOUND]"
    fi
}

check_service() {
    local svc="$1"

    printf "%-35s" "$svc"

    if systemctl list-unit-files --type=service --no-legend | awk '{print $1}' | grep -qx "${svc}.service"; then
        if systemctl is-active --quiet "$svc"; then
            echo "[RUNNING]"
        else
            echo "[STOPPED]"
        fi
    else
        echo "[NOT INSTALLED]"
    fi
}

check_file() {
    local file="$1"

    printf "%-55s" "$file"

    if [[ -f "$file" ]]; then
        echo "[OK]"
    else
        echo "[MISSING]"
    fi
}

check_directory() {
    local dir="$1"

    printf "%-25s" "$dir"

    if [[ -d "$dir" ]]; then
        echo "[OK]"
    else
        echo "[MISSING]"
    fi
}

check_binary() {
    local file="$1"

    printf "%-55s" "$file"

    if [[ -x "$file" ]]; then
        echo "[OK]"
    else
        echo "[MISSING]"
    fi
}
