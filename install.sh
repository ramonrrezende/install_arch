#! /bin/bash

KEYBOARD="br-abnt2"
HOST_NAME="san"
USER_NAME="ison"


wait_user() {
    echo -e 'press any key to continue...\n'
    read -n 1 -s -r
}



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
