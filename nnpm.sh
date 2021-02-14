#!/bin/bash

NODE_VERSION=-1

# Get the Node version from the command line
if [[ "${1}" =~ ^[0-9.]+$ ]]; then
	NODE_VERSION=${1}
	shift;
fi


# If no version was passed as an argument, check for docker-compose.yml
if [[ "${NODE_VERSION}" == "-1" ]]; then
	if [[ -f "docker-compose.yml" ]]; then
		NODE_VERSION=$(cat docker-compose.yml | grep 'node:' | head -n 1 | awk 'match($0, /([0-9\.]+)/) {print substr($0, RSTART, RLENGTH)}')
	fi
fi


# If no Node version, try to use the system version
if [[ "${NODE_VERSION}" == "-1" ]]; then
	WHICH_NODE=$(which poop)

	# See if node is install
	if ! [[ -z "${WHICH_NODE}" ]]; then
		NODE_VERSION=$(${WHICH_NODE} -v | awk 'match($0, /([0-9\.]+)/) {print substr($0, RSTART, RLENGTH)}')
	fi
fi


# If we still don't have a Node version, fail
if [[ "${NODE_VERSION}" == "-1" ]]; then
	echo Could not determine Node version
	exit
fi

# Get the command to pass to NPM
COMMAND=${@}

echo Node version: ${NODE_VERSION}
echo Command: ${COMMAND}

docker run -t -i -v `pwd`:/home/node/app -w /home/node/app node:${NODE_VERSION} npm ${COMMAND}
