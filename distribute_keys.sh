#!/bin/bash

# This script copies ssh keys to remote hosts for easier and more secure SSH authentication.
# Author: Jeffrey Starke
#
# Usage: ./distribute_keys.sh <Inventory_File>
# Note: The inventory file can be parsed from an ansible hosts file.

inventory=$1

echo ""
read -p "Would you like to create a new ssh key to distribute? [y/n] " r
if [ $r == y ]; then
    echo ""
    read -p "What would you like to name the key? " name
    echo "Creating new key..."
    ssh-keygen -b 4096 -f ~/.ssh/$name
    echo ""
    echo "Your new key is located at ~/.ssh/$name."
    KEY=~/.ssh/$name.pub
elif [ $r == n ]; then
    echo ""
    read -p "What is the absolute path to the public key you would like to distribute? " KEY
fi

echo ""
echo "Please provide the username of the service account that will distribute the public keys."
echo ""
read -p "Privledged user: " user
echo ""

echo ""
read -p "Does the service account have the same password across the whole inventory? [y/n] " re
if [ $re == y ]; then
    echo ""
    read -p "What is the shared password? " PASS
    for ip in $(cat $inventory | grep -o '^[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'); do
        echo "~~~~~ Copying ssh key to $ip... ~~~~~"
        echo "$PASS" | ssh-pass ssh-copy-id -i $KEY $user@$ip
    done
elif [ $re == n ]; then
    echo ""
    for ip in $(cat $inventory | grep -o '^[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'); do
        echo "~~~~~ Copying ssh key to $ip... ~~~~~"
        ssh-copy-id -i $KEY $user@$ip
    done
fi
