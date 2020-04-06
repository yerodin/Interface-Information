#!/bin/bash
#Interface Information (if-i)

iface=$1
attrib=$2

#validate iface
#validate attrib

if [ "$iface" = "" ]
then
	echo "Please select an interface."
	ip a show | grep "<" | cut -d: -f2 | cut -d" " -f2
	exit
fi

if [ "$attrib" = "show" ] || [ "$attrib" = "" ]
then
	ip a show "$iface"
	exit
elif [ "$attrib" = "ip" ]
then
	ip a show "$iface" | grep "inet " | cut -d: -f2 | awk '{print $2}'
	exit
elif [ "$attrib" = "gateway" ]
then
	ip route | grep default | grep "$iface" | cut -dd  -f2 | awk '{print $3}'
	exit
elif [ "$attrib" = "subnet" ]
then
	ip route | grep src | grep "$iface" | awk '{print $1}'
	exit
else
	echo "\"$attrib\" is not a valid attribute of an interface."
	echo "Please select an attribute of the select interface. ATTRIBUTES:(ip | subnet | gateway)"
	exit
fi