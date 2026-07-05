#!/bin/bash
# SECR3253 Network Programming Group Assignment
# Person 1 Integration Script
# Purpose: Run all automation tasks using one command.

set -e

echo "================================================="
echo " SECR3253 Network Automation - Run All Script"
echo "================================================="
echo ""

# Move to the folder where this script is located
cd "$(dirname "$0")"

# Create folders if they do not exist
mkdir -p device_config
mkdir -p linux_info
mkdir -p output_proof

# File paths
INVENTORY="device_config/inventory.example.yml"
IP_PLAYBOOK="device_config/configure_ip_interface.yml"
USER_BANNER_ROUTE_PLAYBOOK="device_config/configure_user_banner_route.yml"
RETRIEVE_PLAYBOOK="device_config/retrieve_device_info.yml"
TEST_PLAYBOOK="device_config/test_device_config.yml"
LINUX_SCRIPT="linux_info/system_info.sh"

# Backup option if system_info.sh is in the main folder instead of linux_info folder
if [ ! -f "$LINUX_SCRIPT" ] && [ -f "system_info.sh" ]; then
    LINUX_SCRIPT="system_info.sh"
fi

# Check required files
check_file() {
    if [ ! -f "$1" ]; then
        echo "ERROR: Missing file: $1"
        echo "Please make sure the file exists before running this script."
        exit 1
    fi
}

echo "Checking required files..."
check_file "$INVENTORY"
check_file "$IP_PLAYBOOK"
check_file "$USER_BANNER_ROUTE_PLAYBOOK"
check_file "$RETRIEVE_PLAYBOOK"
check_file "$TEST_PLAYBOOK"
check_file "$LINUX_SCRIPT"
echo "All required files found."
echo ""

# Install required Ansible collection
echo "Installing Cisco IOS Ansible collection..."
ansible-galaxy collection install cisco.ios

echo ""
echo "================================================="
echo " STEP 1: Configure IP address and interface description"
echo "================================================="
ansible-playbook -i "$INVENTORY" "$IP_PLAYBOOK" | tee device_config/person2_sample_output.txt

echo ""
echo "================================================="
echo " STEP 2: Configure user account, banner and static route"
echo "================================================="
ansible-playbook -i "$INVENTORY" "$USER_BANNER_ROUTE_PLAYBOOK" | tee device_config/person3_sample_output.txt

echo ""
echo "================================================="
echo " STEP 3: Retrieve device information"
echo "================================================="
ansible-playbook -i "$INVENTORY" "$RETRIEVE_PLAYBOOK" | tee device_config/person5_sample_output.txt

echo ""
echo "================================================="
echo " STEP 4: Run final device configuration testing"
echo "================================================="
ansible-playbook -i "$INVENTORY" "$TEST_PLAYBOOK" | tee device_config/test_report_output.txt

echo ""
echo "================================================="
echo " STEP 5: Collect Linux system information"
echo "================================================="
chmod +x "$LINUX_SCRIPT"
"$LINUX_SCRIPT" | tee linux_info/sample_output.txt

echo ""
echo "================================================="
echo " ALL TASKS COMPLETED"
echo "================================================="
echo "Output proof files saved here:"
echo "- device_config/person2_sample_output.txt"
echo "- device_config/person3_sample_output.txt"
echo "- device_config/person5_sample_output.txt"
echo "- device_config/test_report_output.txt"
echo "- linux_info/sample_output.txt"
echo ""
echo "Next step: git add ., git commit, and git push to GitHub."
