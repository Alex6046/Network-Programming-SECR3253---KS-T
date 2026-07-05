#!/bin/bash
# Purpose: Automatically collect and display Linux system information.

echo ""
echo "      LINUX SYSTEM INFORMATION REPORT     "
echo ""

# 1. Display Hostname
echo "HOSTNAME:"
hostname
echo ""

# 2. Display current date and time
echo "DATE AND TIME:"
date
echo ""

# 3. Display CPU information
echo "CPU INFORMATION:"
lscpu | grep "Model name"
echo ""

# 4. Display memory usage
echo "MEMORY USAGE:"
free -h
echo ""

# 5. Display disk usage
echo "DISK USAGE:"
df -h --total | grep "total"
echo ""