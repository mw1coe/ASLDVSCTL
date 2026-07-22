connector_status()
{
    echo
    echo "Connector : $(connector_name)"
    echo "Version   : $(connector_version)"
    echo

    connector_services_status
}
