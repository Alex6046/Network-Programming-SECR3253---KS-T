#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="network-automation"
INVENTORY="device_config/inventory.example.yml"

echo "=================================================="
echo " Network Programming SECR3253 - Run All Script"
echo "=================================================="

# If this script is run from the VM host, build Docker and rerun this script inside Docker.
if [[ "${RUNNING_IN_DOCKER:-0}" != "1" ]]; then
    echo "[HOST] Running from VM host."

    if ! command -v docker >/dev/null 2>&1; then
        echo "ERROR: Docker is not installed or not available."
        echo "Install Docker first, or run this script inside the prepared Docker container."
        exit 1
    fi

    if [[ ! -f "Dockerfile" ]]; then
        echo "ERROR: Dockerfile not found in current folder."
        echo "Please run this script from the main project folder."
        exit 1
    fi

    echo "[HOST] Building Docker image: ${IMAGE_NAME}"
    docker build -t "${IMAGE_NAME}" .

    echo "[HOST] Starting Docker container and running all tasks..."
    docker run -it --rm \
        --network host \
        -e RUNNING_IN_DOCKER=1 \
        -e ANSIBLE_HOST_KEY_CHECKING=False \
        -v "$PWD":/app \
        -w /app \
        "${IMAGE_NAME}" bash ./run_all.sh

    exit 0
fi

# From here onward, the script runs inside Docker.
echo "[DOCKER] Running inside Docker container."

export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_DEPRECATION_WARNINGS=False
export ANSIBLE_COMMAND_TIMEOUT=60

mkdir -p outputs

# Check required files.
required_files=(
    "$INVENTORY"
    "device_config/configure_ip_interface.yml"
    "device_config/configure_user_banner_route.yml"
    "device_config/retrieve_device_info.yml"
    "device_config/test_device_config.yml"
    "linux_info/system_info.sh"
)

for file in "${required_files[@]}"; do
    if [[ ! -f "$file" ]]; then
        echo "ERROR: Required file missing: $file"
        exit 1
    fi
done

# Make sure Paramiko version is compatible with older CSR1kv SSH.
echo "[DOCKER] Checking Paramiko version..."
if python - <<'PY'
import sys
try:
    import paramiko
    sys.exit(0 if paramiko.__version__ == "2.12.0" else 1)
except Exception:
    sys.exit(1)
PY
then
    echo "[DOCKER] Paramiko 2.12.0 already installed."
else
    echo "[DOCKER] Installing Paramiko 2.12.0 for CSR1kv SSH compatibility..."
    pip install --quiet --force-reinstall "paramiko==2.12.0"
fi

run_step() {
    local step_name="$1"
    shift

    echo ""
    echo "=================================================="
    echo "Running: ${step_name}"
    echo "=================================================="

    "$@" 2>&1 | tee "outputs/${step_name}.txt"
}

echo ""
echo "Saving all command outputs inside: outputs/"

run_step "00_ansible_version" \
    ansible --version

run_step "01_router_connection_test" \
    ansible network_devices -i "$INVENTORY" -m cisco.ios.ios_command -a "commands='show ip interface brief'"

run_step "02_linux_system_info" \
    bash -c "chmod +x linux_info/system_info.sh && ./linux_info/system_info.sh | tee linux_info/sample_output.txt"

run_step "03_configure_ip_interface" \
    ansible-playbook -i "$INVENTORY" device_config/configure_ip_interface.yml

run_step "04_configure_user_banner_route" \
    ansible-playbook -i "$INVENTORY" device_config/configure_user_banner_route.yml

run_step "05_retrieve_device_info" \
    ansible-playbook -i "$INVENTORY" device_config/retrieve_device_info.yml

run_step "06_final_verification_test" \
    ansible-playbook -i "$INVENTORY" device_config/test_device_config.yml

echo ""
echo "=================================================="
echo "ALL TASKS COMPLETED SUCCESSFULLY"
echo "=================================================="
echo "Output proof files are saved in:"
echo "  outputs/"
echo ""
echo "Main proof files:"
echo "  outputs/03_configure_ip_interface.txt"
echo "  outputs/04_configure_user_banner_route.txt"
echo "  outputs/05_retrieve_device_info.txt"
echo "  outputs/06_final_verification_test.txt"
echo "  linux_info/sample_output.txt"
echo ""
