#! /bin/bash

WIFI_SSID="Spock"
WIFI_PASSWD="06051994"
WIFI_DEVICE="wlan0"
KEYBOARD="br-abnt2"
DISK_DEVICE="/dev/sda"
HOST_NAME="san"
USER_NAME="ison"


wait_user() {
    echo -e 'press any key to continue...\n'
    read -n 1 -s -r
}

# keyboard config
loadkeys $KEYBOARD

# network
iwtcl --passphrase $WIFI_PASSWD station $WIFI_DEVICE connect $WIFI_SSID

# disk
fdisk -l

#bios boot 1G bios boot
#SWAP memory size linux swap
#/ 30G linux filesystem
#home linux filesystem


cfdisk $DISK_DEVICE



mkfs.fat -F32 "$DISK_DEVICE/1"

mkswap "$DISK_DEVICE/2"

mkfs.ext4 "$DISK_DEVICE/3"

mkfs.ext4 "$DISK_DEVICE/4"

#mount points
mount "$DISK_DEVICE/3" /mnt

#/home
mkdir /mnt/home

#/boot
mkdir /mnt/boot

#efi
mkdir /mnt/boot/efi

# mount home
mount "$DISK_DEVICE/4" /mnt/home

# mount boot
mount "$DISK_DEVICE/1" /mnt/boot

# efi
mount "$DISK_DEVICE/1" /mnt/boot/efi

swapon "$DISK_DEVICE/2"

lsblk

wait_user

# mirrors
nano /etc/pacman.d/mirrorlist

# archo packages
pacstrap /mnt base base-devel linux linux-firmware nano vim dhcpcd

# fstab
genfstab -U -p /mnt >> /mnt/etc/fstab

cat /mnt/etc/fstab
wait_user

# system

arch-chroot /mnt

# datetime
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
# datetime bios
# hwclock --systohc
date
wait_user

# locale
nano /etc/locale.gen
locale-gen
echo KEYMAP=$KEYBOARD >> /etc/vconsole.conf

# hostname
hostnamectl set-hostname nomedoseuhost $HOST_NAME
passwd

# add user
useradd -m -g users -G wheel,storage,power -s /bin/bash $USER_NAME
passwd $USER_NAME

# packages
pacman -S dosfstools os-prober mtools network-manager-applet networkmanager wpa_supplicant wireless_tools dialog

# UEFI

pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
grub-mkconfig -o /boot/grub/grub.cfg

wait_user
