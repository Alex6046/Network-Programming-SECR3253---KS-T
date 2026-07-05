# Theyshigan : Retrieve Device Information and Testing

**Member:** Theyshigan A/L Mani Balan (A24CS0202)
**Task:** Retrieve device information and perform testing

Using Ansible to (1) retrieve operational information from the Cisco IOS device
and (2) test that the whole team's configurations were applied correctly.

## Files

- `device_config/retrieve_device_info.yml` - retrieval playbook (show commands + ios_facts); writes `device_config/device_info_output.txt`
- `device_config/test_device_config.yml` - integration test; connectivity check + `assert` checks on the team's configs; writes `device_config/test_report_output.txt`
- `device_config/person5_sample_output.txt` - sample console output (proof)

## Run commands

```bash
ansible-galaxy collection install cisco.ios

# 1. Retrieve device information
ansible-playbook -i device_config/inventory.example.yml device_config/retrieve_device_info.yml

# 2. Run verification tests (AFTER the configuration playbooks have run)
ansible-playbook -i device_config/inventory.example.yml device_config/test_device_config.yml
```

Both playbooks use the shared inventory `device_config/inventory.example.yml`
and the `network_devices` host group, matching the rest of the project.

## What the testing playbook checks

- **TEST 1** - device is reachable over SSH before anything else.
- **TESTS 2-3** - Najmi's IP address (192.168.10.1) and interface description are present.
- **TESTS 4-6** - Abu's user account, MOTD banner, and static route (192.168.20.0) are present.

If any item is missing, the playbook stops at the failing assertion so the team
can see exactly what is misconfigured.
