#!/bin/bash

LOG_FILE="/var/log/tes_backup_to_usb.log"
KNOWN_FILE="/etc/tes_backup_to_usb/known_serials"

echo "=== Backup START $(date) ===" >> "$LOG_FILE"

CONFIG="/etc/tes_backup_to_usb/config"
if [ ! -f "$CONFIG" ]; then
  echo "Missing config file: $CONFIG" >> "$LOG_FILE"
  exit 1
fi

source "$CONFIG"

mkdir -p "$(dirname "$KNOWN_FILE")"
touch "$KNOWN_FILE"
mkdir -p "$MOUNT_POINT"


SERIAL=$(udevadm info --query=all --name=$DEVICE | grep ID_SERIAL= | cut -d= -f2)

if [ -z "$SERIAL" ]; then
  echo "$(date): Could not get serial for $DEVICE" >> "$LOG_FILE"
  exit 1
fi

if grep -q "$SERIAL" "$KNOWN_FILE"; then
  echo "$(date): Device $SERIAL known." >> "$LOG_FILE"
else
  echo "$(date): Device $SERIAL new, wiping and formatting..." >> "$LOG_FILE"

  for part in $(lsblk -ln -o NAME $DEVICE | grep -v "^$(basename $DEVICE)$"); do
    umount "/dev/$part" 2>/dev/null
  done

  parted "$DEVICE" --script mklabel gpt
  parted "$DEVICE" --script mkpart primary ext4 0% 100%
  sleep 1  # let the partition table settle
  mkfs.ext4 -F "$PART"

  echo "$SERIAL" >> "$KNOWN_FILE"
fi

mount "$PART" "$MOUNT_POINT" || {
  echo "$(date): Failed to mount $PART" >> "$LOG_FILE"
  exit 1
}

rsync -avh --delete "$SOURCE_DIR/" "$MOUNT_POINT/" >> "$LOG_FILE" 2>&1

umount "$MOUNT_POINT"

echo "=== Backup END $(date) ===" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"
