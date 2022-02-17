source /persist-arch/install.conf
yay -S --nocofirm --needed - < /persist-arch/_aur.txt
sudo systemctl enable ananicy
sudo systemctl enable irqbalance
sudo systemctl enable nohang-desktop
sudo systemctl enable preload
sudo systemctl enable set-cfs-tweaks
sudo systemctl enable zramd
sudo systemctl enable cups
sudo systemctl enable plasma
sudo systemctl enable bluetooth
sudo systemctl enable sddm
sudo sed -i 's/^# MAX_SIZE/MAX_SIZE/' /etc/default/zramd
sudo sed -i 's/^8192/${zramd}/' /etc/default/zramd
