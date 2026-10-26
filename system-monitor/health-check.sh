#!/bin/bash

echo "================================"
echo "     SYSTEM HEALTH CHECK"
echo "================================"

echo ""
echo "Hostname:"
hostname

echo ""
echo "Current Date:"
date

echo ""
echo "System Uptime:"
uptime

echo ""
echo "RAM Usage:"
free -h

echo ""
echo "Disk Usage:"
df -h /

echo ""
echo "Top 5 Processes by CPU:"
ps aux --sort=-%cpu | head -n 6

echo ""
echo ""
echo "Disk Health Status:"

DISK_USAGE=$(df -P / | awk 'NR==2 {gsub(/%/,"",$5); print $5}')

if [ "$DISK_USAGE" -ge 80 ]; then
    echo "WARNING: Disk usage is ${DISK_USAGE}%"
else
    echo "OK: Disk usage is ${DISK_USAGE}%"
fi

echo "================================"
echo "     CHECK COMPLETE"
echo "================================"
