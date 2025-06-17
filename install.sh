#!/bin/bash

set -e

REPO_ZIP_URL="https://github.com/tes4all/tes-backup-to-usb/archive/refs/heads/main.zip"
TMP_DIR="/tmp/tes_backup_to_usb_install"
INSTALL_DIR="/etc/tes_backup_to_usb"
LOGROTATE_CONFIG="/etc/logrotate.d/tes_backup_to_usb"

echo "Downloading..."
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"
curl -L "$REPO_ZIP_URL" -o tes_backup_to_usb.zip

echo "Unpacking..."
unzip -o tes_backup_to_usb.zip
cd tes-backup-to-usb-*

echo "Installing to $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
cp backup.sh config "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/backup.sh"

echo "Installing logrotate config..."
cp tes_backup_to_usb.logrotate "$LOGROTATE_CONFIG"

echo "Done. You can now run:"
echo "$INSTALL_DIR/backup.sh"
