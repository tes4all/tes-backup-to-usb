#!/bin/bash

set -e

INSTALL_DIR="/etc/tes_backup_to_usb"
LOGROTATE_CONFIG="/etc/logrotate.d/tes_backup_to_usb"
LOG_FILE="/var/log/tes_backup_to_usb.log"

echo "Removing backup files..."
rm -rf "$INSTALL_DIR"

echo "Removing logrotate config..."
rm -f "$LOGROTATE_CONFIG"

echo "Removing log file..."
rm -f "$LOG_FILE"

echo "Uninstalled."
