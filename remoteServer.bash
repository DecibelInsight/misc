#!/bin/bash
#
# File:   remoteServer.bash
# Author: Nikolay Dimitrov
#
# Copies files to a remote server and executes bash script remotely on 
# the same server.
#
# USAGE:
#   remoteControl.bash <server> <file.list> [<commands.sh>]
# WHERE: 
#   <server>		remote server
#   <file.list>		is the list of files to be copied
#   <commands.sh>	[optional] contains the commands to be executed
#

if [ $# -lt 2 ]; then
	echo "Invalid arguments"
	exit 1
fi

echo ""
echo ""
echo "#"
echo "# Processing server $1"
echo "# -----------------------------------------"
echo ""

if [ "$2" != "-" ]; then
	# Copy all files to the current server
	while read line; do
		if [[ $line == \#* ]]; then
			continue
		fi
		args=($line)
		echo "Copying ${args[0]} to $1:${args[1]}"
		scp -r "${args[0]}" $1:${args[1]}
	done < $2
fi

#Execute the commands on the remote server
if [ $# -eq 3 ] && [ -e $3 ]; then
	ssh $1 'bash -s' < $3
fi

