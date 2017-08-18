#!/bin/sh

deluser $1 &&
    logger -p info -t git Deleted user $1
