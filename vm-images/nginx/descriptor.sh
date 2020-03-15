
#!/bin/bash

#
# Author: Deepak Bhardwaj - PG-Backflip
#
# Nginx Build Script for Ubuntu Xenial
#

#Step1:
#sudo apt update
#sudo apt-get -y install libguestfs-tools
#export LIBGUESTFS_BACKEND=direct

#Step2:
wget http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img

#Step3:
#install packages, copy files
# syntax: virt-customize -a [DOWNLOADED_FILE_NAME] --install [LIST_OF_PACKAGES]
#         virt-customize -a [DOWNLOADED_FILE_NAME] --run-command 'apt-get update'
#         virt-customize -a [DOWNLOADED_FILE_NAME] --mkdir [folder_name]
#         virt-customize -a [DOWNLOADED_FILE_NAME] --upload [src-file:dest-file]
#Run with sudo
virt-customize -a xenial-server-cloudimg-amd64-disk1.img \
      --run-command 'apt-get update' \
      --run-command 'DEBIAN_FRONTEND=noninteractive' \
      --run-command 'apt-get install -y \
                      net-tools \
                      iproute \
                      inetutils-ping \
                      iptables \
                      nginx \
                      python3 \
                      python \
                      python-yaml \
                      python3-pip \
                      curl' \
      --run-command 'cd /' \
      --upload nginx.conf:/etc/nginx/nginx.conf \
      --upload start.sh:/start.sh \
      --upload stop.sh:/stop.sh \
      --upload log_intf_statistics.py:/log_intf_statistics.py \
      --run-command 'chmod +x start.sh' \
      --run-command 'chmod +x stop.sh' \
      --run-command 'echo "manage_etc_hosts: true" >> /etc/cloud/cloud.cfg' \
      --mkdir /tngbench_share

      # normal entry point
#      CMD /bin/bash


# OpenStack command to add nginx image
#source /opt/stack/devstack/accrc/admin/admin
#openstack image create --public --disk-format qcow2 --container-format bare --file xenial-server-cloudimg-amd64-disk1.img nginx-vm
