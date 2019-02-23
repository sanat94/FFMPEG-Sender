#!/bin/bash
ffmpeg -hide_banner -f v4l2 -i /dev/video0 -f mpegts udp://localhost:4500 -f mpegts udp://localhost:4501  &

ffmpeg -hide_banner -i udp://localhost:4500 -y -vf showinfo -f mpegts udp://localhost:4502 2>> /home/sana/Desktop/SENDER/logs/tcp10local.txt &

ffplay udp://localhost:4502 &

while :
do
        ffmpeg -hide_banner -i udp://localhost:4501 \
                -f mpegts tcp://172.16.0.169:50000 \
                -f mpegts tcp://172.16.0.169:50001 \
                -f mpegts tcp://172.16.0.169:50002 & 
        wireshark -i eno1 -k -a duration:40 -w /home/sana/Desktop/SENDER/pcap/tcp10.pcap

done

