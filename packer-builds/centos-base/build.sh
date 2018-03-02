#!/bin/bash

# Copy public key
cp $HOME/.ssh/id_rsa.pub .

# Execute packer build. The json file can be named anything.
packer build base.json 

# Clean up public key
rm id_rsa.pub
