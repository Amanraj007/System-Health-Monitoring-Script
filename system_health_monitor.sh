#!/bin/bash
# ===========================================================
# 🖥️ System Health Monitoring Script (macOS Compatible)
# Author: Aman Raj
# Email: raj.amany05@gmail.com
# ===========================================================

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80
LOG_FILE="system_health.log"

# Timestamp
timestamp() {
    date +"%Y-%m-%d %H:%M:%S"
}

# Log alert message
log_alert() {
    local message="$1"
    echo "[$(timestamp)] ALERT: $message"
    echo "[$(timestamp)] ALERT: $message" >> "$LOG_FILE"
}

# Check CPU usage (macOS)
check_cpu() {
    # Calculate total CPU usage excluding idle
    cpu_usage=$(ps -A -o %cpu | awk '{s+=$1} END {print s}')
    cpu_usage=${cpu_usage%.*}
    if [ "$cpu_usage" -gt "$CPU_THRESHOLD" ]; then
        log_alert "High CPU usage detected: ${cpu_usage}%"
    fi
    echo "$cpu_usage"
}

# Check memory usage (macOS)
check_memory() {
    total_mem=$(sysctl -n hw.memsize)
    free_mem=$(vm_stat | awk '/Pages free/ {print $3}' | sed 's/\.//')
    free_mem_bytes=$((free_mem * 4096))
    used_mem_percent=$(( (100 * (total_mem - free_mem_bytes)) / total_mem ))
    if [ "$used_mem_percent" -gt "$MEM_THRESHOLD" ]; then
        log_alert "High Memory usage detected: ${used_mem_percent}%"
    fi
    echo "$used_mem_percent"
}

# Check disk usage (macOS)
check_disk() {
    disk_usage=$(df / | awk 'END{print $5}' | sed 's/%//')
    if [ "$disk_usage" -gt "$DISK_THRESHOLD" ]; then
        log_alert "High Disk usage detected: ${disk_usage}%"
    fi
    echo "$disk_usage"
}

# Count running processes
check_processes() {
    process_count=$(ps aux | wc -l)
    echo "$process_count"
}

# Main monitoring loop
monitor_system() {
    echo "🔍 Starting System Health Monitoring..."
    echo "Logging alerts to: $LOG_FILE"
    echo "----------------------------------------"

    while true; do
        cpu=$(check_cpu)
        mem=$(check_memory)
        disk=$(check_disk)
        procs=$(check_processes)

        echo "$(timestamp) | CPU: ${cpu}% | MEM: ${mem}% | DISK: ${disk}% | PROCESSES: ${procs}"
        sleep 10
    done
}

monitor_system

