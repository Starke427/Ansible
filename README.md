# Ansible

These templates are intended to assist in streamlining Ansible playbook development and simplify roll-out for system administrators.

A full list of Ansible modules can be found at:
https://docs.ansible.com/ansible/latest/modules/modules_by_category.html

# hosts

This is an example hosts file, with the necessary varialbes set for Windows connections using WinRM and an NTLM username/password. There's also an example of parent:children relationships with linux referring to the deb and rpm groups.

# distribute_keys.sh

This script automates the distribution of ssh keys to hosts in an inventory file, such as an Ansible hosts file. The script should be executed with your inventory/hosts file as argument. It will then ask whether or not you need to create a new key or use one that already exists. It will then prompt you for the username you are configuring on the remote systems. It will then copy the public ssh key to the remote hosts under the designated user's login and will prompt you for a password for each host.

# FIM Validation

These playbooks automate the creation, modification, and deletion of a file on target hosts. This can be used to validate file integrity monitoring solutions.
