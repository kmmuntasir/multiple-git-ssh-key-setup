#!/bin/bash

source ./config.sh

echo "
[include]
    path = ~/.gitconfig_personal

[includeIf \"gitdir:$WORK_DIRECTORY\"]
    path = ~/.gitconfig_work
[safe]
	directory = *
" > $HOME/.gitconfig

echo "
[user]
    name = \"$PERSONAL_NAME\"
    email = $PERSONAL_EMAIL
[core]
    sshCommand = ssh -F ~/.ssh/config_personal" > $HOME/.gitconfig_personal

echo "
[user]
    name = \"$WORK_NAME\"
    email = $WORK_EMAIL
[core]
    sshCommand = ssh -F ~/.ssh/config_work" > $HOME/.gitconfig_work