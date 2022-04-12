rm -rf /etc/modprobe.d/amdgpu.conf
rm -rf /etc/modprobe.d/radeon.conf
echo "options amdgpu si_support=1" >> /etc/modprobe.d/amdgpu.conf
echo "options amdgpu cik_support=1" >> /etc/modprobe.d/amdgpu.conf
echo "options radeon si_support=0" >> /etc/modprobe.d/radeon.conf
echo "options radeon cik_support=0" >> /etc/modprobe.d/radeon.conf
mkinitcpio -p linux