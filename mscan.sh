#!/bin/bash
# simple script to masscan a host then pivot to nmap
#
# TODO: Add functionality to pivot to UDP in nmap if there's UDP ports found, though
#       I generally avoid this because nmap sucks at scanning UDP

echo "Enter ip address to scan"
read ipaddr
echo "inter interface to scan on"
read interf
masscan -p1-65535,U:1-65535 $ipaddr --rate=100 -e $interf > ports.txt
# isolate the PORT/PROTOCOL column, split that by the / to isolate the port number, sort in numerical order,
# then replace all newlines with commas and remove trailing comma so we have a valid port list to pass to nmap
ports=$(cat ports.txt | awk -F " " '{print $4}' | awk -F "/" '{print $1}' | sort -n | tr '\n' ',' | sed 's/,$//')

# wrap it up with an nmap scan
nmap -Pn -sV -sC -p$ports $ipaddr
