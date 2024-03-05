#!/bin/sh

if nmcli device show wlp2s0 | grep -q "conectado"; then
    icon=""
    ssid=Amadeus
    status="Connected to ${ssid}"
else
    icon="睊"
    status="offline"
fi

echo "{\"icon\": \"${icon}\", \"status\": \"${status}\"}" 
