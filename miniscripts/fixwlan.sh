#!/bin/bash
var=`ps -eaf | grep nm-applet | wc -l`
if [ $var -lt "2" ]; 
 then
  echo "Prozess läuft nicht"
 else
  killall nm-applet 
  nm-applet &
fi
