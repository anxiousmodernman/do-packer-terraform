#!/bin/bash

# key should exist
# cat to authorized keys
cat /home/$DIGITALOCEAN_USER/.ssh/id_rsa.pub >> /home/$DIGITALOCEAN_USER/.ssh/authorized_keys
# change permissions on everything
chmod 0700 /home/$DIGITALOCEAN_USER/.ssh
chmod 0644 /home/$DIGITALOCEAN_USER/.ssh/authorized_keys
chmod 0644 /home/$DIGITALOCEAN_USER/.ssh/id_rsa.pub

# restart sshd
service sshd restart
