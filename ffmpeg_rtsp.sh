LOGFILE=rtsp10.log
echo '' > $LOGFILE
STARTTIME=date
echo "Started at `$STARTTIME`" >> $LOGFILE
while :
do
        echo `ffmpeg -hide_banner -rtsp_flags listen -i rtsp://172.16.0.196:7001 -vf showinfo /home/sana/Desktop/SENDER/video/rtsp10.mp4 2>> /home/sana/Desktop/SENDER/logs/rtsp10local.txt -y` &
        echo `ffmpeg -hide_banner -f v4l2 -i /dev/video0 -f rtsp rtsp://172.16.0.169:7000 -f rtsp rtsp://172.16.0.196:7001 2>> $LOGFILE -y` &
	wireshark -i eno1 -k -a duration:50 -w /home/sana/Desktop/SENDER/pcap/rtsp10.pcap
        echo "done" >> $LOGFILE
done

