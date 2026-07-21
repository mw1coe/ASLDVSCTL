###############################################################################
# Detect package
###############################################################################

detect_package()
{
    local package="$1"

    if dpkg -s "$package" >/dev/null 2>&1
    then
        printf "  [OK]   %s\n" "$package"
    else
        printf "  [MISS] %s\n" "$package"
        return 1
    fi
}

###############################################################################
# Detect service
###############################################################################

detect_service()
{
    local service="$1"

    if systemctl is-active --quiet "$service"
    then
        printf "  [OK]   %s\n" "$service"
    else
        printf "  [FAIL] %s\n" "$service"
        return 1
    fi
}

