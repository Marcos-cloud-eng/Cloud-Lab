#!/bin/bash

# ==========================================
# SERVICE TROUBLESHOOTING CHECK
# Networking Lab 02
# ==========================================

HOST="127.0.0.1"
PORT="8000"
URL="http://${HOST}:${PORT}"
REPORT="../data/troubleshooting_report.txt"

echo "==========================================" > "$REPORT"
echo "SERVICE TROUBLESHOOTING REPORT" >> "$REPORT"
echo "==========================================" >> "$REPORT"
echo "Generated: $(date)" >> "$REPORT"

echo "" >> "$REPORT"
echo "TARGET" >> "$REPORT"
echo "------------------------------------------" >> "$REPORT"
echo "Host: $HOST" >> "$REPORT"
echo "Port: $PORT" >> "$REPORT"
echo "URL:  $URL" >> "$REPORT"

# ------------------------------------------
# PROCESS / SOCKET CHECK
# ------------------------------------------

echo "" >> "$REPORT"
echo "LISTENING SOCKET CHECK" >> "$REPORT"
echo "------------------------------------------" >> "$REPORT"

if ss -tln | grep -q ":$PORT "
then
    echo "Port $PORT: LISTENING" >> "$REPORT"
else
    echo "Port $PORT: NOT LISTENING" >> "$REPORT"
fi

# ------------------------------------------
# TCP CHECK
# ------------------------------------------

echo "" >> "$REPORT"
echo "TCP CONNECTIVITY CHECK" >> "$REPORT"
echo "------------------------------------------" >> "$REPORT"

if nc -z "$HOST" "$PORT" 2>/dev/null
then
    echo "TCP Connection: OK" >> "$REPORT"
else
    echo "TCP Connection: FAILED" >> "$REPORT"
fi

# ------------------------------------------
# HTTP CHECK
# ------------------------------------------

echo "" >> "$REPORT"
echo "HTTP CHECK" >> "$REPORT"
echo "------------------------------------------" >> "$REPORT"

HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" \
    --connect-timeout 3 "$URL")

if [ "$HTTP_STATUS" = "200" ]
then
    echo "HTTP Service: OK" >> "$REPORT"
    echo "HTTP Status: $HTTP_STATUS" >> "$REPORT"
else
    echo "HTTP Service: FAILED" >> "$REPORT"
    echo "HTTP Status: $HTTP_STATUS" >> "$REPORT"
fi

echo "" >> "$REPORT"
echo "==========================================" >> "$REPORT"
echo "TROUBLESHOOTING CHECK COMPLETED" >> "$REPORT"
echo "==========================================" >> "$REPORT"

echo "Report generated:"
echo "$REPORT"
