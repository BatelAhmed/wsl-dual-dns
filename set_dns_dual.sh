#!/bin/bash

HOST_IP=$(ip route | grep default | awk '{print $3}')

if ! nc -z $HOST_IP 6000; then
echo "[WARNING] X Server might not be running on Windows. Port 6000 not open."
fi

if [[ -z "$HOST_IP" ]]; then
  echo "[ERROR] Could not detect Windows host IP."
  exit 1
fi

echo "Detected Windows host IP: $HOST_IP"

sudo chattr -i /etc/resolv.conf

echo -e "nameserver $HOST_IP\nnameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null
echo "/etc/resolv.conf now contains:"
cat /etc/resolv.conf

sudo chattr +i /etc/resolv.conf
echo "🔒 Locked /etc/resolv.conf to prevent overwrites"

export DISPLAY=$HOST_IP:0
echo "DISPLAY set to: $DISPLAY"

if ! grep -q "export DISPLAY=" ~/.bashrc; then
  echo "export DISPLAY=$HOST_IP:0" >> ~/.bashrc
  echo "DISPLAY also added to ~/.bashrc"
fi

