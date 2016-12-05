#!/bin/bash

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

if question "Do u want to install"; then 
	echo Y 
fi