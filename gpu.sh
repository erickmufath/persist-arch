echo "======================================================"
echo "=] 1. Intel Integrted GPU"
echo "=] 2. AMD VGA/Integrated Radeon"
echo "=] 3. NVIDIA VGA"
echo "======================================================="
read -p ">> Pilih GPU/VGA anda : " gpu
case $gpu in
1)
sudo pacman -S --noconfirm --needed - < intel-driver.txt
sudo pacman -R --noconfirm - < amd-driver.txt
sudo rm -rf /etc/modprobe.d/amdgpu.conf
sudo rm -rf /etc/modprobe.d/radeon.conf
sudo pacman -R --noconfirm - < nvidia-driver.txt
;;
2)
yay -S --noconfirm --needed - < amd-driver.txt
./pamd.sh
sudo pacman -R --noconfirm - < intel-driver.txt
sudo pacman -R --noconfirm - < nvidia-driver.txt
;;
3)
sudo pacman -S --noconfirm --needed - < nvidia-driver.txt
sudo rm -rf /etc/modprobe.d/amdgpu.conf
sudo rm -rf /etc/modprobe.d/radeon.conf
yay -R --noconfirm - < amd-driver.txt
sudo pacman -R --noconfirm - < intel-driver.txt
;;
esac
