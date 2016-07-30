<?php
/*
*
*/
$count = shell_exec('ps -aux | pgrep uzbl | wc -l');

echo $count;
print_r($var1);

	if($count > 1) { //If we have multiple instances of uzbl, kill them all, clear sockets and start a fresh instance.
		shell_exec('killall uzbl-core');
		shell_exec('rm /tmp/uzbl_*');
		shell_exec('DISPLAY=:0 nohup /usr/bin/uzbl -c /home/pi/uzbl.conf -u http://m58cafe.calvarychatt.com/index.php/14-2');
	} elseif($count == 0) { //If we have no instances of uzbl then start one, sleep a couple seconds and load the lunch playlist
		shell_exec('DISPLAY=:0 nohup /usr/bin/uzbl -c /home/pi/uzbl.conf -u http://m58cafe.calvarychatt.com/index.php/14-2 & sleep 2 && nohup /home/pi/lunchmenu.sh');
	} elseif($count == 1) { //If we have exactly one copy open, kill any instances of the lunch playlist and start a new one.
		shell_exec('killall lunchmenu.sh');
		shell_exec('nohup /home/pi/lunchmenu.sh');
	}

?>
