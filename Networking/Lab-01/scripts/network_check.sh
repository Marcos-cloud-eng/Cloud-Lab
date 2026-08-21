#!/bin/bash

# ==========================================
# NETWORK CHECK - LINUX
# ==========================================

REPORT="../data/network_report.txt"

echo "==========================================" > "$REPORT"
echo "LINUX NETWORK REPORT" >> "$REPORT"
echo "==========================================" >> "$REPORT"
echo "Generated: $(date)" >> "$REPORT"

echo "" >> "$REPORT"
echo "HOST INFORMATION" >> "$REPORT"
echo "------------------------------------------" >> "$REPORT"

echo "Hostname: $(hostname)" >> "$REPORT"
echo "IP Address: $(hostname -I)" >> "$REPORT"

echo "" >> "$REPORT"
echo "NETWORK INTERFACES" >> "$REPORT"
echo "------------------------------------------" >> "$REPORT"

ip -brief addr >> "$REPORT"

echo "" >> "$REPORT"
echo "ROUTING TABLE" >> "$REPORT"
echo "------------------------------------------" >> "$REPORT"

ip route >> "$REPORT"

echo "" >> "$REPORT"
echo "INTERNET CONNECTIVITY" >> "$REPORT"
echo "------------------------------------------" >> "$REPORT"

if ping -c 2 8.8.8.8 > /dev/null 2>&1
then
    echo "Internet Connectivity: OK" >> "$REPORT"
else
    echo "Internet Connectivity: FAILED" >> "$REPORT"
fi

echo "" >> "$REPORT"
echo "DNS RESOLUTION" >> "$REPORT"
echo "------------------------------------------" >> "$REPORT"

if ping -c 2 google.com > /dev/null 2>&1
then
    echo "DNS Resolution: OK" >> "$REPORT"
else
    echo "DNS Resolution: FAILED" >> "$REPORT"
fi

echo "" >> "$REPORT"
echo "HTTP/HTTPS CHECK" >> "$REPORT"
echo "------------------------------------------" >> "$REPORT"

HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://example.com)

echo "HTTP Status: $HTTP_STATUS" >> "$REPORT"

echo "" >> "$REPORT"
echo "LISTENING PORTS" >> "$REPORT"
echo "------------------------------------------" >> "$REPORT"

ss -tuln >> "$REPORT"

echo "" >> "$REPORT"
echo "==========================================" >> "$REPORT"
echo "NETWORK CHECK COMPLETED" >> "$REPORT"
echo "==========================================" >> "$REPORT"

echo "Report generated successfully:"
echo "$REPORT"
