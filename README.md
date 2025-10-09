# System Health Monitoring Script 🖥️

**Author:** Aman Raj  
**Email:** raj.amany05@gmail.com  

---

## Overview
This **Bash script** monitors the health of a Linux system in real-time.  
It tracks:
- **CPU usage**
- **Memory usage**
- **Disk space**
- **Running processes**

If any metric exceeds predefined thresholds, it sends alerts to both **console** (with colors) and **log file**.

---

## Features
- Real-time monitoring every 10 seconds  
- Alerts printed in **red** for high usage  
- Logs alerts to `system_health.log`  
- Easy to configure thresholds  

---

## Prerequisites
- Linux or macOS system with Bash  
- Commands: `top`, `free`, `df`, `ps`  
- Optional: Terminal that supports ANSI colors for better readability  

---

## Usage

1. Make the script executable:
```bash
chmod +x system_health_monitor.sh


2. Run the script:
./system_health_monitor.sh




