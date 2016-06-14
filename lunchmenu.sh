## This script is currently being run via a cronjob everyday at 10:55AM.  This script should be invoked using nohup to ensure that it does not die off causing the playlist to stop and resulting in a black screen.  Everytime that an asset is loaded we are taking a screenshot of the console and moving it to the local webserver so that we can view it in our control app.

#!/bin/bash
socket=/tmp/uzbl_socket_*
blackimage=$( hexdump blank.png | wc | awk '{print$1}')
url=http://m58cafe.calvarychatt.com/index.php
DISPLAY=:0

echo "Turning off Power Save"

xset s off
xset -dpms
xset s noblank

killall uzbl-core
killall breakfast.sh
rm /tmp/uzbl_socket_*

/usr/bin/uzbl -c /home/pi/uzbl.conf -u $url/14-2

while :
do
        echo uri $url/14-2 | socat - unix-connect:`echo $socket`
        sudo scrot temp.jpg
        sleep 15

        echo uri $url/featured-specials | socat - unix-connect:`echo $socket`
        sudo scrot temp.jpg
        sleep 15
done
