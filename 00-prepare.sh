#!/usr/bin/env bash

# Partitioning
cryptsetup -v luksFormat $DEVICE
cryptsetup open $DEVICE root

export BTRFS_DEVICE="/dev/mapper/root"
mkfs.btrfs -f $BTRFS_DEVICE
mount $BTRFS_DEVICE /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@var
btrfs subvolume create /mnt/@opt
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@nix

umount /mnt

mount -o noatime,compress=zstd,subvol=@ $BTRFS_DEVICE /mnt
mkdir -p /mnt/{home,opt,nix,var,.snapshots}
mount -o noatime,compress=zstd,subvol=@home $BTRFS_DEVICE /mnt/home
mount -o noatime,compress=zstd,subvol=@var $BTRFS_DEVICE /mnt/var
mount -o noatime,compress=zstd,subvol=@nix $BTRFS_DEVICE /mnt/nix
mount -o noatime,compress=zstd,subvol=@opt $BTRFS_DEVICE /mnt/opt
mount -o noatime,compress=zstd,subvol=@snapshots $BTRFS_DEVICE /mnt/.snapshots

# Decided to not format boot partition because that could mess up a dual boot system.
# Maybe add a choice to the script? Maybe that would be too much complexity to handle here?
mount $BOOT_DEVICE /mnt/boot

# Bootstrap System inside the /mnt
pacstrap -K /mnt base base-devel linux linux-firmware linux-headers
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt ./01-after-pacstrap.sh
