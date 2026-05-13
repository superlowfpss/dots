#!/bin/bash

exec 3> >(wayvrctl batch)
send() {
    echo "panel-modify watch $1 set-text \"$2\"" >&3
}
cleanup() {
    exec 3>&-
    exit 0
}
trap cleanup EXIT SIGTERM SIGINT
while true; do
    cpu_temp=$(sensors 2>/dev/null | grep -i "Tctl:" | head -1 | awk '{print $2}' | tr -d '+°C' | cut -d'.' -f1)
    [ -z "$cpu_temp" ] && cpu_temp="--"
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1 | awk '{printf "%.0f", $1}')
    gpu_temp=$(sensors 2>/dev/null | grep -i "edge:" | head -1 | awk '{print $2}' | tr -d '+°C' | cut -d'.' -f1)
    gpu_jnc=$(sensors 2>/dev/null | grep -i "junction:" | head -1 | awk '{print $2}' | tr -d '+°C' | cut -d'.' -f1)
    gpu_usage=$(cat /sys/class/drm/card1/device/gpu_busy_percent 2>/dev/null)
    [ -z "$gpu_usage" ] && gpu_usage="0"
    
    echo "panel-modify watch cputemp set-text \"cpu temp: ${cpu_temp}°C\"" >&3
    echo "panel-modify watch cpuusage set-text \"cpu: ${cpu_usage}%\"" >&3
    echo "panel-modify watch gputemp set-text \"gpu temp: ${gpu_temp}°C\"" >&3
    echo "panel-modify watch gpujnc set-text \"junc: ${gpu_jnc}°C\"" >&3
    echo "panel-modify watch gpuusage set-text \"gpu: ${gpu_usage}%\"" >&3
    
    sleep 1
done