#!/bin/bash
LOGFILE=tcp10.log
echo '' > $LOGFILE 
STARTTIME=date
echo "Started at `$STARTTIME`" >> $LOGFILE
while :
do
	echo `ffmpeg -hide_banner -i tcp://localhost:50001?listen -vf showinfo /home/sana/Desktop/SENDER/video/tcp10.mp4 2>> /home/sana/Desktop/SENDER/logs/tcp10local.txt -y` &	
	echo `ffmpeg -hide_banner -f v4l2 -i /dev/video0 -f mpegts tcp://172.16.0.169:50000 -f mpegts tcp://localhost:50001 2>> $LOGFILE -y` &
	wireshark -i eno1 -k -a duration:50 -w /home/sana/Desktop/SENDER/pcap/tcp10.pcap
	echo "done" >> $LOGFILE
done

