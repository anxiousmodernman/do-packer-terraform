#!/bin/bash

# key should exist
# cat to authorized keys
cat /home/coleman/.ssh/id_rsa.pub >> /home/coleman/.ssh/authorized_keys
# change permissions on everything
chmod 0700 /home/coleman/.ssh
chmod 0644 /home/coleman/.ssh/authorized_keys
chmod 0644 /home/coleman/.ssh/id_rsa.pub

# restart sshd
service sshd restart
