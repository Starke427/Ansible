#!/bin/bash

# This script copys ssh keys to remote hosts for easier and more secure SSH authentication.
# Author: Jeffrey Starke
#
# Usage: ./distribute_keys.sh <Inventory.txt>
#

####DEV

echo ""
read -p "Would you like to create a new ssh key to distribute? [y/n]" r
if [ r == y ]; then
    echo "Creating new key..."
elif [ r == n ]; then
    read -p "What is the location of the key you would like to distribute?" KEY

###DEV

echo ""
echo "Please provide the absolute path to the inventory file you would like to copy ssh keys to."
echo "NOTE: This will only work for Linux hosts."
echo ""
read -p "Inventory file: " inventory
echo ""
echo "Please provide the username of the service account that will distribute the keys."
echo ""
read -p "Privledged user: " user
echo ""

KEY=~/.ssh/id_rsa
if [[ -f $KEY ]]; then
    echo "An ssh key already exists for the current user on this host."
    echo ""
    echo "Now beginning ssh key copy to remote hosts."
    echo ""
else
    echo "A new ssh key will need to be generated for the current user on this host."    
    ssh-keygen -b 4096 -f ~/.ssh/id_rsa
    echo "A new ssh key has been generated."
    echo "Now beginning ssh key copy to remote hosts."
    echo ""
fi

for ip in $(cat $inventory | grep -o '^[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'); do
        echo "Copying ssh key to $ip..."
        ssh-copy-id -i ~/.ssh/id_rsa.pub $user@$ip
done
