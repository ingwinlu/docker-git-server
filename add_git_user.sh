#!/bin/sh

adduser -h /git/data/users/$1 -g "" -D -s /usr/bin/git-shell $1 &&
    echo "$1:*" | chpasswd 2> /dev/null &&
    echo "$2" >> /git/data/users/$1/.ssh/authorized_keys &&
    chown -R $1:$1 /git/data/users/$1 &&
    chmod 700 /git/data/users/$1/.ssh &&
    chmod -R 600 /git/data/users/$1/.ssh/* &&
    logger -p info -t git Added user $1
