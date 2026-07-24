#!/usr/bin/env bash
#
# 55-connectors.sh
# Install connector components
#

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

source "${ROOT_DIR}/lib/common.sh"
source "${ROOT_DIR}/lib/logging.sh"
source "${ROOT_DIR}/lib/connector.sh"

echo "Installing connectors..."
echo

connector_run_install m17

echo
echo "Connector installation complete."


