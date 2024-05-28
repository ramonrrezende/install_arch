#! /bin/bash

KEYBOARD="br-abnt2"
HOST_NAME="san"
USER_NAME="ison"

handle_error() {
    echo "Error: $1"
    cleanup
    exit 1
}

execute_command() {
    echo "Running command: $*"
    echo ""
    read -p "Do you want to execute this command? (y/n): " user_input
    echo $user_input
    if [ "$user_input" != "y" ]; then
        echo "Command skipped by user."
        return
    fi
    "$@"
    if [ $? -ne 0 ]; then
        handle_error "Command '$*' failed"
    fi
}

wait_user() {
    echo -e 'press any key to continue...\n'
    read -n 1 -s -r
}


# datetime
execute_command ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
# datetime bios
# hwclock --systohc
date
wait_user

# locale
execute_command nano /etc/locale.gen
execute_command locale-gen
execute_command echo KEYMAP=$KEYBOARD >> /etc/vconsole.conf

# hostname
execute_command hostnamectl set-hostname $HOST_NAME
execute_command passwd

# add user
execute_command useradd -m -g users -G wheel,storage,power -s /bin/bash $USER_NAME
execute_command passwd $USER_NAME

# packages
execute_command pacman -S dosfstools os-prober mtools network-manager-applet networkmanager wpa_supplicant wireless_tools dialog

# UEFI

execute_command pacman -S grub efibootmgr
execute_command grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
execute_command grub-mkconfig -o /boot/grub/grub.cfg

wait_user
