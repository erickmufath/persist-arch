source /persist-arch/install.conf
./persist-arch/yay.sh
case $display in
1)
sudo pacman -Sy -y --noconfirm --needed - < persist-arch/_pulseaudio.txt
;;
2)
yay -Sy -y --noconfirm --needed - < persist-arch/_pipewire.txt
;;
esac
yay -Sy -y --nocofirm --needed - < /persist-arch/_aur.txt
sudo systemctl enable ananicy
sudo systemctl enable irqbalance
sudo systemctl enable nohang-desktop
sudo systemctl enable set-cfs-tweaks
sudo systemctl enable zramd
sudo systemctl enable cups
sudo systemctl enable ntpd
sudo systemctl enable preload
sudo systemctl enable bluetooth
read -p "____________LANJUT?" confir
sudo systemctl enable sddm
