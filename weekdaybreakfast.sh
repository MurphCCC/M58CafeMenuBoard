## This is our script to launch the breakfast playlist, it is very similiar to the lunch playlist, however it does not take a screenshot.
## Will need to invoke the screenshot.sh script seperately.  Note that we are basically caching the site locally using wget so that we
## have more control over the content and to ensure that it is available in the even that the server goes offline.
## wget -O /var/www/html/weekday-breakfast.html http://m58cafe.calvarychatt.com/index.php/weekeday-breakfast


#!/bin/bash
socket="/tmp/uzbl_socket_*"

echo "Turning off Power Save"

xset s off -display :0
xset -dpms -display :0
xset s noblank -display :0

# Killing off uzbl if open to ensure that everything gets reloaded
echo "Killing any open instances"

killall uzbl-core & sleep 1

echo "Flushing open pipes"

rm /tmp/uzbl_socket_* & sleep 1

uzbl -c uzbl.conf -u localhost/blank.html --display=:0 & sleep 2

while :
do
        echo uri http://localhost/weekday-breakfast | socat - unix-connect:`echo $socket`
        sleep 2700

        echo uri http://localhost/calvarychatt.html | socat - unix-connect: `echo $socket`
        sleep 5

done
