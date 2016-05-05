#!/usr/bin/env bash

# Update Repositories
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo apt-get install -y python-software-properties
sudo apt-get install -y python-dev
# Add Ansible Repository & Install Ansible
sudo apt-get update
sudo apt-get install -y ansible

# Setup Ansible for Local Use and Run
sudo cp /home/vagrant/ansible/inventories/dev /etc/ansible/hosts -f
sudo chmod 0666 /etc/ansible/hosts
mkdir /home/vagrant/.ssh
cat /home/vagrant/ansible/files/authorized_keys >> /home/vagrant/.ssh/authorized_keys
sudo ansible-playbook /home/vagrant/ansible/playbook.yml -e hostname=$1 --connection=local
