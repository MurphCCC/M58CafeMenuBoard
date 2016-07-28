
#  07/28/16 - This is the most current tested version of the lunch playlist script.  Currently we are using UZBL browser to load the 
#  lunch/Dinner menu followed by the specials menu.  Currently for breakfast we are simply displaying a still slide using
#  FEH.  This is placed into a cronjob.  We want to make sure that we kill any of these existing processes.  

#!/bin/bash
socket=/tmp/uzbl_socket_*
blackimage=$( hexdump blank.png | wc | awk '{print$1}')
url=http://192.168.10.168/index.php
DISPLAY=:0
EXPORT $DISPLAY

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
