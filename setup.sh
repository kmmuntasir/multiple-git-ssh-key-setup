#!/bin/bash

# Sourcing the variables
source ./config.sh

# Create the SSH keys
mkdir $HOME/.ssh # Only if it's not there already
ssh-keygen -t ed25519 -C "$PERSONAL_EMAIL" -f $HOME/.ssh/key_personal
ssh-keygen -t ed25519 -C "$WORK_EMAIL" -f $HOME/.ssh/key_work

# Start the SSH agent and add the keys
eval "$(ssh-agent -s)" # Raise the SSH flag!
ssh-add ~/.ssh/key_personal # Toss in your personal key
ssh-add ~/.ssh/key_work # And now the work key

# Create the SSH config files
echo "Host github.com
          HostName github.com
          Port 22
          User git
          IdentityFile ~/.ssh/key_personal" > $HOME/.ssh/config_personal
echo "Host github.com
          HostName github.com
          Port 22
          User git
          IdentityFile ~/.ssh/key_work" > $HOME/.ssh/config_work

# Set the permissions
sudo chmod 600 ~/.ssh/config_personal
sudo chmod 600 ~/.ssh/config_work

# Set the Git configurations
source ./set_git_config.sh

# Check the configurations
echo 'Personal Git Configuration:'
cd $HOME && git config --show-origin --get user.email

#echo 'Work Git Configuration:'
cd $WORK_DIRECTORY && git config --show-origin --get user.email