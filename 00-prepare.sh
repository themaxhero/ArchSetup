#!/usr/bin/env bash

# Partitioning
export DEVICE="/dev/sda"
mkfs.btrfs -f $DEVICE
mount /dev/sdX /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@etc
btrfs subvolume create /mnt/@var
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@nix

umount /mnt

mount -o noatime,compress=zstd,subvol=@ $DEVICE /mnt
mkdir -p /mnt/{home,etc,nix,var,.snapshots}
mount -o noatime,compress=zstd,subvol=@home $DEVICE /mnt/home
mount -o noatime,compress=zstd,subvol=@etc $DEVICE /mnt/etc
mount -o noatime,compress=zstd,subvol=@var $DEVICE /mnt/var
mount -o noatime,compress=zstd,subvol=@nix $DEVICE /mnt/nix
mount -o noatime,compress=zstd,subvol=@snapshots $DEVICE /mnt/.snapshots

# Bootstrap System inside the /mnt
pacstrap -K /mnt base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt ./01-after-pacstrap.sh
