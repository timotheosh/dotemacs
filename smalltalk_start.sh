#!/bin/bash
STPATH=~/.nix-profile/bin
STUSER='login'
STPASS='1234'
STPORT=9092
${STPATH}/gst-load -iI shampoo.im Shampoo
${STPATH}/gst-remote -I shampoo.im --daemon
sleep 3
${STPATH}/gst-remote -e "Shampoo.ShampooServer startOn: ${STPORT} \
         login: '${STUSER}' pass: '${STPASS}'"
echo "Shampoo daemon running. Connect with ${STUSER}@localhost:${STPORT} and then enter your password."
