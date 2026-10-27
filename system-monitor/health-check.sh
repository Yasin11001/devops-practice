
#!/bin/bash

# Save output to terminal and append it to health.log
LOG_FILE="$(dirname "$0")/health.log"
exec > >(tee -a "$LOG_FILE") 2>&1

echo ""
echo "================================"
echo "     SYSTEM HEALTH CHECK"
echo "================================"
echo "Report Time: $(date '+%Y-%m-%d %H:%M:%S')"

echo ""
echo "Hostname:"
hostname

echo ""
echo "System Uptime:"
uptime

echo ""
echo "RAM Usage:"
free -h

RAM_USAGE=$(free | awk '/^Mem:/ {printf "%.0f", ($2-$7)/$2*100}')

echo ""
echo "RAM Health Status:"
if [ "$RAM_USAGE" -ge 80 ]; then
    echo "WARNING: RAM usage is ${RAM_USAGE}%"
else
    echo "OK: RAM usage is ${RAM_USAGE}%"
fi

echo ""
echo "Disk Usage:"
df -h /

DISK_USAGE=$(df -P / | awk 'NR==2 {gsub(/%/,"",$5); print $5}')

echo ""
echo "Disk Health Status:"
if [ "$DISK_USAGE" -ge 80 ]; then
    echo "WARNING: Disk usage is ${DISK_USAGE}%"
else
    echo "OK: Disk usage is ${DISK_USAGE}%"
fi

echo ""
echo "Top 5 Processes by CPU:"
ps aux --sort=-%cpu | head -n 6

echo ""
echo "================================"
echo "CHECK COMPLETE"
echo "================================"
echo "Report saved to: $LOG_FILE"
echo "===== Run finished: $(date '+%Y-%m-%d %H:%M:%S') ====="

