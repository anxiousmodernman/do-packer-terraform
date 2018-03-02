#!/bin/bash

# Add a user for yourself, if you're named coleman, like me.
adduser coleman

# Make a dir for ssh keys
mkdir /home/coleman/.ssh

# Packer runs these scripts as root during the build, so give ownership
# to the user.
chown -R coleman /home/coleman/.ssh 

# Give user the terrifying power of sudo. 1) Add them to the "wheel" group,
# and then 2) use sed to edit /etc/sudoers in-place to give the wheel group the
# ability to run sudo with no password. This is god mode. Use at your own risk. 
usermod -aG wheel coleman
sed -i '/%wheel/ s/%wheel.*/%wheel        ALL=(ALL)       NOPASSWD: ALL/ ' /etc/sudoers

