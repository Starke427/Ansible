# Ansible

These templates are intended to assist in streamlining Ansible playbook development and simplify roll-out for system administrators.

# distribute_keys.sh

This script automates the distribution of ssh keys to hosts in an inventory file, such as an Ansible hosts file. The script should be executed with your inventory/hosts file as argument. It will then ask whether or not you need to create a new key or use one that already exists. It will then prompt you for the username you are configuring on the remote systems. It will then copy the public ssh key to the remote hosts under the designated user's login and will prompt you for a password for each host.

This will be updated to include an ssh-pass command that will ask for the password once and pass it to ssh-copy-id.
