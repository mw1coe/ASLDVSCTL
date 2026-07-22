mmdvm_services_start()
{
    systemctl restart analog_bridge
    systemctl restart mmdvm_bridge
    systemctl restart md380-emu
}

mmdvm_services_stop()
{
    systemctl stop md380-emu
    systemctl stop mmdvm_bridge
    systemctl stop analog_bridge
}

mmdvm_services_status()
{
    systemctl is-active analog_bridge
    systemctl is-active mmdvm_bridge
    systemctl is-active md380-emu
}
