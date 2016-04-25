#!/bin/sh
    echo "Content-type: text/html\n"

    # read in our parameters
    CMD=`echo "$QUERY_STRING" | sed -n 's/^.*cmd=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
    FOLDER=`echo "$QUERY_STRING" | sed -n 's/^.*folder=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"| sed "s/%2F/\//g"`
    FOLDER1=`echo "$QUERY_STRING" | sed -n 's/^.*folder1=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"| sed "s/%2F/\//g"`
    FOLDER2=`echo "$QUERY_STRING" | sed -n 's/^.*folder2=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"| sed "s/%2F/\//g"`

    # our html header
    echo "<!DOCTYPE html>"
    echo "<html lang="en">"
    echo "<head><meta charset="utf-8">"
    echo "<meta name="viewport" content="width=device-width, initial-scale=1">"
    echo '<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">'
    echo "<style>"
    echo ".btn {width:100%;height:100px;font-size:3vw !important}"
    echo ".btn-success, .btn-danger, btn-primary {border-color:black}"
    echo "iframe {border: none;}"
    echo "body {background:url('http://www.bradysammons.com/codepen/darkui/noise.png')repeat;color:#F5F5F5;}"
    echo "</style>"
    echo "</head>"
    echo "<body>"

        # test if any parameters were passed
    if [ $CMD ]
    then
      case "$CMD" in
        tvoncommand)
          echo 'on 0' | cec-client -s
          ;;

        tvoffcommand)
          echo "standby 0" | cec-client -s
          ;;

        UpdateSpecials)
          echo "Output of dmesg :<pre>"
          /bin/bash updatespecials.sh
	  echo "</pre>"
          ;;

 	WeekdayBreakfast)
          echo "Output of df -h :<pre>"
	        nohup /home/pi/breakfast.sh
          echo "</pre>"
          ;;

    	WeekendBreakfast)
          echo "Output of free :<pre>"
          nohup /home/pi/weekendbreakfast
          echo "</pre>"
          ;;

     hw)
              echo "Hardware listing :<pre>"
              /usr/bin/lshw
              echo "</pre>"
              ;;


     lsusb)
              echo "lsusb :<pre>"
              /usr/bin/lsusb
              echo "</pre>"
              ;;

    lsuser)
              echo "List of users :<pre>"
              /usr/bin/lsuser
              echo "</pre>"
              ;;

        ls)
          echo "Output of ls $FOLDER :<pre>"
          echo uri "$FOLDER" | socat - unix-connect:`echo /tmp/uzbl_socket_*`
          echo "</pre>"
          ;;

            lsal)
              echo "Output of ls $FOLDER1 :<pre>"
              /bin/ls -al "$FOLDER1"
              echo "</pre>"
              ;;

          wol)
              echo "System to wake: $FOLDER2 :<pre>"
              /usr/bin/wakeonlan "$FOLDER2"
              echo "</pre>"
              ;;


        lsb_release)
          echo "Ubuntu version :<pre>"
          /usr/bin/lsb_release -a
          echo "</pre>"
          ;;

           cpuinfo)
              echo "Cpu information :<pre>"
              cat /proc/cpuinfo
              echo "</pre>"
              ;;

         *)
          echo "Unknown command $CMD<br>"
          ;;
      esac
    fi

    # print out the form

    # page header
    echo '<div class="container">'
    echo '<div class="row">'
    echo '<div class="col-sm-12 col-md-11 col-lg-11">'
    echo "<p>"
    echo "<center>"
    echo "<h2>Menuboard Display Control App</h2>"
    echo "</center>"
    echo "<p>"
    echo "<p>"
    echo "<center><h3>Live View updated every 10 seconds</h3></center>"
    echo "<iframe src='../screen.html' height="300px" width="100%"></iframe>"
    echo "<form method=get>"
    echo '<button type=submit class="btn btn-success" name=cmd value=tvoncommand>Turn the TV on</a></button> <br><br>'
    echo "<button class='btn btn-danger' type=submit name=cmd value=tvoffcommand> Turn the TV off</button><br><br>"
    echo '<button class="btn btn-primary" name=cmd value=UpdateSpecials>Update the specials menu</button><br><br>'
    echo '<button class="btn btn-primary" type=submit name=cmd value=WeekdayBreakfast>Weekday Breakfast Playlist</button><br><br>'
    echo '<button class="btn btn-primary" type=submit name=cmd value=WeekendBreakfast>Weekend Breakfast Playlist</button><br><br>'
    echo "<input type=radio id=radio1-1 name=cmd value=cpuinfo> Cpu information <br>"
    echo "<input type=radio name=cmd value=hw> Hardware listing <br>"
    echo "<input type=radio name=cmd value=lsuser> User listing <br>"
    echo "<input type=radio name=cmd value=lsusb> lsusb (Usb ports info)<br>"
    echo "<input type=radio name=cmd value=ls>Enter a URL to load <input type=text name=folder value=m58cafe.calvarychatt.com/index.php/><br>"
    echo "<input type=radio name=cmd value=lsal> ls -al -- folder <input type=text name=folder1 value=/mnt/flash><br>"
echo "<input type=radio name=cmd value=wol> wakeonlan (enter mac address) <input type=text name=folder2 value=00:00:00:00:00:00><br>"
    echo "<input type=submit>"
    echo "</form>"
    echo '</div></div></div>'
    echo "</body>"
    echo "</html>"
