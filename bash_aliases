#! /bin/bash

source ${HOME}/.env.sh
source /home/anastasia/.local/bin/virtualenvwrapper.sh

export WORKON_HOME=~/venvs

# Will load the following variables
# USERNAME: current username
# DOMAIN: domain for connecting to PC
# SSH_SERVER: ssh server for tunneling
# SSH_CONN_NAME: name of preffered ssh connection (see ~/.ssh/config)
# SSH_CONN_PORTi: ssh port for given connection (see ~/.ssh/config)
# SSHFS_PORT: port for mounting (see ~/.ssh/config)
# SCARD_ID: current smart card (for RDP)
# # TODO: automate parsing a smart card ID with grepi/sed/awk?
# MOUNT_FOLDER: folder to mount remote files


if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
  
  # Add git completion to aliases
  __git_complete g __git_main
  __git_complete gc _git_checkout
  __git_complete gm __git_merge
  __git_complete gp _git_pull
fi

if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    . /usr/share/git-core/contrib/completion/git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=true
    PS1='\[\033[01;32m\][\!] \u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[0;33m\] \[\033[0;33m\]$(__git_ps1 "(%s)") \[\033[00m\]\$ '
fi

# Make sure you actually have those aliases defined, of course.
alias g="git"
alias gc="git checkout"
alias gm="git merge"
alias gp="git pull"
alias gmm="git commit -m "
alias gA="git add -A"
alias gs="git status"

# start ssh daemon
pcscd

# scan for smart cards
alias smartcardscan="pcsc_scan"

# from NCBI confluence page
alias sshncbi="ssh -C -Y -I /usr/lib/x86_6shfs log-linux-gnu/opensc-pkcs11.so ${USERNAME}@${SSH_SERVER}"

# my inventions :)
alias sshfsmnt="sudo sshfs -o allow_other -p ${SSHFS_PORT} ${USERNAME}@localhost:/home/${USERNAME}/ ${MOUNT_FOLDER}"
alias usshfsmnt="sudo umount ${MOUNT_FOLDER}"

# http://stackoverflow.com/questions/3510673/find-and-kill-a-process-in-one-line-using-bash-and-regex

# create ssh tunnel in the background
alias sshb="ssh -nfNT ${SSH_CONN_NAME}"

# kill ssh process
alias sshkill="pkill -f 'ssh -nfNT ${SSH_CONN_NAME}'"

# restart ssh process
alias sshr="sshkill && sshb"

alias rd_user="rdesktop -u ${USERNAME} -d ${DOMAIN} -g 1680x1050 localhost:${SSH_CONN_PORT}"
alias rd="rdesktop -r scard:\"${SCARD_ID}\" -g 1680x1050 localhost:${SSH_CONN_PORT}"

# ssh keys
alias sshkey="ssh-keygen -t rsa -b 4096"
