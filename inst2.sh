#!/bin/bash
while true
do
	echo "$(lsblk)" 
	echo
	read -p "Where should the system be installed": sdx	
	if [ -n "`echo $(lsblk) | grep \"$sdx\"`" ]
		then
			break
		else 
			clear 
			echo "No device found"
			echo  

	fi
done

DISCSIZE=$(sudo fdisk -l /dev/$sdx | head -n 1 | sed 's/\s\s*/ /g' | cut -f5 -d" ")
RAM_SIZE=$(free -b | head -n 2 | tail -n 1 | sed 's/\s\s*/ /g' | cut -f2 -d" ")

BOOTSIZE=536870912
SWAPSIZE=$(( $(($RAM_SIZE/2)) + $RAM_SIZE))



echo $DISCSIZE
#echo $HOMESIZEch		
echo -n "Is this a good question (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
    sed -i -e 's/defauts/defaults,discard/g' /etc/fsab
fi