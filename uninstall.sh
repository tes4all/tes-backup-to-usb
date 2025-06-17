#!/bin/bash

set -e

INSTALL_DIR="/etc/usb-backup"
LOGROTATE_CONFIG="/etc/logrotate.d/usb-backup"
LOG_FILE="/var/log/usb_backup.log"

echo "Removing backup files..."
rm -rf "$INSTALL_DIR"

echo "Removing logrotate config..."
rm -f "$LOGROTATE_CONFIG"

echo "Removing log file..."
rm -f "$LOG_FILE"

echo "Uninstalled."
