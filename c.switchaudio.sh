echo "======================================================"
echo "=] 1. Switch to Pipewire"
echo "=] 1. Switch to Pulseaudio"
echo "======================================================="
read -p ">> Pilih Jenis Boot (1/2) : " saud
case $saud in
1)
yay -R --needed --noconfirm - < persist-arch/_pulseaudio.txt
yay -R --noconfirm jack2
yay -Sy --needed - < persist-arch/_pipewire.txt
yay -Syyu --noconfirm
;;
2)
yay -R --needed --noconfirm - < persist-arch/_pipewire.txt
yay -S jack2
yay -Sy --needed - < persist-arch/_pulseaudio.txt
yay -Syyu --noconfirm
;;
esac
