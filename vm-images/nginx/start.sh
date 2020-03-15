#!/bin/bash
date > /tngbench_share/start.txt

while true;
do
 case "$1"
 in
 mp.input) shift;INPUT=$1;;
 mp.output1) shift;OUTPUT1=$1;;
 mp.output2) shift;OUTPUT2=$1;;
 vnf) shift;VNF=$1;;
 esac
 shift;
 if [ "$1" = "" ]; then
  break
 fi
done

export TCP_LISTEN_PORT=8080
sed -i 's/TCP_LISTEN_PORT/'"$TCP_LISTEN_PORT"'/g' /etc/nginx/nginx.conf
sed -i 's/TCP_SERVER1/'"server  $OUTPUT1:80;"'/g' /etc/nginx/nginx.conf
sed -i 's/TCP_SERVER2/'"server  $OUTPUT2:80;"'/g' /etc/nginx/nginx.conf

sleep 10
echo "server added"
nginx &

echo "Nginx VNF started ..."
