nnpm
====

Checks `docker-compose.yml` for the NodeJS version being used in a container and runs the NPM command inside a Docker container for the specified NodeJS version.  This is useful if you have the NodeJS script/app in a local directory on the host but run it with a different version of NodeJS in the Docker container.

Installation
------------

1. Copy the script to `/usr/local/bin`: `cp nnpm.sh /usr/local/bin/nnpm`
2. Make the script executable: `chmod +x /usr/local/bin/nnpm`
