connector_validate()
{
    [[ -f /opt/MMDVM_Bridge/MMDVM_Bridge.ini ]] || return 1

    [[ -f /opt/MMDVM_Bridge/DVSwitch.ini ]] || return 1

    [[ -f /opt/Analog_Bridge/Analog_Bridge.ini ]] || return 1

    return 0
}
