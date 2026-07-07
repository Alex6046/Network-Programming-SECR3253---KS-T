# SECR3253 Network Programming Group Assignment

## Project Title

Network Automation and Linux System Information Project

## Overview

This repository contains a Docker-based automation project for SECR3253 Network Programming. It uses Ansible to configure and verify a Cisco IOS network device, and a Linux shell script to collect system information.

Main automation tasks:

- Configure Cisco IOS interface IP address and description
- Configure Cisco IOS user account
- Configure Cisco IOS MOTD banner
- Configure Cisco IOS static route
- Retrieve Cisco IOS device information
- Verify applied device configuration
- Collect Linux system information

## Group Members

| No. | Name | Matric No. |
| --- | --- | --- |
| 1 | AZRY FIKRI ISKANDAR BIN ROSLAN | B24CS0009 |
| 2 | NAJMI HAKIN BIN SAHARIN MIZAM | B24CS0031 |
| 3 | ABU TALIB BIN MOHAMED RAZIK | B24CS0002 |
| 4 | MUHAMMAD FIRDAUS BIN MD SHAHRUNNNAHAR | A24CS5031 |
| 5 | THEYSHIGAN A/L MANI BALAN | A24CS0202 |

## Tools Used

- Git and GitHub
- Docker
- Docker Compose
- Ansible
- Cisco IOS Ansible collection
- Linux shell script

## Repository Structure

```text
.
├── Dockerfile
├── docker-compose.yml
├── run_all.sh
├── README.md
├── device_config/
│   ├── inventory.example.yml
│   ├── configure_ip_interface.yml
│   ├── configure_user_banner_route.yml
│   ├── retrieve_device_info.yml
│   ├── test_device_config.yml
│   ├── TESTING.md
│   ├── device_info_output.txt
│   ├── test_report_output.txt
│   ├── person2_sample_output.txt
│   └── person5_sample_output.txt
├── linux_info/
│   ├── system_info.sh
│   └── sample_output.txt
└── outputs/
    ├── 00_ansible_version.txt
    ├── 01_router_connection_test.txt
    ├── 02_linux_system_info.txt
    ├── 03_configure_ip_interface.txt
    ├── 04_configure_user_banner_route.txt
    ├── 05_retrieve_device_info.txt
    └── 06_final_verification_test.txt
```

## Task Division

| Member | Responsibility |
| --- | --- |
| Azry | Project setup, GitHub repository, Docker environment, README documentation, final integration |
| Najmi | Configure IP address and interface description automation |
| Abu | Configure user account, banner message, and static route automation |
| Theyshigan | Retrieve device information and perform testing |
| Firdaus | Collect Linux system information |

## Configuration Files

### `device_config/inventory.example.yml`

Shared Ansible inventory for Cisco IOS device connection.

Default values:

- Host: `router1`
- Device IP: `192.168.56.101`
- Username: `cisco`
- Password: `cisco123!`
- Enable password: `cisco`
- Connection: `ansible.netcommon.network_cli`
- Network OS: `cisco.ios.ios`

Update this file before running if device IP address or login details are different.

### `device_config/configure_ip_interface.yml`

Configures `Loopback0` with:

- Description: `Configured by Najmi using Ansible`
- IP address: `192.168.10.1`
- Netmask: `255.255.255.0`

### `device_config/configure_user_banner_route.yml`

Configures:

- User account: `admin`
- MOTD banner: `Unauthorized access is prohibited!`
- Static route: `192.168.20.0/24` via `192.168.56.1`

### `device_config/retrieve_device_info.yml`

Retrieves device information using Cisco IOS show commands and writes report to:

- `device_config/device_info_output.txt`

### `device_config/test_device_config.yml`

Verifies device configuration with Ansible assertions and writes report to:

- `device_config/test_report_output.txt`

### `linux_info/system_info.sh`

Collects Linux system information:

- Hostname
- Date and time
- CPU information
- Memory usage
- Disk usage
- Logged-in users
- Top 5 processes by CPU usage

## How To Run

Requirements:

- Git
- Docker
- Cisco IOS device reachable from host machine
- Correct credentials in `device_config/inventory.example.yml`

Run all tasks from fresh clone:

```bash
git clone https://github.com/Alex6046/Network-Programming-SECR3253---KS-T.git
cd Network-Programming-SECR3253---KS-T
chmod +x run_all.sh
./run_all.sh
```

The `run_all.sh` script will:

1. Build Docker image `network-automation`
2. Start container with project folder mounted at `/app`
3. Install/check required Ansible and Paramiko setup
4. Test router connectivity
5. Run Linux system information script
6. Run all Cisco IOS configuration playbooks
7. Retrieve device information
8. Run final verification tests
9. Save command outputs in `outputs/`

## Output Proof

After successful run, output files are saved in:

- `outputs/00_ansible_version.txt`
- `outputs/01_router_connection_test.txt`
- `outputs/02_linux_system_info.txt`
- `outputs/03_configure_ip_interface.txt`
- `outputs/04_configure_user_banner_route.txt`
- `outputs/05_retrieve_device_info.txt`
- `outputs/06_final_verification_test.txt`
- `linux_info/sample_output.txt`
- `device_config/device_info_output.txt`
- `device_config/test_report_output.txt`

## Manual Run Commands

If running playbooks manually inside prepared environment:

```bash
ansible --version
ansible network_devices -i device_config/inventory.example.yml -m cisco.ios.ios_command -a "commands='show ip interface brief'"
bash linux_info/system_info.sh
ansible-playbook -i device_config/inventory.example.yml device_config/configure_ip_interface.yml
ansible-playbook -i device_config/inventory.example.yml device_config/configure_user_banner_route.yml
ansible-playbook -i device_config/inventory.example.yml device_config/retrieve_device_info.yml
ansible-playbook -i device_config/inventory.example.yml device_config/test_device_config.yml
```

## Final Deliverables

- GitHub repository
- Docker-based automation project
- Ansible device configuration playbooks
- Linux system information script
- Output proof files
- README documentation
- GitHub commit history from all members
- Personal reflection report from each member

## Deadline

Submission deadline: 6 July 2026, 9:00 AM
