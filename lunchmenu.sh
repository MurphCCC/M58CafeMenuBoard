## This script is currently being run via a cronjob everyday at 10:55AM.  This script should be invoked using nohup to ensure that it does not die off causing the playlist to stop and resulting in a black screen.  Everytime that an asset is loaded we are taking a screenshot of the console and moving it to the local webserver so that we can view it in our control app.

#!/bin/bash
socket=/tmp/uzbl_socket_*
blackimage=$( hexdump blank.png | wc | awk '{print$1}')

echo "Turning off Power Save"

xset s off -display :0
xset -dpms -display :0
xset s noblank -display :0

killall uzbl-core & sleep 2s
killall breakfast.sh
rm /tmp/uzbl_socket_* & sleep 2s

/usr/bin/uzbl -c /home/pi/uzbl.conf -u localhost/blank.html --display=:0 & sleep 2s

while :
do
        echo uri localhost/lunch.html | socat - unix-connect:`echo $socket`;
        DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/$DISPLAY xwd -root > /tmp/screenshot.xwd;
        sudo convert /tmp/screenshot.xwd /var/www/html/screenshot.png;
        sleep 15

        echo uri localhost/specials.html | socat - unix-connect:`echo $socket`;
        DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/$DISPLAY xwd -root > /tmp/screenshot.xwd;
        sudo convert /tmp/screenshot.xwd /var/www/html/screenshot.png;
        sleep 15
done
