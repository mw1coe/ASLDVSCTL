command_doctor()
{
    echo "========================================"
    echo " ASLDVSCTL Doctor"
    echo "========================================"
    echo

    doctor_project
    doctor_station
    doctor_configuration
    doctor_connector
    doctor_services
    doctor_runtime

    echo
    echo "Doctor complete."
}
