#!/bin/bash


echo "=========================="
echo "Sourcing the variables"
echo "=========================="
source ./config.sh

echo "=========================="
echo "Create the SSH keys"
echo "=========================="
mkdir $HOME/.ssh # Only if it's not there already
ssh-keygen -t ed25519 -C "$PERSONAL_EMAIL" -f $HOME/.ssh/key_personal
ssh-keygen -t ed25519 -C "$WORK_EMAIL" -f $HOME/.ssh/key_work

echo "=========================="
echo "Start the SSH agent and add the keys"
echo "=========================="
eval "$(ssh-agent -s)" # Raise the SSH flag!
ssh-add ~/.ssh/key_personal # Toss in your personal key
ssh-add ~/.ssh/key_work # And now the work key

echo "=========================="
echo "Create the SSH config files"
echo "=========================="
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

echo "=========================="
echo "Set the permissions"
echo "=========================="
sudo chmod 600 ~/.ssh/config_personal
sudo chmod 600 ~/.ssh/config_work

echo "=========================="
echo "Set the Git configurations"
echo "=========================="
source ./set_git_config.sh

echo "=========================="
echo "Check the Git configurations"
echo "=========================="
echo 'Personal Git Configuration:'
cd $PERSONAL_DIRECTORY && git config --show-origin --get user.email

echo 'Work Git Configuration:'
cd $WORK_DIRECTORY && git config --show-origin --get user.email