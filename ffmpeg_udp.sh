LOGFILE=udp5.log
echo '' > $LOGFILE
STARTTIME=date
echo "Started at `$STARTTIME`" >> $LOGFILE
while :
do
        echo `ffmpeg -hide_banner -i udp://172.16.0.169:5025?listen -vf showinfo /home/sana/Desktop/SENDER/video/udp5.mp4 2>> /home/sana/Desktop/SENDER/logs/udp5local.txt -y` &
        echo `ffmpeg -hide_banner -f v4l2 -i /dev/video0 -f mpegts udp://172.16.0.169:5024 -f mpegts udp://172.16.0.196:5025 2>> $LOGFILE -y` &
        wireshark -i eno1 -k -a duration:50 -w /home/sana/Desktop/SENDER/pcap/udp5.pcap
	echo "done" >> $LOGFILE
done

