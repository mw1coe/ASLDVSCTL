#!/usr/bin/env bash
#
# 40-update.sh
# Refresh Package Database
#

set -e

echo "Updating package database..."
echo

apt update --allow-releaseinfo-change

echo
echo "Package database updated."
echo
