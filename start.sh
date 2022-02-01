#!/bin/bash
ip=$(ip a | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

echo "Configuration Menu"
echo "Choose one suitable configuration for serving the http server"
echo "1.) ${ip}:8000"
echo "2.) ${ip}:<manual port>"
echo "3.) Manual"
echo -n "choose >>"
read choice

if [[ $choice -eq 1 ]]
then
  date=$(date '+%Y%m%d%H%M%S')
  echo "serving on http://${ip}:8000"
  python -u -m http.server --bind ${ip} 8000 2> log${date}.txt
  cp log${date}.txt iplog${date}.txt
  sed -i 's/\s.*//' iplog${date}.txt
elif [[ $choice -eq 2 ]]
then
  date=$(date '+%Y%m%d%H%M%S')
  echo "insert port (1024 - 65535)"
  echo -n "${ip}:"
  read port
  echo "serving on http://${ip}:${port}"
  python -u -m http.server --bind ${ip} ${port} | sed 's/\s.*//' 2> log${date}.txt            
  cp log${date}.txt iplog${date}.txt
  sed -i 's/\s.*//' iplog${date}.txt
elif [[ $choice -eq 3 ]]
then
  date=$(date '+%Y%m%d%H%M%S')
  echo -n "insert ip (format: abc.def.ghi.jkl):"
  read ip
  echo;
  echo -n "insert port ${ip}:"
  read port
  echo "serving on http://${ip}:${port}"
  python -u -m http.server --bind ${ip} ${port} | sed 's/\s.*//' 2> log${date}.txt            
  cp log${date}.txt iplog${date}.txt
  sed -i 's/\s.*//' iplog${date}.txt
else
  echo "invalid input"
  exit
fi
