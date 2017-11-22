#!/bin/bash

# https://docs.docker.com/compose/install/#install-compose

install__compose() {

    # Run this command to download the latest version of Docker Compose:
    sudo curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

    # Apply executable permissions to the binary:
    sudo chmod +x /usr/local/bin/docker-compose
}