#!/bin/bash

set -e

REPO_ZIP_URL="https://github.com/tes4all/tes-backup-to-usb/archive/refs/heads/main.zip"
TMP_DIR="/tmp/usb-backup-install"
INSTALL_DIR="/etc/usb-backup"
LOGROTATE_CONFIG="/etc/logrotate.d/usb-backup"

echo "Downloading..."
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"
curl -L "$REPO_ZIP_URL" -o usb-backup.zip

echo "Unpacking..."
unzip -o usb-backup.zip
cd usb-backup-*

echo "Installing to $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
cp backup.sh config "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/backup.sh"

echo "Installing logrotate config..."
cp usb-backup.logrotate "$LOGROTATE_CONFIG"

echo "Done. You can now run:"
echo "$INSTALL_DIR/backup.sh"
