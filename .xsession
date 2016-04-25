# This file resides in the home directory and sets the parameters for our session.  These parameters are loaded on each boot.  This will
# ensure that any power saving features will be turned off (we don't want the screen to all of the sudden go black while people are 
# standing in line because our console went to sleep!)  This will also launch the matchbox-window-manager and uzbl in full screen mode.

#!/bin/bash
xset -dpms     # disable DPMS (Energy Star) features.
xset s off       # disable screen saver
xset s noblank # don't blank the video device
uzbl -u http://m58cafe.calvarychatt.com/index.php/14-2 -c /home/pi/uzbl.conf &
exec matchbox-window-manager -use_titlebar no -use_cursor no
