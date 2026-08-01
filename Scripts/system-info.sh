#!/bin/bash

echo "===== SYSTEM INFORMATION ====="
echo

echo "Hostname:"
hostname

echo
echo "Current User:"
whoami

echo
echo "Current Directory:"
pwd

echo
echo "Kernel:"
uname -r

echo
echo "Memory:"
free -h

echo
echo "Disk:"
df -h /

echo
echo "IP Address:"
hostname -I
