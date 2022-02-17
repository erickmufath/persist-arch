echo "======================================================"
echo "=] 1. BIOS/Legacy"
echo "=] 2. UEFI"
echo "=] 3. HYBRID [Direkomendasikan Untuk Media External]"
echo "======================================================="
read -p ">> Pilih Jenis Boot (1/2/3) : " boot
read -p "->] Input Nama Komputer Arch Linux (Contoh : pc atau acer) = " hstname
read -p "->] Input Jumlah ZRAM (Contoh 8192) terhitung satuan Mega Byte = " zramd
echo ""
echo "======================================================="
lsblk
echo "======================================================="
echo ""
read -p "->] Input Drive untuk install Bootloader (Contoh : sda, sdb, atau nvmen1) = " drive

sgdisk -n 1::+10M --typecode=1:ef02 --change-name=1:'BIOSBOOT' ${DISK} # partition 1 (BIOS Boot Partition)
sgdisk -n 2::+250M --typecode=2:ef00 --change-name=2:'EFIBOOT' ${DISK} # partition 2 (UEFI Boot Partition)
sgdisk -n 3::-0 --typecode=3:8300 --change-name=3:'ROOT' ${DISK} # partition 3 (Root), default start, remaining

mkfs.xfs /dev/${drive}3
mkfs.fat -F32 /dev/${drive}2
mount /dev/${drive}3 /mnt
mkdir -p /mnt/boot
mount /dev/${drive}2 /mnt/boot


#Add parallel downloading
#sed -i 's/^#Para/Para/' /etc/pacman.conf
sed -i 's/^#ParallelDownloads = 5/ParallelDownloads = 2/' /etc/pacman.conf
#Enable multilib
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
#basestrap
pacstrap /mnt --needed - < persist-arch/_base.txt
pacstrap /mnt --needed - < persist-arch/_base.txt
pacstrap /mnt --needed - < persist-arch/_base.txt
pacstrap /mnt --needed - < persist-arch/_base.txt
pacstrap /mnt --needed - < persist-arch/_base.txt
genfstab -U /mnt >> /mnt/etc/fstab
echo "tmpfs   /tmp         tmpfs   rw,nodev,nosuid,size=4G          0  0" >> /mnt/etc/fstab
echo "zramd=$zramd" >> persist-arch/install.conf
echo "boot=$boot" >> persist-arch/install.conf
echo "hstname=$hstname" >> persist-arch/install.conf
echo "drive=$drive" >> persist-arch/install.conf
cp -rf persist-arch /mnt
