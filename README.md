# M58CafeMenuBoard
A collection of scripts and documentation regarding our Cafe Menuboard Digital Signage system powered by Wordpress, UZBL and a Raspberry Pi.


This is my attempt to document all of the moving pieces involved in our Digital Signage solution.  This project currently consists of the following pieces:

- A Raspberry Pi 2 with a 16gb SD card running Raspbian OS.
- UZBL browser running on the PI in a terminal session in full screen mode with no desktop environment.
- A Wordpress installation running on a local ESXi Server which is serving content to the PI as well as to external clients.
- A 70in Vizio TV to display the content.
- A collection of scripts to better manage content and display.

This repository includes all of the custom configuration files needed for everything to work, as well as all of the scripts that are being used to manage content and the Raspberry Pi/TV.

# The following commands can be used to control the TV via CEC

# Turn TV on
echo 'on 0' | cec-client -s

# Turn TV off
echo 'standby 0' | cec-client -s


# Screenshots - I have found that the easiest way to see what is on the screen without actually being in the room is this simple command:

  DISPLAY=:0 sudo scrot screenshot.jpg
  
The scrot utility is used for taking screenshots and the above command is fairly simple.  I was previously using a more complex command that I found in another Raspberry Pi Kiosk repo, but in the interest of trying to make things run smoother I came across this simple approach.  Note that I set the Display variable manually because I am often running this over SSH.


## 06/14/16
Added a section for crontab entries found in cron.txt

