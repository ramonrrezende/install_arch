#! /bin/bash

wait_user() {
    echo -e 'press any key to continue...\n'
    read -n 1 -s -r
}


DISK_DEVICE="/dev/sda"

# disk
fdisk -l

#bios boot 1G bios boot
#SWAP memory size linux swap
#/ 30G linux filesystem
#home linux filesystem


cfdisk $DISK_DEVICE



mkfs.fat -F32 "${DISK_DEVICE}1"

mkswap "${DISK_DEVICE}2"

mkfs.ext4 "${DISK_DEVICE}3"

mkfs.ext4 "${DISK_DEVICE}4"

#mount points
mount "${DISK_DEVICE}3" /mnt

#/home
mkdir /mnt/home

#/boot
mkdir /mnt/boot

#efi
mkdir /mnt/boot/efi

# mount home
mount "${DISK_DEVICE}4" /mnt/home

# mount boot
mount "${DISK_DEVICE}1" /mnt/boot

# efi
mount "${DISK_DEVICE}1" /mnt/boot/efi

swapon "${DISK_DEVICE}2"

lsblk

wait_user