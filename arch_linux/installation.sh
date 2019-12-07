#!/bin/bash

# Verify the boot mode
ls /sys/firmware/efi/efivars

###########################################################################

# internet config
# check network interface
ip link
# DHCP
## dhcpcd
systemctl start dhcpcd.service
dhcpcd interface
## systemd-networkd
/etc/systemd/network/20-wired.network
    [Match]
    Name=eno1

    [Network]
    DHCP=ipv4
systemctl start systemd-networkd
## ip
ip a a 192.168.0.2/24 dev eno1
ip r replace default via 192.168.0.1
echo nameserver 8.8.8.8 >> /etc/resolv.conf

# Update the system clock
timedatectl set-ntp true
timedatectl list-timezones
timedatectl set-timezone Asia/Taipei

# Partition the disks
# check the memory size
free -h
# identify block devices 
fdisk -l
# Create a partition table and partitions
fdisk /dev/sda
o # BIOS with MBR
n # create a new partition tabl
p # primary partition
2
[enter] # default first sector
+16G # partition size for swap
n # create a new partition tabl
p # primary partition
1
[enter] # default first sector
[enter] # default partition size
w # write to the disk

mkfs.ext4 /dev/sda1
mkswap /dev/sdX2
swapon /dev/sdX2
mount /dev/sdX1 /mnt

# Select the mirrors
# move nctu to the top of file
# yy for copy line in vim, and p for paste
vim /etc/pacman.d/mirrorlist
# Fstab
pacstrap /mnt base linux linux-firmware
#Chroot
arch-chroot /mnt
# Time zone
ln -sf /usr/share/zoneinfo/Asia/Raipei /etc/localtime

# Localization
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Network configuration
echo "myhostname" >> myhostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	myhostname.localdomain	myhostname" >> /etc/hosts

# Initramfs
mkinitcpio -P

# Boot loader
pacman -S grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# install some tools
pacman -Sy net-tools
pacman -Sy vim
pacman -Sy sudo

# Reboot
# Exit the chroot environment
exit
umount -R /mnt
reboot
