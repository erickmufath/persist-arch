source /persist-arch/install.conf
pacman -Syyu
pacman-key --populate archlinux
echo "--------------------------------------------------------"
echo "           Setup Bahasa, lokal, Hostname & Hosts        "
echo "--------------------------------------------------------"
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
timedatectl --no-ask-password set-timezone Asia/Jakarta
timedatectl --no-ask-password set-ntp 1
localectl --no-ask-password set-locale LANG="en_US.UTF-8" LC_TIME="en_GB.UTF-8"

#set keymap
localectl --no-ask-password set-keymap us

# Set hostname & hosts
echo ${hstname} >> /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1	localhost" >> /etc/hosts
echo "127.0.1.1	${hstname}.localdomain	${hstname}" >> /etc/hosts

#Add parallel downloading
sed -i 's/^#ParallelDownloads = 5/ParallelDownloads = 2/' /etc/pacman.conf

#Enable multilib
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
pacman -Syyu

echo "--------------------------------------------------------"
echo "->] Input Root Password "
echo "--------------------------------------------------------"
passwd
echo "--------------------------------------------------------"
read -p "->] Input Username :" usrname
echo "--------------------------------------------------------"
echo "->] Input User Password "
echo "--------------------------------------------------------"
useradd -mG wheel ${usrname}
passwd ${usrname}

# Add sudo no password rights
sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers

# Add sudo rights
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

echo "usrname=$usrname" >> /persist-arch/install.conf
cp -rf /persist-arch /home/"${usrname}"

/usr/bin/runuser -u ${usrname} -- sudo pacman -Sy --noconfirm --needed - < persist-arch/_user.txt
/usr/bin/runuser -u ${usrname} -- sudo pacman -Sy --noconfirm --needed - < persist-arch/_user.txt
/usr/bin/runuser -u ${usrname} -- sudo pacman -Sy --noconfirm --needed - < persist-arch/_user.txt
/usr/bin/runuser -u ${usrname} -- sudo pacman -Sy --noconfirm --needed - < persist-arch/_user.txt

case $display in
1)
/usr/bin/runuser -u ${usrname} -- sudo pacman -Sy --noconfirm --needed - < persist-arch/_pulseaudio.txt
;;
2)
/usr/bin/runuser -u ${usrname} -- sudo pacman -Sy --noconfirm --needed - < persist-arch/_pipewire.txt
;;
esac

/usr/bin/runuser -u ${usrname} -- flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo 32 > /sys/block/${drive}/queue/iosched/fifo_batch
systemctl enable --now NetworkManager

# Add DNS cloudflare
sed -i 's/^nameserver 192.168.1.1/#nameserver 192.168.1.1/' /etc/resolv.conf
echo "nameserver 1.1.1.1" >> /etc/resolv.conf
echo "nameserver 1.0.0.1" >> /etc/resolv.conf

#grub install
case $boot in
1)
pacman -Sy grub os-prober --noconfirm
grub-install --target=i386-pc /dev/"${drive}"
grub-mkconfig -o /boot/grub/grub.cfg
;;
2)
pacman -Sy grub efibootmgr os-prober --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
;;
3)
pacman -Sy grub efibootmgr os-prober --noconfirm
grub-install --target=i386-pc --boot-directory=/boot /dev/"${drive}"
grub-install --target=x86_64-efi --efi-directory=/boot --boot-directory=/boot --removable --recheck
grub-mkconfig -o /boot/grub/grub.cfg
;;
esac
