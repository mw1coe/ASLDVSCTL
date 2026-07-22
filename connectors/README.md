# ASLDVSCTL Connectors

A connector provides the interface between ASLDVSCTL and a digital
voice technology.

The core never communicates directly with DVSwitch, M17, YSF,
or any other protocol implementation.

Each connector must implement the standard connector API.

Required functions:

- connector_init
- connector_generate
- connector_connect
- connector_disconnect
- connector_status
- connector_validate
