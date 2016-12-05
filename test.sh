#!/bin/bash
sed -i -e 's/#[multilib]/[multilib]/g' /etc/pacman.conf
sed -i -e 's/#Include = /etc/pacman.d/mirrorlist/Include = /etc/pacman.d/mirrorlist/g' /etc/pacman.conf

