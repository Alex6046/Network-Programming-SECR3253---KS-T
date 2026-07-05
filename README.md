# SECR3253 Network Programming Group Assignment

## Project Title
Network Automation and Linux System Information Project

## Project Overview
This project is developed for the SECR3253 Network Programming group assignment. The main purpose of this project is to create a small automation solution using Docker, Ansible, NETCONF, or related automation tools.

The project focuses on automating network device configuration tasks and collecting Linux system information. It is also managed using GitHub to show collaboration and contribution from all group members.

## Group Members
•⁠  AZRY FIKRI ISKANDAR BIN ROSLAN          B24CS0009
•⁠  ⁠NAJMI HAKIN BIN SAHARIN MIZAM           B24CS0031
•⁠  ⁠ABU TALIB BIN MOHAMED RAZIK             B24CS0002
•⁠  ⁠MUHAMMAD FIRDAUS BIN MD SHAHRUNNNAHAR   A24CS5031
•⁠  ⁠THEYSHIGAN A/L MANI BALAN               A24CS0202

## Assignment Requirements
The automation solution should be able to perform the following tasks:

### Device Configuration Tasks
•⁠  ⁠Configure IP address
•⁠  ⁠Configure user account
•⁠  ⁠Configure banner message
•⁠  ⁠Configure interface description
•⁠  ⁠Configure static route
•⁠  ⁠Retrieve device information

### Linux System Information Tasks
•⁠  ⁠Display hostname
•⁠  ⁠Display current date and time
•⁠  ⁠Display CPU information
•⁠  ⁠Display memory usage
•⁠  ⁠Display disk usage
•⁠  ⁠Display logged-in users
•⁠  ⁠Display top 5 running processes by CPU usage

## Tools Used
•⁠  ⁠GitHub / Git
•⁠  ⁠Docker
•⁠  ⁠Docker Compose
•⁠  ⁠Ansible
•⁠  ⁠NETCONF / Python
•⁠  ⁠Linux Shell Script

## Group Task Division

| Member     | Responsibility                                                                                    |
| ---        | ---                                                                                               |
| Azry       | Project setup, GitHub repository, Docker environment, README documentation, and final integration |
| Najmi      | Configure IP address and interface description automation                                         |
| Abu        | Configure user account, banner message, and static route automation                               |
| Theyshigan | Retrieve device information and perform testing                                                   |
| Firdaus    | Collect Linux system information                                                                  |

## Najmi : IP Address and Interface Description Automation

Using Ansible to configure a Cisco IOS network device interface. The playbook will set the interface description, assigns an IPv4 address, enables the interface and also will displays the running config for verification.

Files:
- `device_config/configure_ip_interface.yml`
- `device_config/inventory.example.yml`
- `device_config/person2_sample_output.txt`

Run command:

```bash
ansible-galaxy collection install cisco.ios
ansible-playbook -i device_config/inventory.example.yml device_config/configure_ip_interface.yml
```

**Before running, update `device_config/inventory.example.yml` with the real device IP address, username, password, and enable password. Update `interface_name`, `interface_ip`, and `interface_netmask` in `device_config/configure_ip_interface.yml` if the test device uses different values.**

## Personal Reflection Report
Each member must prepare a 2-page personal reflection report that includes:

1. Contribution to the project
2. Challenges encountered during collaboration
3. Lessons learned from the project

## Final Deliverables
- GitHub Repository URL
- Completed automation project
- README documentation
- GitHub commit history from all members
- Screenshots or output proof
- Personal reflection report from each member

## Deadline
Submission deadline: 6 July 2026, 9:00 AM
