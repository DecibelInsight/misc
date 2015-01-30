#!/bin/bash
#
# File:   remoteControl.bash
# Author: Nikolay Dimitrov
#
# Copies files to list of remote servers and executes bash script remotely on 
# the same servers. It creates a sub-directory or empties it and writes the
# output and error files there.
#
# USAGE:
#   remoteControl.bash <server.list> <file.list> [<commands.sh>]
# WHERE: 
#   <server.list>   list of server names
#   <file.list>		list of files to be copied or - (hyphen) for no files
#   <commands.sh>	[optional] contains the commands to be executed
#

if [ $# -lt 2 ]; then
	echo "Invalid arguments"
	exit 1
fi

SERVERS=$(cat $1)

mkdir -p output
rm -rf output/*

for server in $SERVERS; do

	echo "Initialising $server"
	./remoteServer.bash $server $2 $3 2>./output/$server.err >./output/$server.out &
done

echo "Waiting for tasks to complete..."
wait
echo
echo "Done!"
echo 
