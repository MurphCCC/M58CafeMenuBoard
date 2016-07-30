
#  07/28/16 - This is the most current tested version of the lunch playlist script.  Currently we are using UZBL browser to load the 
#  lunch/Dinner menu followed by the specials menu.  Currently for breakfast we are simply displaying a still slide using
#  FEH.  This is placed into a cronjob.  We want to make sure that we kill any of these existing processes.  

# 07/30/16 - Changed the way we set up the socket variable, the previous method was too broad, changed it so that we always know the
# socket of the currently running version of uzbl.  This script now works together with a php script that can be called via curl
# allowing us to essentially build a remote control app for UZBl

#!/bin/bash
#socket=/tmp/uzbl_socket_* #Old Method
socket=/tmp/uzbl_socket_`ps -aux | pgrep uzbl`

blackimage=$( hexdump blank.png | wc | awk '{print$1}')
url=http://m58cafe.calvarychatt.com/index.php
DISPLAY=:0

echo "Turning off Power Save"

xset s off -display :0
xset -dpms -display :0
xset s noblank -display :0

killall weekday-breakfast.sh
killall weekend-breakfash.sh
killall feh

while :
do
        echo uri $url/14-2 | socat - unix-connect:`echo $socket`
        sleep 15

        echo uri $url/featured-specials | socat - unix-connect:`echo $socket`
        sleep 15
done
