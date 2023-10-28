#!/bin/bash

#Function to check and start the sesman service if not running
start_sesman() {
    if ! pgrep -x "xrdp-sesman" > /dev/null; then
        echo "xrdp-sesman not running. Starting sesman..."
        /usr/sbin/xrdp-sesman
    else
        echo "xrdp-sesman is already running."
    fi
}

#Set the password for the user 'user' to the value of USER_PASSWORD
echo "user:$USER_PASSWORD" | chpasswd

#Call the function to start sesman
start_sesman

#Start xrdp
/usr/sbin/xrdp -n

