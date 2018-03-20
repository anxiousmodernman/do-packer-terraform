#!/bin/bash
# Add a user for yourself, if you're named coleman, like me.
echo $DIGITALOCEAN_USER
adduser $DIGITALOCEAN_USER

# Make a dir for ssh keys
mkdir /home/$DIGITALOCEAN_USER/.ssh

# Packer runs these scripts as root during the build, so give ownership
# to the user.
chown -R $USER /home/$DIGITALOCEAN_USER/.ssh 

# Give user the terrifying power of sudo. 1) Add them to the "wheel" group,
# and then 2) use sed to edit /etc/sudoers in-place to give the wheel group the
# ability to run sudo with no password. This is god mode. Use at your own risk. 
usermod -aG wheel $DIGITALOCEAN_USER
sed -i '/%wheel/ s/%wheel.*/%wheel        ALL=(ALL)       NOPASSWD: ALL/ ' /etc/sudoers

