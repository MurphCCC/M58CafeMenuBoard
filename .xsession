# This file resides in the home directory and sets the parameters for our session.  These parameters are loaded on each boot.  This will
# ensure that any power saving features will be turned off (we don't want the screen to all of the sudden go black while people are
# standing in line because our console went to sleep!)  This will also launch the matchbox-window-manager and uzbl in full screen mode.

# 07/28/16  - The URL has been updated.  Tuesday I was playing around with the server and accidentally locked myself out.  I had a backup
# from earlier in the month that I was able to transfer over to the dev server that I had been using.  In the live script I am using the
# ip of the server, however here I am simply using the URL.

#!/bin/bash
xset -dpms     # disable DPMS (Energy Star) features.
xset s off       # disable screen saver
xset s noblank # don't blank the video device
uzbl -c uzbl.conf http://m58cafe.calvarychatt.com/index.php/14-2 &
exec matchbox-window-manager -use_titlebar no -use_cursor no
