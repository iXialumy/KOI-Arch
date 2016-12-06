#!/bin/bash
# Functions
yesquestion ()
{
	read -p "$1 (Y/n)? ": answer	
	if [ -z $answer ]; then
		return 0	
	elif echo "$answer" | grep -iq "^y" ;then
		return 0
	else 
		return 1
	fi
}

noquestion ()
{
	read -p "$1 (y/N)? ": answer	
	if [ -z $answer ]; then
		return 1	
	elif echo "$answer" | grep -iq "^n" ;then
		return 1
	else 
		return 0
	fi
}

# Creating discpartitioning
echo "How many MiB should the boot partition have?"
read boot
boot_size=$(($boot * 1024 * 1024))

echo "So the boot partition will have $boot MiB of space."

mem=$(free -b | head -n 2 | tail -n 1 | sed 's/\s\s*/ /g' | cut -f2 -d' ')
swap_size=$((($mem * 3) / 2))
swap_mib=$(($swap_size / 1048576))
swap_gib=$(($swap_mib / 1024))
disk_size=$(fdisk -l /dev/sda | head -n 1 | sed 's/\s\s*/ /g' | cut -f5 -d" ")
root_size=$((disk_size - ))
sdx="sda"
echo "Your swap partition will be $swap_size bytes big. That is $swap_mib MiB. Or $swap_gib GiB"

echo -e "x\nz\ny\ny\n" | gdisk /dev/$sdx 
echo -e "o\nY\nn\n\n\n+"$boot"M\nef00\nn\n\n\n+"$swap_mib"M\n8200\nn\n\n\n\n\nw\nY\n" | gdisk /dev/$sdx 

mkfs.fat -F32 "/dev/"$sdx"1"
yes| mkfs.ext4 "/dev/"$sdx"3"

#mount and create base system

#mkswap "/dev/"$sdx"2"
#swapon "/dev/"$sdx"2"

mount "/dev/"$sdx"3" /mnt
mkdir /mnt/boot
mount "/dev/"$sdx"1" /mnt/boot

# echo "Improving pacman mirrorlist. This my take a WHILE..."
# cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup \
# && sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup \
# && rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

pacstrap -i /mnt base base-devel
genfstab -U -p /mnt >> /mnt/etc/fstab

arch-chroot /mnt

ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

if yesquestion "Do you have an SSD"; then 
	sed -i -e 's/defauts/defaults,discard/g' /etc/fsab
fi
sed -i -e 's/#de_DE.UTF-8/de_DE.UTF-8/g' /etc/locale.gen

locale-gen
echo "de_DE.UTF-8" > /etc/locale.conf
echo "KEYMAP=de-latin1" > /etc/vconsole.conf

echo "Enter your hostname:"
read hname
echo $hname > /etc/hostname


sed -i -e 's/#\[multilib\]/\[multilib\]/g' /etc/pacman.conf
sed -i -e 's/#Include = \/etc\/pacman.d\/mirrorlist/Include = \/etc\/pacman.d\/mirrorlist/g' /etc/pacman.conf

echo "Please change the password for the root user now:"
passwd
bootctl install