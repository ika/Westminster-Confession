#!/bin/bash

MOUNTPOINT=/mnt/sda1
BACKUPDIR=/mnt/sda1/Backup_latest
SOURCEDIR=/home/ika/Projects/westminster_confession

# Function to mount the device if not already mounted
mount_device() {
    if ! mountpoint -q "$MOUNTPOINT"; then
        sudo mount /dev/sda1 "$MOUNTPOINT" || { echo "Failed to mount $MOUNTPOINT"; exit 1; }
    fi
}

# Function to perform the backup
perform_backup() {
    mkdir -p "$BACKUPDIR" && rsync -az --delete "$SOURCEDIR" "$BACKUPDIR/"
}

# Main script execution
mount_device
if mountpoint -q "$MOUNTPOINT"; then
    perform_backup
else
    echo "-----------------------------------"
    echo "not mounted"
    echo "-----------------------------------"
fi
