source /persist-arch/install.conf
#/usr/bin/runuser -u ${usrname} -- 
sudo pacman -Sy --needed - < persist-arch/_user.txt
sudo pacman -Sy --needed - < persist-arch/_user.txt
sudo pacman -Sy --needed - < persist-arch/_user.txt
sudo pacman -Sy --needed - < persist-arch/_user.txt
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
./persist-arch/yay.sh
case $display in
1)
sudo pacman -Sy --needed - < persist-arch/_pulseaudio.txt
;;
2)
yay -Sy --needed - < persist-arch/_pipewire.txt
;;
esac
yay -S --needed - < persist-arch/_aur.txt
sudo systemctl enable ananicy
sudo systemctl enable irqbalance
sudo systemctl enable nohang-desktop
sudo systemctl enable set-cfs-tweaks
sudo systemctl enable zramd
sudo systemctl enable auto-cpufreq
sudo systemctl enable cups
sudo systemctl enable ntpd
sudo systemctl enable snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo systemctl enable preload
sudo systemctl enable bluetooth
read -p "____________LANJUT?" confir
sudo systemctl enable sddm
