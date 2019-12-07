# Add Users
# useradd -m -G additional_groups -s login_shell username
useradd -m -s /bin/bash engine210
passwd engine210

# add sudo privilege
pacman -Sy vi
visudo /etc/sudoers
# remove # in /etc/sudoers for
    %wheel ALL=(ALL) ALL
usermod engine210 -G wheel

# install xfce desktop enviroment
pacman -Sy xfce4
pacman -Sy xfce4-goodies
pacman -Sy xorg

# enter desktop environment
exec startxfce4

# ssh
pacman -S openssh
# set ssh server
vim /etc/ssh/sshd_config
# add flowwing line
    AllowUsers engine210
systemctl enable --now sshd.service

# AUR
pacman -S --needed base-devel
# Download the require file
makepkg -si # -si will use pacman to check the dependency
pacman -U xxxxxx.pkg.tar.gz
# using yay
yay -S package_name
